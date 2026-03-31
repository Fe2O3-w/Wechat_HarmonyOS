import router from '@ohos.router';

@Entry
@Component
struct SettingsPage {
  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Image($r('app.media.ic_back_black'))
          .width(20)
          .height(20)
          .onClick(() => {
            router.back()
          })
        Text('设置')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Blank()
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // 设置列表
      List() {
        ForEach([
          '个人资料', '账号安全', '未成年人模式', '关怀模式',
          '通知', '聊天', '设备', '通用'
        ], (item:string) => {
          ListItem() {
            Row() {
              Text(item)
                .fontSize(17)
              Blank()
              Image($r('app.media.ic_more'))
                .width(18)
                .height(18)
            }
            .width('100%')
            .padding(16)
            .backgroundColor(Color.White)
          }
        })

        // 隐私分组标题
        ListItem() {
          Text('隐私')
            .fontSize(14)
            .fontColor('#999999')
            .padding({ left: 16, top: 12, bottom: 12 })
            .width('100%')
            .backgroundColor('#F7F7F7')
        }

        ForEach([
          '朋友权限', '个人信息与权限', '个人信息收集清单', '第三方信息共享清单'
        ], (item:string) => {
          ListItem() {
            Row() {
              Text(item)
                .fontSize(17)
              Blank()
              Image($r('app.media.ic_more'))
                .width(18)
                .height(18)
            }
            .width('100%')
            .padding(16)
            .backgroundColor(Color.White)
          }
        })

        // 插件栏
        ListItem() {
          Row() {
            Text('插件')
              .fontSize(17)
            Text('输入法「语音转文字」全面升级')
              .fontSize(14)
              .fontColor('#999999')
              .margin({ left: 16 })
            Blank()
            Image($r('app.media.ic_more'))
              .width(18)
              .height(18)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
        }

        ForEach([
          '关于微信', '帮助与反馈'
        ], (item:string) => {
          ListItem() {
            Row() {
              Text(item)
                .fontSize(17)
              Blank()
              Image($r('app.media.ic_more'))
                .width(18)
                .height(18)
            }
            .width('100%')
            .padding(16)
            .backgroundColor(Color.White)
          }
        })

        // 底部操作按钮
        ListItem() {
          Column() {
            Button('切换账号')
              .width('100%')
              .height(48)
              .backgroundColor(Color.White)
              .fontSize(18)
              .fontColor('#000000')
              .margin({ top: 12 })
            Button('退出')
              .width('100%')
              .height(48)
              .backgroundColor(Color.White)
              .fontSize(18)
              .fontColor('#FF3B30')
              .margin({ top: 1 })
          }
          .width('100%')
        }
      }
      .width('100%')
      .divider({ strokeWidth: 0.5, color: '#EEEEEE' })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F7F7')
  }
}