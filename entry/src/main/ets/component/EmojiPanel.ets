// 微信同款表情面板
// - 搜索栏
// - 最近使用（最多16个）
// - 所有表情（按分组展示）
// - 底部分类标签栏 + 退格键

interface EmojiGroup {
  name: string
  icon: string
  emojis: string[]
}

@Component
export default struct EmojiPanel {
  onEmojiClick: (emoji: string) => void = () => {}

  private emojiGroups: EmojiGroup[] = [
    {
      name: '表情', icon: '😊',
      emojis: [
        '😀','😁','😂','🤣','😃','😄','😅','😆','😉','😊','😋','😎',
        '😍','😘','🥰','😗','😙','😚','🙂','🤗','🤩','🤔','🤨','😐',
        '😑','😶','🙄','😏','😣','😥','😮','🤐','😯','😪','😫','🥱',
        '😴','😌','😛','😜','😝','🤤','😒','😓','😔','😕','🙃','🤑',
        '😲','☹️','🙁','😖','😞','😟','😤','😢','😭','😦','😧','😨',
        '😩','🤯','😬','😰','😱','🥵','🥶','😳','🤪','😵','😡','😠',
        '🤬','😷','🤒','🤕','🤢','🤧','🥴','😇','🥳','🤠','🤡','🤥',
        '🤫','🤭','🧐','🤓','😈','👿','👹','👺','💀','☠️','👻','👽',
      ]
    },
    {
      name: '手势', icon: '👍',
      emojis: [
        '👋','🤚','🖐️','✋','🖖','👌','🤌','🤏','✌️','🤞','🤟','🤘',
        '🤙','👈','👉','👆','🖕','👇','☝️','👍','👎','✊','👊','🤛',
        '🤜','👏','🙌','👐','🤲','🤝','🙏','✍️','💅','🤳','💪','🦾',
      ]
    },
    {
      name: '爱心', icon: '❤️',
      emojis: [
        '❤️','🧡','💛','💚','💙','💜','🖤','🤍','🤎','💔','❣️','💕',
        '💞','💓','💗','💖','💘','💝','💟','✨','🔥','💫','⭐','🌟',
        '💥','❄️','🌈','☀️','🌊','🎉','🎊','🎈','🎁','🏆','🥇','🎵',
      ]
    },
    {
      name: '动物', icon: '🐶',
      emojis: [
        '🐶','🐱','🐭','🐹','🐰','🦊','🐻','🐼','🐨','🐯','🦁','🐮',
        '🐷','🐸','🐵','🙈','🙉','🙊','🐔','🐧','🐦','🐤','🦆','🦅',
        '🦉','🦇','🐺','🐗','🐴','🦄','🐝','🦋','🐌','🐞','🐜','🦗',
      ]
    },
    {
      name: '食物', icon: '🍎',
      emojis: [
        '🍎','🍊','🍋','🍇','🍓','🍒','🍑','🥭','🍍','🥥','🍆','🥑',
        '🌽','🍕','🍔','🍟','🌭','🍿','🥚','🍳','🥞','🧇','🥓','🍜',
        '🍣','🍱','🍛','🍲','🥗','🍰','🎂','🧁','🍩','🍪','🍫','🍦',
        '☕','🍵','🧃','🥤','🍺','🍷','🥂','🍸','🍹','🧉','🍾','🧊',
      ]
    },
  ]

  @State private activeGroup: number = 0
  @State private searchText: string = ''
  @State private recentEmojis: string[] = []
  @State private searchResult: string[] = []

  private getCurrentEmojis(): string[] {
    if (this.searchText.length > 0) {
      return this.searchResult
    }
    return this.emojiGroups[this.activeGroup].emojis
  }

  private handleEmojiClick(emoji: string) {
    // 更新最近使用
    const idx = this.recentEmojis.indexOf(emoji)
    if (idx !== -1) {
      this.recentEmojis.splice(idx, 1)
    }
    this.recentEmojis.unshift(emoji)
    if (this.recentEmojis.length > 16) {
      this.recentEmojis = this.recentEmojis.slice(0, 16)
    }
    this.onEmojiClick(emoji)
  }

  private handleSearch(text: string) {
    this.searchText = text
    if (!text) {
      this.searchResult = []
      return
    }
    // 搜索时展示所有表情（可后续加关键词词典精确匹配）
    const all: string[] = []
    for (const g of this.emojiGroups) {
      for (const e of g.emojis) {
        all.push(e)
      }
    }
    this.searchResult = all
  }

  // 计算网格高度（行数 × 44vp）
  private gridHeight(count: number): number {
    return Math.ceil(count / 8) * 44
  }

  build() {
    Column() {

      // ────────── 搜索栏 ──────────
      Row() {
        Text('🔍')
          .fontSize(15)
          .margin({ left: 10, right: 4 })
        TextInput({ placeholder: '搜索表情', text: this.searchText })
          .layoutWeight(1)
          .height(30)
          .fontSize(14)
          .placeholderFont({ size: 14 })
          .placeholderColor('#AAAAAA')
          .backgroundColor(Color.Transparent)
          .onChange((val: string) => {
            this.handleSearch(val)
          })
      }
      .height(40)
      .backgroundColor('#E0E0E0')
      .borderRadius(8)
      .margin({ left: 12, right: 12, top: 8, bottom: 4 })

      // ────────── 滚动内容区 ──────────
      Scroll() {
        Column() {

          // 最近使用
          if (this.recentEmojis.length > 0 && this.searchText.length === 0) {
            Text('最近使用')
              .fontSize(12)
              .fontColor('#999999')
              .width('100%')
              .padding({ left: 14, top: 6, bottom: 2 })

            Grid() {
              ForEach(this.recentEmojis, (emoji: string) => {
                GridItem() {
                  Text(emoji)
                    .fontSize(28)
                    .textAlign(TextAlign.Center)
                    .width('100%')
                    .height(44)
                    .onClick(() => { this.handleEmojiClick(emoji) })
                }
              })
            }
            .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr')
            .columnsGap(0)
            .rowsGap(0)
            .width('100%')
            .height(this.gridHeight(this.recentEmojis.length))
          }

          // 所有表情标题
          if (this.searchText.length === 0) {
            Text('所有表情')
              .fontSize(12)
              .fontColor('#999999')
              .width('100%')
              .padding({ left: 14, top: 6, bottom: 2 })
          }

          // 无搜索结果
          if (this.searchText.length > 0 && this.searchResult.length === 0) {
            Text('未找到相关表情')
              .fontSize(14)
              .fontColor('#AAAAAA')
              .width('100%')
              .textAlign(TextAlign.Center)
              .padding({ top: 24 })
          }

          // 表情网格
          if (this.getCurrentEmojis().length > 0) {
            Grid() {
              ForEach(this.getCurrentEmojis(), (emoji: string) => {
                GridItem() {
                  Text(emoji)
                    .fontSize(28)
                    .textAlign(TextAlign.Center)
                    .width('100%')
                    .height(44)
                    .onClick(() => { this.handleEmojiClick(emoji) })
                }
              })
            }
            .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr')
            .columnsGap(0)
            .rowsGap(0)
            .width('100%')
            .height(this.gridHeight(this.getCurrentEmojis().length))
          }

          Row().height(8)  // 底部留白
        }
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)

      // ────────── 底部分类栏 + 退格键 ──────────
      Row() {
        // 分类 tabs
        Scroll() {
          Row() {
            ForEach(this.emojiGroups, (group: EmojiGroup, idx: number) => {
              Text(group.icon)
                .fontSize(22)
                .width(44)
                .height(44)
                .textAlign(TextAlign.Center)
                .backgroundColor(
                  this.activeGroup === idx && this.searchText.length === 0
                    ? '#DCDCDC'
                    : Color.Transparent
                )
                .borderRadius(6)
                .onClick(() => {
                  this.searchText = ''
                  this.searchResult = []
                  this.activeGroup = idx
                })
            })
          }
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .layoutWeight(1)

        // 分割线
        Divider()
          .vertical(true)
          .height(22)
          .color('#CCCCCC')
          .strokeWidth(0.8)
          .margin({ left: 4, right: 4 })

        // 退格键
        Text('⌫')
          .fontSize(20)
          .fontColor('#444444')
          .width(44)
          .height(44)
          .textAlign(TextAlign.Center)
          .onClick(() => { this.onEmojiClick('DELETE') })
      }
      .width('100%')
      .height(50)
      .backgroundColor('#F0F0F0')
      .border({ width: { top: 0.5 }, color: '#DDDDDD' })
      .padding({ left: 8, right: 4 })
    }
    .width('100%')
    .height(320)   // ✅ 固定高度 320vp，输入框始终在面板上方可见
    .backgroundColor('#F5F5F5')
    .border({ width: { top: 0.5 }, color: '#CCCCCC' })
  }
}
