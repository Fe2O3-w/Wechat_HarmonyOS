import router from '@ohos.router'
import WindowManager from '../../utils/WindowManager'

@Entry
@Preview
@Component
export default struct Service {
  build() {
    Column() {
      // 顶部返回栏
      Row() {
        Text("返回")
          .fontSize(17)
          .onClick(() => {
            router.back()
          })

        Text("服务")
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 110 })

        Blank()
      }
      .width("100%")
      .height(50)
      .padding({ left:15, right:15 })
      .backgroundColor(Color.White)
      .alignItems(VerticalAlign.Center)

      // 绿色区域
      Row() {
        Column() {
          Image($r('app.media.shoufukuan'))
            .width(40)
            .height(40)
          Text("收付款")
            .fontSize(16)
            .fontColor(Color.White)
            .margin({ top: 6 })
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)

        Column() {
          Image($r('app.media.qianbao'))
            .width(40)
            .height(40)
          Text("钱包")
            .fontSize(16)
            .fontColor(Color.White)
            .margin({ top: 6 })
          Text("¥999.99")
            .fontSize(14)
            .fontColor("#a5e9ad")
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      }
      .width("100%")
      .height(140)
      .backgroundColor("#07c160")
      .borderRadius(12)
      .margin(12)

      // ==========================
      // 金融理财
      // ==========================
      Column() {
        Text("金融理财")
          .fontSize(15)
          .fontColor("#666")
          .margin({ left:15, top:15, bottom:10 })
          .alignSelf(ItemAlign.Start)

        Flex({ wrap: FlexWrap.Wrap }) {
          // 信用卡还款
          Column() {
            Image($r('app.media.xinyongka'))
              .width(25)
              .height(25)
            Text("信用卡还款")
              .fontSize(13)
              .margin({ top:6 })
          }
          .width("25%")

          // 理财通
          Column() {
            Image($r('app.media.licaitong'))
              .width(25)
              .height(25)
            Text("理财通")
              .fontSize(13)
              .margin({ top:6 })
          }
          .width("25%")

          // 保险服务
          Column() {
            Image($r('app.media.baoxianfuwu'))
              .width(25)
              .height(25)
            Text("保险服务")
              .fontSize(13)
              .margin({ top:6 })
          }
          .width("25%")
        }
        .width("100%")
        .padding({ bottom:15 })
      }
      .width("100%")
      .backgroundColor(Color.White)
      .borderRadius(12)
      .margin({ left:12, right:12, top:12 })

      // ==========================
      // 生活服务
      // ==========================
      Column() {
        Text("生活服务")
          .fontSize(15)
          .fontColor("#666")
          .margin({ left:15, top:15, bottom:10 })
          .alignSelf(ItemAlign.Start)


        Flex({ wrap: FlexWrap.Wrap }) {
          Column() { Image($r('app.media.shoujichongzhi')).width(25).height(25); Text("手机充值").fontSize(13).margin({ top:6 }) }.width("25%").margin({ bottom: 20 })
          Column() { Image($r('app.media.shenghuojiaofei')).width(25).height(25); Text("生活缴费").fontSize(13).margin({ top:6 }) }.width("25%").margin({ bottom: 20 })
          Column() { Image($r('app.media.Qbichongzhi')).width(25).height(25); Text("Q币充值").fontSize(13).margin({ top:6 }) }.width("25%").margin({ bottom: 20 })
          Column() { Image($r('app.media.chengshifuwu')).width(25).height(25); Text("城市服务").fontSize(13).margin({ top:6 }) }.width("25%").margin({ bottom: 20 })
          Column() { Image($r('app.media.tengxungongyi')).width(25).height(25); Text("腾讯公益").fontSize(13).margin({ top:6 }) }.width("25%").margin({ bottom: 20 })
          Column() { Image($r('app.media.yiliaojiankang')).width(25).height(25); Text("医疗健康").fontSize(13).margin({ top:6 }) }.width("25%").margin({ bottom: 20 })
        }
        .width("100%")
        .padding({ bottom:15 })
      }
      .width("100%")
      .backgroundColor(Color.White)
      .borderRadius(12)
      .margin({ left:12, right:12, top:12 })

      Blank()
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f5f5f5")
    .padding({ top: WindowManager.statusBarHeight })
  }
}