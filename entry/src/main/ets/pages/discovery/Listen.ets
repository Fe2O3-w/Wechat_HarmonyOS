import router from '@ohos.router';

interface TodayItem {
  img: Resource
  title: string
  subtitle: string
}

interface MusicianItem {
  name: string
  cover: Resource
}

interface SongItem {
  pic: Resource
  title: string
  subtitle: string
}

const todayData: TodayItem[] = [
  { img: $r('app.media.t1'), title: "朋友推荐", subtitle: "孙琬婷分享" },
  { img: $r('app.media.t2'), title: "今日推荐", subtitle: "偏爱" }
];

const musicianData: MusicianItem[] = [
  { name: "方大同", cover: $r('app.media.m1') },
  { name: "范玮琪", cover: $r('app.media.m2') },
  { name: "梁静茹", cover: $r('app.media.m3') },
  { name: "周杰伦", cover: $r('app.media.m4') },
  { name: "陈绮贞", cover: $r('app.media.m5') },
  { name: "孙燕姿", cover: $r('app.media.m6') }
];

const songData: SongItem[] = [
  { pic: $r('app.media.s1'), title: "一人一首成名曲", subtitle: "#00~09#回忆#青春" },
  { pic: $r('app.media.s2'), title: "热门歌曲", subtitle: "" },
  { pic: $r('app.media.s3'), title: "赶在日落前散个步", subtitle: "" },
  { pic: $r('app.media.s4'), title: "学习专注BGM", subtitle: "" },
  { pic: $r('app.media.s5'), title: "春日气息", subtitle: "" },
  { pic: $r('app.media.s6'), title: "欢快旋律抖腿必备", subtitle: "" }
];

@Entry
@Component
struct Listen {
  build() {
    Column() {

      // 顶部导航栏
      Row() {
        Image($r('app.media.ic_back_black'))
          .width(24)
          .height(24)
          .onClick(() => router.back())

        Text("听一听")
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 16 })
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Blank()

        Image($r('app.media.men'))
          .width(24)
          .height(24)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // 搜索栏
      Row() {
        Image($r('app.media.search'))
          .width(20)
          .height(20)

        Text("搜索")
          .fontSize(16)
          .fontColor('#999')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Blank()

        Image($r('app.media.shake'))
          .width(20)
          .height(20)
      }
      .width('95%')
      .height(40)
      .padding({ left: 12, right: 12 })
      .backgroundColor('#F5F5F5')
      .borderRadius(20)
      .margin({ top: 12, bottom: 16 })

      // 可滚动内容
      Scroll() {
        Column() {

          // 今天
          Text("今天")
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .margin({ left: 20, bottom: 12 })

          Row() {
            Column() {
              Image(todayData[0].img)
                .width(160)
                .height(160)
                .borderRadius(12)

              Text(todayData[0].title)
                .fontSize(16)
                .margin({ top: 5 })

              Text(todayData[0].subtitle)
                .fontSize(12)
                .margin({ top: 8 })
                .fontColor('#999')
            }
            .alignItems(HorizontalAlign.Start)
            .width(160)

            Column() {
              Image(todayData[1].img)
                .width(160)
                .height(160)
                .borderRadius(12)

              Text(todayData[1].title)
                .fontSize(16)
                .margin({ top: 8 })

              Text(todayData[1].subtitle)
                .fontSize(12)
                .margin({ top: 5 })
                .fontColor('#999')
            }
            .alignItems(HorizontalAlign.Start)
            .width(160)
            .margin({ left: 20 })
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
          .margin({ left: 16, bottom: 40 })

          // 推荐音乐人
          Text("推荐音乐人")
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .margin({ left: 16, bottom: 10 })

          Swiper() {
            ForEach(musicianData, (item: MusicianItem) => {
              Column() {
                Image(item.cover)
                  .width(160)
                  .height(160)
                  .borderRadius(22)

                Text(item.name)
                  .fontSize(16)
                  .margin({ top: 8 })
              }
              .width(160)
              .alignItems(HorizontalAlign.Start)
            })
          }
          .width('100%')
          .height(200)
          .autoPlay(false)
          .loop(false)
          .indicator(false)
          .displayCount(2)
          .itemSpace(16)
          .margin({ left: 16, bottom: 40 })

          // 推荐歌单
          Row() {
            Text("推荐歌单")
              .fontSize(22)
              .fontWeight(FontWeight.Bold)

            Blank()

            Text("+ 创建歌单")
              .fontSize(14)
              .fontColor("#ff08304a")
          }
          .width('100%')
          .padding({ left: 14, right: 16 })
          .margin({ bottom: 12 })

          Swiper() {
            ForEach(songData, (item: SongItem) => {
              Column() {
                Image(item.pic)
                  .width(160)
                  .height(160)
                  .borderRadius(22)

                Text(item.title)
                  .fontSize(16)
                  .margin({ top: 8 })

                Text(item.subtitle)
                  .fontSize(16)
                  .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.Start)
              .width(160)
            })
          }
          .width('100%')
          .height(220)
          .autoPlay(false)
          .loop(false)
          .indicator(false)
          .displayCount(2)
          .itemSpace(16)
          .margin({ left: 16, bottom: 40 })

          // 探索
          Text("探索")
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .margin({ left: 16, bottom: 12 })

          Row() {
            Column() {
              Image($r('app.media.music'))
                .width(30)
                .height(30)

              Text("现场音乐")
                .fontSize(15)
                .margin({ top: 18 })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)

            Column() {
              Image($r('app.media.zone'))
                .width(30)
                .height(30)

              Text("乐迷圈")
                .fontSize(15)
                .margin({ top: 18 })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
          }
          .width('100%')
          .padding({ left: 40, right: 40, bottom: 40 })

        }
        .width('100%')
      }
      .layoutWeight(1)

      // 底部播放栏
      Row() {
        Image($r('app.media.listen'))
          .width(50)
          .height(50)
          .borderRadius(8)

        Column() {
          Text("Love Songs(Bonus)")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)

          Text("Kaash Paige")
            .fontSize(12)
            .fontColor(Color.Grey)
        }
        .margin({ left: 12 })
        .alignItems(HorizontalAlign.Start)

        Blank()

        Image($r('app.media.start'))
          .width(30)
          .height(30)
      }
      .width('100%')
      .height(70)
      .padding({ left: 16, right: 16 })
      .backgroundColor("#ffd3d3d6")

    }
    .width('100%')
    .height('100%')
    .backgroundColor("#fff")
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

export default Listen;
