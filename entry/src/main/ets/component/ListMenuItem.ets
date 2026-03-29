@Preview
@Component
export default struct ListMenuItem {
  // 去掉 private，让外部可以传参
  iconSrc: Resource = $r('app.media.icon')
  title: string = ""
  news: string = ""
  newsIconSrc?: Resource
  itemClick?: () => void

  build() {
    Row() {
      Image(this.iconSrc)
        .width(25)
        .height(25)
        .margin({ right: 18 })

      Text(this.title)
        .fontColor(Color.Black)
        .fontSize(19)

      Blank()

      Text(this.news)
        .fontColor(Color.Gray)
        .fontSize(16)
        .margin({ right: 6 })

      if (this.newsIconSrc) {
        Image(this.newsIconSrc)
          .width(35)
          .height(35)
          .margin({ right: 6 })
          .borderRadius(4)
      }

      Image($r("app.media.ic_more"))
        .width(9)
        .height(16.364)
    }
    .width("100%")
    .height(60)
    .backgroundColor("#fff")
    .padding({ left: 15, right: 15 })
    .onClick(() => {
      if (this.itemClick) {
        this.itemClick()
      }
    })
  }
}