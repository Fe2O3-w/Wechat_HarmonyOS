import { ChatContentItemData } from '../pages/chat/ChatContentItemData'
import AudioRendererManager from '../utils/AudioRendererManager'

@Preview
@Component
export default struct ListChatContentLeftItem {
  private data?: ChatContentItemData

  build() {
    Row() {
      Image(this.data?.headSrc)
        .width(48)
        .height(48)
        .borderRadius(4)
        .margin({ left: 20, right: 8 })
        .objectFit(ImageFit.Cover)

      Path()
        .commands(`M${vp2px(10)} 0 L0 ${vp2px(7)} ${vp2px(10)} ${vp2px(14)} Z`)
        .fill('rgb(255,255,255)')
        .margin({ top: 19 })
        .strokeWidth(0)

      Row() {
        if (this.data?.msgType === 0) {
          // ── 文本消息 ──
          Text(this.data?.msg)
            .fontColor(Color.Black)
            .fontSize(18)
            .fontWeight(500)
            .borderRadius(4)
            .backgroundColor(Color.White)
            .padding({ left: 14, right: 14, top: 10, bottom: 10 })

        } else if (this.data?.msgType === 2) {
          // ── 语音消息 ──
          Row() {
            Text(this.data?.msg)
              .fontColor(Color.Black)
              .fontSize(18)
              .fontWeight(500)

            Image(this.data?.img)
              .width(28)
              .height(28)
              .margin({ left: 1 })
              .objectFit(ImageFit.Auto)
          }
          .padding({ left: 14, right: 14, top: 10, bottom: 10 })
          .borderRadius(4)
          .backgroundColor("#a9ea7a")
          .onClick(this.playVoice)

        } else {
          // ── 图片消息（msgType === 1）──
          // ✅ 优先使用动态 URI（相册/拍照），其次使用静态资源
          if (this.data?.imgUri) {
            Image(this.data.imgUri)
              .width(150)
              .borderRadius(4)
              .objectFit(ImageFit.Auto)
              .backgroundColor(Color.White)
          } else {
            Image(this.data?.img)
              .width(150)
              .borderRadius(4)
              .objectFit(ImageFit.Auto)
              .backgroundColor(Color.White)
          }
        }
      }
      .margin({ right: 80 })
      .layoutWeight(1)

    }.alignItems(VerticalAlign.Top)
  }

  playVoice = async () => {
    if (this.data?.voicePath) {
      AudioRendererManager.doPlay(this.data?.voicePath)
    }
  }

  aboutToDisappear(): void {
    AudioRendererManager.release()
  }
}
