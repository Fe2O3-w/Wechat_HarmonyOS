import ListMenuItem from '../../component/ListMenuItem'
import WechatToolbar from '../../component/WechatToolbar'
<<<<<<< HEAD
import router from '@ohos.router'   // ← 第一步：加这一行
=======
import router from '@ohos.router';
>>>>>>> 56b49ca3a1d1dfe7f2835d76bacad57086da3f7d
@Preview
@Component
export default struct Discovery {
  build() {
    Column() {
      WechatToolbar({ title: "发现" })

      ListMenuItem({ title: "朋友圈", iconSrc: $r('app.media.ic_moment') })
<<<<<<< HEAD
        .onClick(() => {
          router.pushUrl({
            url: 'pages/discovery/moments/MomentsPage'
          })
        })
=======
>>>>>>> 56b49ca3a1d1dfe7f2835d76bacad57086da3f7d

      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(10)
        .lineCap(LineCapStyle.Round)

      ListMenuItem({ title: "扫一扫",
        iconSrc: $r('app.media.ic_scan') })
        .onClick(() => {
        })

      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(1)
        .lineCap(LineCapStyle.Round)

      ListMenuItem({ title: "听一听",
        iconSrc: $r('app.media.ic_listen')
      })
<<<<<<< HEAD
=======
        .onClick(() => {
          // 重点：路径必须正确！
          router.pushUrl({ url: 'pages/discovery/Listen' });
        })
>>>>>>> 56b49ca3a1d1dfe7f2835d76bacad57086da3f7d

      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(10)
        .lineCap(LineCapStyle.Round)

      ListMenuItem({
        title: "游戏",
        news: "朋友瞬杀时刻",
        newsIconSrc: $r('app.media.ic_user_head1'),
        iconSrc: $r('app.media.ic_game')
      })

      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(10)
        .lineCap(LineCapStyle.Round)

      ListMenuItem({ title: "小程序",
        iconSrc: $r('app.media.ic_miniprogram')
      })

    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f0f0f0")
  }
}