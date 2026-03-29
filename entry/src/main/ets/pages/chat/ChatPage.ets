import router from '@ohos.router';
import Toolbar from '../../component/Toolbar';
import ListChatContentLeftItem from '../../component/ListChatContentLeftItem';
import ListChatContentRightItem from '../../component/ListChatContentRightItem';
import window from '@ohos.window';
import WindowManager from '../../utils/WindowManager';
import ChatFunctionBar from './ChatFuntionBar';
import { ChatContentItemData } from './ChatContentItemData';
import ChatPageParam from './ChatPageParam';
import { Toast } from '../../utils/Toast';
import SpeechRecognizerManager from '../../utils/SpeechRecognizerManager';
import { AudioCaptureManager, RecordFile } from '../../utils/AudioCapturerManager';
import { componentUtils } from '@kit.ArkUI';
import { vibrator } from '@kit.SensorServiceKit';
import { PermissionUtils } from '../../utils/PermissionUtils';
import EmojiPanel from '../../component/EmojiPanel';
import ChatMorePanel from '../../component/ChatMorePanel';

enum WXInputType {
  voice = 0,
  keyboard = 1
}

enum MessageType {
  voice = 0,
  text = 1
}

class ChatMessage {
  type: MessageType
  content: string
  time: string
  duration?: number
  translateText?: string
  isShowTranslateText: boolean = false

  constructor(type: MessageType, content: string, duration?: number, translateText?: string) {
    this.type = type
    this.content = content
    const date = new Date()
    this.time = `${date.getHours().toString().padStart(2, '0')}:${date.getMinutes().toString().padStart(2, '0')}`
    this.duration = duration
    this.translateText = translateText
  }
}

enum PressCancelVoicePostText {
  none = 0,
  pressing = 1,
  cancelVoice = 2,
  postText = 3
}

interface ScreenOffset {
  x: number
  y: number
  width: number
  height: number
}

@Entry
@Component
export default struct ChatPage {
  private name?: string = "微信"
  private controller: TextAreaController = new TextAreaController()
  private scroller: Scroller = new Scroller()
  @State private chatText: string = ''
  private keyboardHeight: number = 0
  @State private funcBarHeight: number = 0;
  @State private showFuncBar: boolean = false;

  // ✅ 新增：表情面板和更多面板的显示状态
  @State private showEmojiPanel: boolean = false;
  @State private showMorePanel: boolean = false;

  @State private dataList: ChatContentItemData[] = [
    {
      name: "鲁班",
      headSrc: $r("app.media.ic_user_head2"),
      msgType: 0,
      self: true,
      msg: "现在几点了？"
    },
    {
      name: "王昭君",
      headSrc: $r("app.media.ic_user_head3"),
      msgType: 0,
      self: false,
      msg: "10点，怎么了？"
    },
    {
      name: "鲁班",
      headSrc: $r("app.media.ic_user_head2"),
      msgType: 1,
      self: true,
      msg: "",
      img: $r("app.media.ic_its_over")
    },
    {
      name: "鲁班",
      headSrc: $r("app.media.ic_user_head2"),
      msgType: 0,
      self: true,
      msg: "我要迟到了！！！",
    },
    {
      name: "王昭君",
      headSrc: $r("app.media.ic_user_head3"),
      msgType: 1,
      self: false,
      msg: "",
      img: $r("app.media.ic_hahaha")
    },
    {
      name: "王昭君",
      headSrc: $r("app.media.ic_user_head3"),
      msgType: 0,
      self: false,
      msg: "那赶紧粗发吧，哈哈哈哈哈哈哈",
    },
    {
      name: "鲁班",
      headSrc: $r("app.media.ic_user_head2"),
      msgType: 0,
      self: true,
      msg: "嗯嗯，不说了，这就飞奔过去。。。",
    }
  ]

  @State textValue: string = ""
  @State inputType: WXInputType = WXInputType.keyboard
  @State voiceToText: string = ""
  @State chatList: ChatMessage[] = []
  @State showTalkContainer: boolean = false
  @State pressCancelVoicePostText: PressCancelVoicePostText = PressCancelVoicePostText.none
  settings: RenderingContextSettings = new RenderingContextSettings(true)
  context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  voiceTimeId: number = -1
  bubbleScreenOffset: ScreenOffset = { x: 0, y: 0, width: 0, height: 0 }
  recordFileName: string = ""

  sendTextMessage = () => {
    if (!this.textValue.trim()) return
    const chat = new ChatMessage(MessageType.text, this.textValue.trim())
    this.chatList.push(chat)
    this.textValue = ""
  }

  onPressTalk = async (event: TouchEvent) => {
    if (event.type === TouchType.Down) {
      this.pressCancelVoicePostText = PressCancelVoicePostText.pressing
      this.showTalkContainer = true
      this.startVibration()
      this.onStartRecord()
      this.onStartSpeechRecognize()
    } else if (event.type === TouchType.Move) {
      this.pressCancelVoicePostText = PressCancelVoicePostText.pressing
      const x = event.touches[0].displayX
      const y = event.touches[0].displayY
      let isTouchX = x <= this.bubbleScreenOffset.width / 2 && y < this.bubbleScreenOffset.y
      let isTouchText = x > this.bubbleScreenOffset.width / 2 && y < this.bubbleScreenOffset.y
      if (isTouchX) {
        this.pressCancelVoicePostText = PressCancelVoicePostText.cancelVoice
      } else if (isTouchText) {
        this.pressCancelVoicePostText = PressCancelVoicePostText.postText
      }
    } else if (event.type === TouchType.Up) {
      this.showTalkContainer = false
      const res = await this.stopRecord()
      SpeechRecognizerManager.release()
      if (this.pressCancelVoicePostText === PressCancelVoicePostText.postText) {
        this.postText()
      } else if (this.pressCancelVoicePostText === PressCancelVoicePostText.cancelVoice) {
        this.voiceToText = ''
      } else {
        this.postVoice(res)
      }
    }
  }

  async aboutToAppear() {
    this.name = (router.getParams() as ChatPageParam).name
    await window.getLastWindow(getContext(this)).then(currentWindow => {
      currentWindow.on('keyboardHeightChange', (height) => {
        this.keyboardHeight = height;
        // ✅ 键盘弹出时，收起表情/更多面板
        if (height > 0) {
          this.showEmojiPanel = false
          this.showMorePanel = false
        }
      })
    })
  }

  onBackPress() {
    // ✅ 如果面板打开，先关闭面板
    if (this.showEmojiPanel || this.showMorePanel) {
      this.showEmojiPanel = false
      this.showMorePanel = false
      return true
    }
    return this.keyboardHeight > 0
  }

  onStartRecord = () => {
    this.recordFileName = Date.now().toString()
    AudioCaptureManager.startRecord(this.recordFileName)
  }

  stopRecord = async () => {
    const res = await AudioCaptureManager.stopRecord()
    return res
  }

  postVoice = (res: RecordFile) => {
    const duration = Math.ceil((res.endRecordTime - res.startRecordTime) / 1000)
    const voiceChat = new ChatMessage(MessageType.voice, res.recordFilePath, duration)
    this.chatList.push(voiceChat)
    this.dataList.push({
      name: "鲁班",
      headSrc: $r("app.media.ic_user_head2"),
      msgType: 2,
      voicePath: res.recordFilePath,
      self: true,
      msg: `${duration}"`,
      img: $r("app.media.ic_voice_msg_right")
    })
    this.scroller.scrollToIndex(this.dataList.length)
  }

  onStartSpeechRecognize = () => {
    let sentence = ""
    SpeechRecognizerManager.init((res) => {
      if (res.isFinal) {
        sentence += res.result
        this.voiceToText = sentence
      } else {
        this.voiceToText = sentence + res.result
      }
    })
  }

  postText = () => {
    const TextChat = new ChatMessage(MessageType.text, this.voiceToText)
    this.chatList.push(TextChat)
  }

  // ✅ 发送文本消息（含纯表情）
  private sendTextMsg() {
    if (!this.chatText.trim()) return
    this.dataList.push({
      name: "鲁班",
      headSrc: $r("app.media.ic_user_head2"),
      msgType: 0,
      self: true,
      msg: this.chatText,
    })
    this.scroller.scrollToIndex(this.dataList.length)
    this.chatText = ""
  }

  // ✅ 发送图片消息（相册或拍照选择的 URI）
  private sendImageMsg(uri: string) {
    this.dataList.push({
      name: "鲁班",
      headSrc: $r("app.media.ic_user_head2"),
      msgType: 1,
      self: true,
      msg: "",
      imgUri: uri,   // 使用 imgUri 字段存放动态URI
    })
    this.scroller.scrollToIndex(this.dataList.length)
  }

  // ✅ 切换表情面板
  private toggleEmojiPanel() {
    this.showEmojiPanel = !this.showEmojiPanel
    if (this.showEmojiPanel) {
      this.showMorePanel = false
      this.showFuncBarWithAnim(false)
      // 收起键盘
      this.controller.stopEditing()
    }
  }

  // ✅ 切换更多面板
  private toggleMorePanel() {
    if (!this.showMorePanel) {
      this.inputType = WXInputType.keyboard
    }
    this.showMorePanel = !this.showMorePanel
    if (this.showMorePanel) {
      this.showEmojiPanel = false
      this.controller.stopEditing()
    }
    this.showFuncBarWithAnim(false)
  }

  private showFuncBarWithAnim(show: boolean) {
    animateTo({ duration: 400, curve: Curve.Ease }, () => {
      if (show) {
        this.funcBarHeight = 250;
      } else {
        this.funcBarHeight = 0;
      }
      this.showFuncBar = show;
    })
  }

  build() {
    Column() {
      Toolbar({ title: this.name })

      List({ space: 20, initialIndex: this.dataList.length, scroller: this.scroller }) {
        ForEach(this.dataList, (item: ChatContentItemData) => {
          ListItem() {
            if (item.self) {
              ListChatContentRightItem({ data: item })
            } else {
              ListChatContentLeftItem({ data: item })
            }
          }
        })
        ListItem() {
          Row().height(px2vp(20))
        }
      }
      .width("100%")
      .layoutWeight(1)
      .onClick(() => {
        // ✅ 点击消息列表时，收起所有面板
        this.showEmojiPanel = false
        this.showMorePanel = false
      })

      // ──── 输入栏 ────
      Row() {
        if (this.inputType == WXInputType.keyboard) {
          Image($r("app.media.ic_use_voice"))
            .width(33)
            .height(33)
            .borderRadius(4)
            .margin({ left: 15, right: 15 })
            .objectFit(ImageFit.Cover)
            .onClick(async () => {
              const result = await PermissionUtils.request(["ohos.permission.MICROPHONE"])
              if (!result) {
                Toast.show("请先授权麦克风权限")
              }
              this.inputType = WXInputType.voice
              this.showFuncBarWithAnim(false)
            })

          TextArea({ text: $$this.chatText, placeholder: '', controller: this.controller })
            .placeholderFont({ size: 20, weight: 400 })
            .caretColor(Color.Green)
            .placeholderColor(Color.Grey)
            .layoutWeight(1)
            .padding({ left: 8, right: 8 })
            .fontSize(20)
            .fontColor(Color.Black)
            .borderRadius(8)
            .stateStyles({
              normal: { .backgroundColor(Color.White) },
              pressed: { .backgroundColor(Color.White) },
              clicked: { .backgroundColor(Color.White) },
              focused: { .backgroundColor(Color.White) }
            })
            .onFocus(() => {
              // ✅ 输入框获取焦点时，收起两个面板
              this.showEmojiPanel = false
              this.showMorePanel = false
            })

        } else {
          Image($r("app.media.ic_use_keyboard"))
            .width(33)
            .height(33)
            .borderRadius(4)
            .margin({ left: 15, right: 15 })
            .objectFit(ImageFit.Cover)
            .onClick(() => {
              this.inputType = WXInputType.keyboard
            })

          Button("按住 说话")
            .fontColor(Color.Black)
            .layoutWeight(1)
            .type(ButtonType.Normal)
            .borderRadius(8)
            .backgroundColor(Color.White)
            .fontSize(18)
            .bindContentCover($$this.showTalkContainer, this.buildRecordVoiceView,
              { modalTransition: ModalTransition.NONE })
            .onTouch(this.onPressTalk)
        }

        // ✅ 表情按钮：点击切换表情面板，面板打开时图标变为键盘图标
        Image(this.showEmojiPanel
          ? $r("app.media.ic_use_keyboard")
          : $r("app.media.ic_emoji_pack"))
          .width(33)
          .height(33)
          .borderRadius(4)
          .margin({ left: 15, right: 5 })
          .objectFit(ImageFit.Cover)
          .onClick(() => {
            this.toggleEmojiPanel()
          })

        // ✅ 发送按钮（有文字时显示）
        Text("发送")
          .fontColor(Color.White)
          .width(65)
          .textAlign(TextAlign.Center)
          .height(36)
          .backgroundColor("#58BE6A")
          .fontSize(18)
          .visibility(this.chatText.length == 0 ? Visibility.None : Visibility.Visible)
          .borderRadius(6)
          .margin({ left: 10, right: 10 })
          .onClick(() => {
            this.sendTextMsg()
          })

        // ✅ 更多按钮（无文字时显示）
        Image($r("app.media.ic_add"))
          .width(33)
          .height(33)
          .borderRadius(4)
          .visibility(this.chatText.length == 0 ? Visibility.Visible : Visibility.None)
          .margin({ left: 15, right: 8 })
          .objectFit(ImageFit.Cover)
          .onClick(() => {
            this.toggleMorePanel()
          })
      }
      .padding({ top: 10, bottom: 10 })
      .alignItems(VerticalAlign.Bottom)
      .backgroundColor("#f9f9f9")

      Divider()
        .vertical(false)
        .color("#f0f0f0")
        .strokeWidth(1)
        .lineCap(LineCapStyle.Round)

      // ✅ 表情面板（与更多面板互斥）
      if (this.showEmojiPanel) {
        EmojiPanel({
          onEmojiClick: (emoji: string) => {
            if (emoji === 'DELETE') {
              // ✅ 用正则处理多字节 emoji 退格，兼容 ArkTS
              if (this.chatText.length > 0) {
                const match = this.chatText.match(/[\s\S]$/u)
                if (match) {
                  this.chatText = this.chatText.slice(0, this.chatText.length - match[0].length)
                }
              }
            } else {
              this.chatText += emoji
            }
          }
        })
      }

      // ✅ 更多面板（相册/拍照）
      if (this.showMorePanel) {
        ChatMorePanel({
          onImageSelected: (uri: string) => {
            this.sendImageMsg(uri)
            this.showMorePanel = false
          }
        })
      }

      // 原有功能栏（暂时保留，高度为0时不显示）
      ChatFunctionBar()
        .height(this.funcBarHeight)

    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f1f1f1")
    .padding({ bottom: WindowManager.navBarHeight })
    // ✅ 移除 expandSafeArea(KEYBOARD)，防止键盘弹起时把表情/更多面板往上推
    // 输入框通过 TextArea 自身响应键盘，面板固定高度贴底不受影响
  }

  @Builder
  buildRecordVoiceView() {
    Column() {
      Row() {
        if (this.pressCancelVoicePostText !== PressCancelVoicePostText.postText) {
          this.vocalPrint()
        } else {
          Scroll() {
            Text(this.voiceToText)
              .fontSize(12)
              .fontColor("#666")
          }
          .width("100%")
          .height("100%")
        }

        Text()
          .width(10)
          .height(10)
          .backgroundColor(this.pressCancelVoicePostText === PressCancelVoicePostText.cancelVoice ? Color.Red : "#95EC6A")
          .position({ bottom: -5, left: "50%" })
          .translate({ x: "-50%" })
          .rotate({ angle: 45 })
      }
      .width("50%")
      .height(80)
      .backgroundColor(this.pressCancelVoicePostText === PressCancelVoicePostText.cancelVoice ? Color.Red : "#95EC6A")
      .position({ top: "40%", left: "50%" })
      .translate({ x: "-50%" })
      .borderRadius(10)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Row() {
        Row() {
          Text("X")
            .fontSize(20)
            .width(80)
            .height(80)
            .borderRadius("50%")
            .fontColor(this.pressCancelVoicePostText === PressCancelVoicePostText.cancelVoice ? "#333" : Color.Gray)
            .backgroundColor(this.pressCancelVoicePostText === PressCancelVoicePostText.cancelVoice ? Color.White : "#333")
            .textAlign(TextAlign.Center)
            .align(Alignment.Center)
            .fontColor("#ccc")
            .id("cancel_record")
            .rotate({ angle: -15 })
        }

        Row() {
          Text("文")
            .fontSize(20)
            .width(80)
            .height(80)
            .borderRadius("50%")
            .fontColor(this.pressCancelVoicePostText === PressCancelVoicePostText.postText ? "#333" : Color.Gray)
            .backgroundColor(this.pressCancelVoicePostText === PressCancelVoicePostText.postText ? Color.White : "#333")
            .textAlign(TextAlign.Center)
            .align(Alignment.Center)
            .id("translate_text")
            .rotate({ angle: 15 })
        }

        Text(this.pressCancelVoicePostText === PressCancelVoicePostText.cancelVoice ? '取消发送' :
          (this.pressCancelVoicePostText === PressCancelVoicePostText.postText ? '转换文字' : "松开发送"))
          .fontColor("#fff")
          .width("100%")
          .position({ bottom: 0, left: 0 })
          .textAlign(TextAlign.Center)
      }
      .width("100%")
      .position({ bottom: "23%" })
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 35, right: 35 })

      Stack() {
        Text()
          .width(800)
          .height(800)
          .backgroundColor("#AAAAAA")
          .borderRadius("50%")
          .position({ top: 0, left: "50%" })
          .translate({ x: "-50%" })

        Image($r("app.media.ic_voice_msg_left"))
          .width(33)
          .height(33)
          .objectFit(ImageFit.Cover)
      }
      .width("100%")
      .height(150)
      .alignContent(Alignment.Center)
      .position({ bottom: 0 })
      .id("bottom_bubble")
      .onAppear(() => {
        let modePosition: componentUtils.ComponentInfo = componentUtils.getRectangleById("bottom_bubble");
        this.bubbleScreenOffset.x = px2vp(modePosition.localOffset.x)
        this.bubbleScreenOffset.y = px2vp(modePosition.localOffset.y)
        this.bubbleScreenOffset.width = px2vp(modePosition.size.width)
        this.bubbleScreenOffset.height = px2vp(modePosition.size.height)
      })
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#9F000000")
  }

  @Builder
  vocalPrint() {
    Canvas(this.context)
      .onDisAppear(() => { clearInterval(this.voiceTimeId) })
      .width('80%')
      .height('80%')
      .onReady(() => {
        clearInterval(this.voiceTimeId)
        this.voiceTimeId = setInterval(() => {
          this.context.clearRect(0, 0, 200, 200)
          for (let index = 0; index < 35; index++) {
            const random = Math.floor(Math.random() * 20)
            let height = 5 + random
            this.context.fillRect(10 + index * 5, 32 - height / 2, 2, height);
          }
        }, 100)
      })
  }

  private async startVibration() {
    try {
      vibrator.startVibration({ type: 'time', duration: 100 }, { id: 0, usage: 'touch' }, () => {})
    } catch (err) {}
  }
}
