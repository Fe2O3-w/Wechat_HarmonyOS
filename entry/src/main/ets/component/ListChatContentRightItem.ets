import { ChatContentItemData } from '../pages/chat/ChatContentItemData'
import AudioRendererManager from '../utils/AudioRendererManager'

@Preview
@Component
export default struct ListChatContentRightItem {
  data?: ChatContentItemData

  build() {
    Row() {
      Column() {
        if (this.data?.msgType == 0) {
<<<<<<< HEAD
=======
          // ── 文本消息 ──
>>>>>>> 56b49ca3a1d1dfe7f2835d76bacad57086da3f7d
          Text(this.data?.msg)
            .fontColor(Color.Black)
            .fontWeight(500)
            .fontSize(18)
<<<<<<< HEAD
            .padding({
              left: 14,
              right: 14,
              top: 10,
              bottom: 10
            })
            .borderRadius(4)
            .backgroundColor("#a9ea7a")
        } else if (this.data?.msgType === 2) {
=======
            .padding({ left: 14, right: 14, top: 10, bottom: 10 })
            .borderRadius(4)
            .backgroundColor("#a9ea7a")

        } else if (this.data?.msgType === 2) {
          // ── 语音消息 ──
>>>>>>> 56b49ca3a1d1dfe7f2835d76bacad57086da3f7d
          Row() {
            Text(this.data?.msg)
              .fontColor(Color.Black)
              .fontSize(18)
              .fontWeight(500)

            Image(this.data?.img)
              .width(28)
<<<<<<< HEAD
              .width(28)
              .margin({ left: 1 })
              .objectFit(ImageFit.Auto)
          }
          .padding({
            left: 14,
            right: 14,
            top: 10,
            bottom: 10
          })
=======
              .height(28)
              .margin({ left: 1 })
              .objectFit(ImageFit.Auto)
          }
          .padding({ left: 14, right: 14, top: 10, bottom: 10 })
>>>>>>> 56b49ca3a1d1dfe7f2835d76bacad57086da3f7d
          .borderRadius(4)
          .backgroundColor("#a9ea7a")
          .onClick(this.playVoice)

        } else {
<<<<<<< HEAD
          Image(this.data?.img)
            .width(150)
            .borderRadius(4)
            .objectFit(ImageFit.Auto)
            .backgroundColor("#a9ea7a")
=======
          // ── 图片消息（msgType === 1）──
          // ✅ 优先使用动态 URI（相册/拍照），其次使用静态资源
          if (this.data?.imgUri) {
            Image(this.data.imgUri)
              .width(150)
              .borderRadius(4)
              .objectFit(ImageFit.Auto)
              .backgroundColor("#a9ea7a")
          } else {
            Image(this.data?.img)
              .width(150)
              .borderRadius(4)
              .objectFit(ImageFit.Auto)
              .backgroundColor("#a9ea7a")
          }
>>>>>>> 56b49ca3a1d1dfe7f2835d76bacad57086da3f7d
        }
      }
      .margin({ left: 80 })
      .alignItems(HorizontalAlign.End)
      .layoutWeight(1)

      Path()
        .commands(`M0 0 L${vp2px(10)} ${vp2px(7)} 0 ${vp2px(14)} Z`)
        .fill('rgb(169,234,122)')
<<<<<<< HEAD
        .margin({
          top: 18
        })
=======
        .margin({ top: 18 })
>>>>>>> 56b49ca3a1d1dfe7f2835d76bacad57086da3f7d
        .strokeWidth(0)

      Image(this.data?.headSrc)
        .width(48)
        .height(48)
        .borderRadius(4)
        .margin({ left: 8, right: 20 })
        .objectFit(ImageFit.Cover)

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
<<<<<<< HEAD


=======
>>>>>>> 56b49ca3a1d1dfe7f2835d76bacad57086da3f7d
