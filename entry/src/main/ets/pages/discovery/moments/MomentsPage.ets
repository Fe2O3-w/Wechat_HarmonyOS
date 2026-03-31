
// import router from '@ohos.router'
// import window from '@ohos.window'
//
// const CURRENT_USER = '亚瑟王'
// const PRESET_COUNT = 5
//
// @Observed
// class CommentItem {
//   id: number
//   userName: string
//   replyTo: string
//   content: string
//
//   constructor(id: number, userName: string, content: string, replyTo: string = '') {
//     this.id = id
//     this.userName = userName
//     this.content = content
//     this.replyTo = replyTo
//   }
// }
//
// @Observed
// class MomentItem {
//   id: number
//   userName: string
//   userAvatar: Resource
//   content: string
//   images: Resource[]
//   imageUris: string[]
//   likes: string[]
//   comments: CommentItem[]
//   timeStr: string
//
//   constructor(
//     id: number, userName: string, userAvatar: Resource,
//     content: string,
//     images: Resource[], imageUris: string[],
//     likes: string[], comments: CommentItem[], timeStr: string
//   ) {
//     this.id = id
//     this.userName = userName
//     this.userAvatar = userAvatar
//     this.content = content
//     this.images = images
//     this.imageUris = imageUris
//     this.likes = likes
//     this.comments = comments
//     this.timeStr = timeStr
//   }
// }
//
// let commentIdCounter = 100
// let momentIdCounter = 200
//
// // ── 评论行 ──
// @Component
// struct CommentRow {
//   @ObjectLink comment: CommentItem
//   onReply: (comment: CommentItem) => void = () => {}
//   onDelete: (comment: CommentItem) => void = () => {}
//
//   build() {
//     Row() {
//       Text() {
//         Span(this.comment.userName)
//           .fontColor('#576B95').fontWeight(FontWeight.Medium).fontSize(13)
//         if (this.comment.replyTo !== '') {
//           Span(' 回复 ').fontColor('#999999').fontSize(13)
//           Span(this.comment.replyTo)
//             .fontColor('#576B95').fontWeight(FontWeight.Medium).fontSize(13)
//         }
//         Span('：').fontColor('#1a1a1a').fontSize(13)
//         Span(this.comment.content).fontColor('#1a1a1a').fontSize(13)
//       }
//       .layoutWeight(1).lineHeight(20)
//
//       Row() {
//         Text('回复')
//           .fontSize(12).fontColor('#576B95')
//           .padding({ left: 8, right: 4, top: 2, bottom: 2 })
//           .onClick(() => { this.onReply(this.comment) })
//         if (this.comment.userName === CURRENT_USER) {
//           Text('删除')
//             .fontSize(12).fontColor('#e74c3c')
//             .padding({ left: 4, right: 4, top: 2, bottom: 2 })
//             .onClick(() => { this.onDelete(this.comment) })
//         }
//       }
//     }
//     .width('100%').padding({ top: 3, bottom: 3 }).alignItems(VerticalAlign.Top)
//   }
// }
//
// // ── 图片网格 ──
// @Component
// struct ImageGrid {
//   @ObjectLink moment: MomentItem
//
//   get count(): number {
//     return this.moment.imageUris.length > 0
//       ? this.moment.imageUris.length
//       : this.moment.images.length
//   }
//
//   get gridColumns(): string {
//     return this.count === 1 ? '1fr'
//       : this.count === 4 ? '1fr 1fr'
//         : '1fr 1fr 1fr'
//   }
//
//   get gridWidth(): number | string {
//     return this.count === 1 ? 200 : '100%'
//   }
//
//   get gridHeight(): number {
//     return this.count === 1 ? 200
//       : this.count <= 3 ? 100
//         : this.count <= 6 ? 208
//           : 316
//   }
//
//   build() {
//     if (this.count > 0) {
//       Grid() {
//         if (this.moment.imageUris.length > 0) {
//           ForEach(this.moment.imageUris, (uri: string) => {
//             GridItem() {
//               Image(uri)
//                 .width('100%').aspectRatio(1)
//                 .objectFit(ImageFit.Cover).borderRadius(4)
//             }
//           }, (uri: string) => uri)
//         } else {
//           ForEach(this.moment.images, (img: Resource) => {
//             GridItem() {
//               Image(img)
//                 .width('100%').aspectRatio(1)
//                 .objectFit(ImageFit.Cover).borderRadius(4)
//             }
//           }, (img: Resource) => JSON.stringify(img))
//         }
//       }
//       .columnsTemplate(this.gridColumns)
//       .rowsGap(4).columnsGap(4)
//       .width(this.gridWidth)
//       .height(this.gridHeight)
//       .margin({ bottom: 8 })
//     }
//   }
// }
//
// // ── 单条动态卡片 ──
// @Component
// struct MomentCard {
//   @ObjectLink moment: MomentItem
//   onLike: () => void = () => {}
//   onOpenComment: () => void = () => {}
//   onReplyComment: (comment: CommentItem) => void = () => {}
//   onDeleteComment: (comment: CommentItem) => void = () => {}
//   onDeleteMoment: () => void = () => {}
//
//   @Builder
//   DeleteMomentMenu() {
//     Menu() {
//       MenuItem({ content: '删除这条朋友圈' })
//         .contentFont({ size: 15 })
//         .onClick(() => {
//           this.onDeleteMoment()
//         })
//     }
//   }
//
//   build() {
//     Column() {
//       Row() {
//         Image(this.moment.userAvatar)
//           .width(40).height(40).borderRadius(6).margin({ right: 10 })
//
//         Column() {
//           // 用户名行：自己的动态右侧显示「···」长按菜单触发删除
//           Row() {
//             Text(this.moment.userName)
//               .fontSize(15).fontColor('#576B95')
//               .fontWeight(FontWeight.Medium)
//             Blank()
//             // 只有自己的动态才显示操作按钮
//             if (this.moment.userName === CURRENT_USER) {
//               Text('···')
//                 .fontSize(18).fontColor('#bbbbbb')
//                 .padding({ left: 12, top: 2, bottom: 2 })
//                 .bindMenu(this.DeleteMomentMenu())
//             }
//           }
//           .width('100%')
//           .margin({ bottom: 6 })
//
//           if (this.moment.content !== '') {
//             Text(this.moment.content)
//               .fontSize(15).fontColor('#1a1a1a')
//               .lineHeight(22).margin({ bottom: 8 })
//           }
//
//           ImageGrid({ moment: this.moment })
//
//           Row() {
//             Text(this.moment.timeStr).fontSize(12).fontColor('#999999')
//             Blank()
//
//             Row() {
//               Text(this.moment.likes.includes(CURRENT_USER) ? '❤️' : '🤍').fontSize(16)
//               if (this.moment.likes.length > 0) {
//                 Text(` ${this.moment.likes.length}`).fontSize(13).fontColor('#576B95')
//               }
//             }
//             .padding({ left: 10, right: 8, top: 4, bottom: 4 })
//             .onClick(() => { this.onLike() })
//
//             Row() {
//               Text('💬').fontSize(16)
//               if (this.moment.comments.length > 0) {
//                 Text(` ${this.moment.comments.length}`).fontSize(13).fontColor('#576B95')
//               }
//             }
//             .padding({ left: 8, right: 4, top: 4, bottom: 4 })
//             .onClick(() => { this.onOpenComment() })
//           }
//           .width('100%').margin({ bottom: 6 })
//
//           if (this.moment.likes.length > 0 || this.moment.comments.length > 0) {
//             Column() {
//               if (this.moment.likes.length > 0) {
//                 Row() {
//                   Text('❤ ').fontSize(13).fontColor('#576B95')
//                   Text(this.moment.likes.join('，'))
//                     .fontSize(13).fontColor('#576B95').layoutWeight(1)
//                 }
//                 .width('100%').padding({ top: 4, bottom: 4 })
//               }
//
//               if (this.moment.likes.length > 0 && this.moment.comments.length > 0) {
//                 Divider().color('#d9d9d9').strokeWidth(0.5).margin({ top: 2, bottom: 2 })
//               }
//
//               ForEach(this.moment.comments, (comment: CommentItem) => {
//                 CommentRow({
//                   comment: comment,
//                   onReply: (c: CommentItem) => { this.onReplyComment(c) },
//                   onDelete: (c: CommentItem) => { this.onDeleteComment(c) }
//                 })
//               }, (comment: CommentItem) => comment.id.toString())
//             }
//             .width('100%').padding(8).borderRadius(4)
//             .backgroundColor('#f0f0f0').alignItems(HorizontalAlign.Start)
//           }
//         }
//         .layoutWeight(1).alignItems(HorizontalAlign.Start)
//       }
//       .width('100%').alignItems(VerticalAlign.Top)
//     }
//     .width('100%')
//     .padding({ left: 16, right: 16, top: 12, bottom: 12 })
//     .backgroundColor(Color.White)
//   }
// }
//
// // ── 主页面 ──
// @Entry
// @Component
// struct MomentsPage {
//   private headerHeight: number = 260
//   private scroller: Scroller = new Scroller()
//   private hasRestored: boolean = false
//
//   @State statusBarHeight: number = 40
//   @State showCommentInput: boolean = false
//   @State commentText: string = ''
//   @State commentTargetMomentId: number = -1
//   @State replyTargetComment: CommentItem | null = null
//
//   @State moments: MomentItem[] = [
//     new MomentItem(1, '小李', $r('app.media.ic_user_head1'),
//       '周末爬山，风景超美！心情大好 🏔️',
//       [$r('app.media.ic_moment')], [],
//       ['小王', '小张'],
//       [
//         new CommentItem(1, '小王', '好羡慕！下次带我一起'),
//         new CommentItem(2, '小张', '这是哪里？')
//       ], '刚刚'),
//     new MomentItem(2, '小王', $r('app.media.ic_user_head1'),
//       '今天做了红烧肉，味道很不错！',
//       [], [], [], [], '10分钟前'),
//     new MomentItem(3, '小张', $r('app.media.ic_user_head1'),
//       '今天天气真好，出去拍了几张照片',
//       [$r('app.media.ic_scan'), $r('app.media.ic_listen'), $r('app.media.ic_game')], [],
//       ['小李', '小王'],
//       [new CommentItem(3, '小赵', '拍的真好看！')],
//       '1小时前'),
//     new MomentItem(4, '小赵', $r('app.media.ic_user_head1'),
//       '人生苦短，及时行乐。今天又是元气满满的一天 ☀️',
//       [], [], [], [], '2小时前'),
//     new MomentItem(5, '小陈', $r('app.media.ic_user_head1'),
//       '书山有路勤为径，学习使我快乐 📚',
//       [], [],
//       ['小李', '小王', '小张', '小赵'],
//       [
//         new CommentItem(4, '小王', '说得对！'),
//         new CommentItem(5, '小李', '继续加油')
//       ], '昨天'),
//   ]
//
//   // ── 持久化：全量保存所有动态（含点赞、评论）──
//   saveMoments() {
//     const arr: string[] = this.moments.map((m: MomentItem) => {
//       // 序列化评论列表
//       const commentsArr: string[] = m.comments.map((c: CommentItem) => {
//         return '{"id":' + c.id +
//           ',"userName":' + JSON.stringify(c.userName) +
//           ',"content":' + JSON.stringify(c.content) +
//           ',"replyTo":' + JSON.stringify(c.replyTo) + '}'
//       })
//       return '{"id":' + m.id +
//         ',"userName":' + JSON.stringify(m.userName) +
//         ',"content":' + JSON.stringify(m.content) +
//         ',"imageUris":' + JSON.stringify(m.imageUris) +
//         ',"likes":' + JSON.stringify(m.likes) +
//         ',"comments":[' + commentsArr.join(',') + ']' +
//         ',"timeStr":' + JSON.stringify(m.timeStr) +
//         ',"isPreset":' + (m.images.length > 0 ? 'true' : 'false') + '}'
//     })
//     AppStorage.setOrCreate<string>('momentsList', '[' + arr.join(',') + ']')
//   }
//
//   // ── 首次进入时还原所有动态（含点赞、评论）──
//   // restoreMoments() {
//   //   if (this.hasRestored) {
//   //     return
//   //   }
//   //   this.hasRestored = true
//   //   const saved = AppStorage.get<string>('momentsList')
//   //   if (!saved || saved === '') {
//   //     return
//   //   }
//   //   try {
//   //     const parsed: Record<string, Object>[] = JSON.parse(saved) as Record<string, Object>[]
//   //     if (!parsed || parsed.length === 0) {
//   //       return
//   //     }
//   //     const restored: MomentItem[] = parsed.map((obj: Record<string, Object>) => {
//   //       const id = obj['id'] as number
//   //       if (id > momentIdCounter) {
//   //         momentIdCounter = id
//   //       }
//   //       // 还原评论列表
//   //       const rawComments = obj['comments'] as Record<string, Object>[]
//   //       const comments: CommentItem[] = rawComments ? rawComments.map((c: Record<string, Object>) => {
//   //         const cid = c['id'] as number
//   //         if (cid > commentIdCounter) {
//   //           commentIdCounter = cid
//   //         }
//   //         return new CommentItem(
//   //           cid,
//   //           c['userName'] as string,
//   //           c['content'] as string,
//   //           c['replyTo'] as string
//   //         )
//   //       }) : []
//   //
//   //       const isPreset = obj['isPreset'] as boolean
//   //       const userName = obj['userName'] as string
//   //
//   //       // 预置数据：还原时用对应的 Resource 图片（images 字段无法序列化，按 id 匹配回来）
//   //       let images: Resource[] = []
//   //       if (isPreset) {
//   //         if (id === 1) { images = [$r('app.media.ic_moment')] }
//   //         else if (id === 3) { images = [$r('app.media.ic_scan'), $r('app.media.ic_listen'), $r('app.media.ic_game')] }
//   //       }
//   //
//   //       const uriRaw = obj['imageUris']
//   //       const imageUris: string[] = Array.isArray(uriRaw) ? uriRaw as string[] : []
//   //
//   //       return new MomentItem(
//   //         id, userName,
//   //         $r('app.media.ic_user_head1'),
//   //         obj['content'] as string,
//   //         images,
//   //         imageUris,
//   //         obj['likes'] as string[],
//   //         comments,
//   //         obj['timeStr'] as string
//   //       )
//   //     })
//   //     // 用持久化数据完整替换默认列表
//   //     this.moments = restored
//   //   } catch (e) {
//   //     console.error('还原动态失败:', e)
//   //   }
//   // }
//   restoreMoments() {
//     if (this.hasRestored) return
//     this.hasRestored = true
//
//     const saved = AppStorage.get<string>('momentsList')
//     if (!saved || saved === '') return
//
//     try {
//       const parsed: Record<string, Object>[] = JSON.parse(saved) as Record<string, Object>[]
//       if (!parsed || parsed.length === 0) return
//
//       const restored: MomentItem[] = parsed.map((obj: Record<string, Object>) => {
//         const id = obj['id'] as number
//         if (id > momentIdCounter) momentIdCounter = id
//
//         const rawComments = obj['comments'] as Record<string, Object>[]
//         const comments: CommentItem[] = rawComments ? rawComments.map((c: Record<string, Object>) => {
//           const cid = c['id'] as number
//           if (cid > commentIdCounter) commentIdCounter = cid
//           return new CommentItem(cid, c['userName'] as string, c['content'] as string, c['replyTo'] as string)
//         }) : []
//
//         const isPreset = obj['isPreset'] as boolean
//         let images: Resource[] = []
//         if (isPreset) {
//           if (id === 1) images = [$r('app.media.ic_moment')]
//           else if (id === 3) images = [$r('app.media.ic_scan'), $r('app.media.ic_listen'), $r('app.media.ic_game')]
//         }
//
//         // ✅ 关键修复：安全解析 imageUris
//         let imageUris: string[] = []
//         try {
//           const uriRaw = obj['imageUris']
//           if (uriRaw !== null && uriRaw !== undefined) {
//             const uriArr = uriRaw as string[]
//             for (let i = 0; i < uriArr.length; i++) {
//               if (typeof uriArr[i] === 'string' && uriArr[i] !== '') {
//                 imageUris.push(uriArr[i])
//               }
//             }
//           }
//         } catch (e) {
//           imageUris = []
//         }
//
//         console.info(`[restoreMoments] id=${id} imageUris=${JSON.stringify(imageUris)}`)
//
//         return new MomentItem(
//           id, obj['userName'] as string,
//           $r('app.media.ic_user_head1'),
//           obj['content'] as string,
//           images,
//           imageUris,           // ✅ 正确传入
//           obj['likes'] as string[],
//           comments,
//           obj['timeStr'] as string
//         )
//       })
//
//       this.moments = restored
//     } catch (e) {
//       console.error('还原动态失败:', e)
//     }
//   }
//   // ── 删除自己的动态 ──
//   handleDeleteMoment(moment: MomentItem) {
//     this.moments = this.moments.filter((m: MomentItem) => m.id !== moment.id)
//     // 删除后同步持久化
//     this.saveMoments()
//   }
//
//   onPageShow() {
//     try {
//       window.getLastWindow(getContext(this)).then((win) => {
//         const avoidArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
//         this.statusBarHeight = px2vp(avoidArea.topRect.height)
//       })
//     } catch (e) {
//       this.statusBarHeight = 40
//     }
//
//     this.restoreMoments()
//
//     const raw = AppStorage.get<string>('newMomentData')
//     if (!raw || raw === '') {
//       return
//     }
//     try {
//       const parsed: Record<string, Object> = JSON.parse(raw) as Record<string, Object>
//       const content: string = parsed['content'] !== undefined ? parsed['content'] as string : ''
//       const imageUris: string[] = parsed['imageUris'] !== undefined ? parsed['imageUris'] as string[] : []
//       if (content !== '' || imageUris.length > 0) {
//         const newMoment = new MomentItem(
//           ++momentIdCounter, CURRENT_USER,
//           $r('app.media.ic_user_head1'),
//           content, [], imageUris,
//           [], [], '刚刚'
//         )
//         this.moments = [newMoment, ...this.moments]
//         this.saveMoments()
//       }
//     } catch (e) {
//       console.error('解析新动态失败:', e)
//     }
//     AppStorage.setOrCreate<string>('newMomentData', '')
//   }
//
//   handleLike(moment: MomentItem) {
//     const idx = moment.likes.indexOf(CURRENT_USER)
//     if (idx >= 0) {
//       moment.likes.splice(idx, 1)
//     } else {
//       moment.likes.push(CURRENT_USER)
//     }
//     moment.likes = [...moment.likes]
//     this.saveMoments()
//   }
//
//   handleOpenComment(momentId: number) {
//     this.commentTargetMomentId = momentId
//     this.replyTargetComment = null
//     this.commentText = ''
//     this.showCommentInput = true
//   }
//
//   handleReplyComment(momentId: number, comment: CommentItem) {
//     this.commentTargetMomentId = momentId
//     this.replyTargetComment = comment
//     this.commentText = ''
//     this.showCommentInput = true
//   }
//
//   handleDeleteComment(moment: MomentItem, comment: CommentItem) {
//     const idx = moment.comments.findIndex((c: CommentItem) => c.id === comment.id)
//     if (idx >= 0) {
//       moment.comments.splice(idx, 1)
//       moment.comments = [...moment.comments]
//       this.saveMoments()
//     }
//   }
//
//   handleSubmitComment() {
//     const text = this.commentText.trim()
//     if (text === '') {
//       this.showCommentInput = false
//       return
//     }
//     const moment = this.moments.find((m: MomentItem) => m.id === this.commentTargetMomentId)
//     if (!moment) { return }
//
//     const newComment = new CommentItem(
//       ++commentIdCounter, CURRENT_USER, text,
//       this.replyTargetComment ? this.replyTargetComment.userName : ''
//     )
//     moment.comments.push(newComment)
//     moment.comments = [...moment.comments]
//     this.saveMoments()
//
//     this.commentText = ''
//     this.replyTargetComment = null
//     this.showCommentInput = false
//   }
//
//   get inputPlaceholder(): string {
//     return this.replyTargetComment
//       ? `回复 ${this.replyTargetComment.userName}...`
//       : '写评论...'
//   }
//
//   build() {
//     Stack({ alignContent: Alignment.TopStart }) {
//
//       Scroll(this.scroller) {
//         Column() {
//           Stack({ alignContent: Alignment.BottomEnd }) {
//             Image($r('app.media.1'))
//               .width('100%').height(this.headerHeight).objectFit(ImageFit.Cover)
//
//             Column()
//               .width('100%').height(this.headerHeight)
//               .linearGradient({
//                 direction: GradientDirection.Bottom,
//                 colors: [['rgba(0,0,0,0)', 0.4], ['rgba(0,0,0,0.35)', 1.0]]
//               })
//
//             Row() {
//               Text(CURRENT_USER)
//                 .fontSize(17).fontColor(Color.White)
//                 .fontWeight(FontWeight.Bold).margin({ right: 12 })
//               Image($r('app.media.ic_user_head1'))
//                 .width(66).height(66).borderRadius(8)
//                 .border({ width: 2, color: Color.White })
//             }
//             .margin({ right: 16, bottom: 16 })
//           }
//           .width('100%')
//
//           Row() {
//             Blank()
//             Text('📷')
//               .fontSize(22).margin({ right: 16 })
//               .onClick(() => {
//                 router.pushUrl({ url: 'pages/discovery/moments/PostMomentPage' })
//               })
//           }
//           .width('100%').height(44)
//           .backgroundColor('#ededed')
//           .borderWidth({ bottom: 1 }).borderColor('#d9d9d9')
//
//           Column() {
//             ForEach(this.moments, (moment: MomentItem, index: number) => {
//               MomentCard({
//                 moment: moment,
//                 onLike: () => { this.handleLike(moment) },
//                 onOpenComment: () => { this.handleOpenComment(moment.id) },
//                 onReplyComment: (comment: CommentItem) => {
//                   this.handleReplyComment(moment.id, comment)
//                 },
//                 onDeleteComment: (comment: CommentItem) => {
//                   this.handleDeleteComment(moment, comment)
//                 },
//                 onDeleteMoment: () => {
//                   this.handleDeleteMoment(moment)
//                 }
//               })
//               if (index < this.moments.length - 1) {
//                 Divider().vertical(false).color('#f0f0f0').strokeWidth(1).margin({ left: 66 })
//               }
//             }, (moment: MomentItem) => moment.id.toString())
//           }
//           .width('100%')
//
//           Text('没有更多了').fontSize(13).fontColor('#bbb').padding(20)
//         }
//         .width('100%')
//       }
//       .width('100%').height('100%').scrollBar(BarState.Off).edgeEffect(EdgeEffect.Spring)
//
//       Row() {
//         Button() {
//           Text('←').fontSize(18).fontColor(Color.White)
//         }
//         .width(36).height(36)
//         .backgroundColor('rgba(0,0,0,0.25)').borderRadius(18).margin({ left: 12 })
//         .onClick(() => { router.back() })
//
//         Blank()
//         Text('朋友圈').fontSize(17).fontColor(Color.White).fontWeight(FontWeight.Bold)
//         Blank()
//
//         Button() {
//           Text('📷').fontSize(16)
//         }
//         .width(36).height(36)
//         .backgroundColor('rgba(0,0,0,0.25)').borderRadius(18).margin({ right: 12 })
//         .onClick(() => {
//           router.pushUrl({ url: 'pages/discovery/moments/PostMomentPage' })
//         })
//       }
//       .width('100%')
//       .height(this.statusBarHeight + 56)
//       .padding({ top: this.statusBarHeight, left: 0, right: 0, bottom: 0 })
//       .alignItems(VerticalAlign.Center)
//
//       if (this.showCommentInput) {
//         Column()
//           .width('100%').height('100%')
//           .backgroundColor('rgba(0,0,0,0.3)')
//           .onClick(() => { this.showCommentInput = false })
//
//         Column() {
//           if (this.replyTargetComment !== null) {
//             Row() {
//               Text(`回复 ${this.replyTargetComment!.userName} 的评论`)
//                 .fontSize(12).fontColor('#576B95').layoutWeight(1)
//               Text('✕')
//                 .fontSize(14).fontColor('#999').padding({ left: 8 })
//                 .onClick(() => { this.replyTargetComment = null })
//             }
//             .width('100%')
//             .padding({ left: 16, right: 16, top: 8, bottom: 4 })
//             .backgroundColor('#f5f5f5')
//           }
//
//           Row() {
//             TextArea({ placeholder: this.inputPlaceholder, text: this.commentText })
//               .layoutWeight(1).height(40).fontSize(15)
//               .backgroundColor('#f5f5f5').borderRadius(20)
//               .padding({ left: 16, right: 16, top: 10, bottom: 10 })
//               .maxLines(1).caretColor('#07C160')
//               .onChange((val: string) => { this.commentText = val })
//
//             Button('发送')
//               .height(40).fontSize(14).fontColor(Color.White)
//               .backgroundColor(this.commentText.trim().length > 0 ? '#07C160' : '#c8c8c8')
//               .borderRadius(20).margin({ left: 10 }).padding({ left: 16, right: 16 })
//               .onClick(() => { this.handleSubmitComment() })
//           }
//           .width('100%')
//           .padding({ left: 16, right: 16, top: 12, bottom: 12 })
//           .backgroundColor(Color.White)
//         }
//         .width('100%')
//         .position({ x: 0, y: '75%' })
//         .shadow({ radius: 12, color: 'rgba(0,0,0,0.15)', offsetY: -2 })
//       }
//
//     }
//     .width('100%').height('100%').backgroundColor('#ededed')
//   }
// }
import router from '@ohos.router'
import window from '@ohos.window'

const CURRENT_USER = '亚瑟王'
const PRESET_COUNT = 5

@Observed
class CommentItem {
  id: number
  userName: string
  replyTo: string
  content: string

  constructor(id: number, userName: string, content: string, replyTo: string = '') {
    this.id = id
    this.userName = userName
    this.content = content
    this.replyTo = replyTo
  }
}

@Observed
class MomentItem {
  id: number
  userName: string
  userAvatar: Resource
  content: string
  images: Resource[]
  imageUris: string[]
  likes: string[]
  comments: CommentItem[]
  timeStr: string

  constructor(
    id: number, userName: string, userAvatar: Resource,
    content: string,
    images: Resource[], imageUris: string[],
    likes: string[], comments: CommentItem[], timeStr: string
  ) {
    this.id = id
    this.userName = userName
    this.userAvatar = userAvatar
    this.content = content
    this.images = images
    this.imageUris = imageUris
    this.likes = likes
    this.comments = comments
    this.timeStr = timeStr
  }
}

let commentIdCounter = 100
let momentIdCounter = 200

// ── 评论行 ──
@Component
struct CommentRow {
  @ObjectLink comment: CommentItem
  onReply: (comment: CommentItem) => void = () => {}
  onDelete: (comment: CommentItem) => void = () => {}

  build() {
    Row() {
      Text() {
        Span(this.comment.userName)
          .fontColor('#576B95').fontWeight(FontWeight.Medium).fontSize(13)
        if (this.comment.replyTo !== '') {
          Span(' 回复 ').fontColor('#999999').fontSize(13)
          Span(this.comment.replyTo)
            .fontColor('#576B95').fontWeight(FontWeight.Medium).fontSize(13)
        }
        Span('：').fontColor('#1a1a1a').fontSize(13)
        Span(this.comment.content).fontColor('#1a1a1a').fontSize(13)
      }
      .layoutWeight(1).lineHeight(20)

      Row() {
        Text('回复')
          .fontSize(12).fontColor('#576B95')
          .padding({ left: 8, right: 4, top: 2, bottom: 2 })
          .onClick(() => { this.onReply(this.comment) })
        if (this.comment.userName === CURRENT_USER) {
          Text('删除')
            .fontSize(12).fontColor('#e74c3c')
            .padding({ left: 4, right: 4, top: 2, bottom: 2 })
            .onClick(() => { this.onDelete(this.comment) })
        }
      }
    }
    .width('100%').padding({ top: 3, bottom: 3 }).alignItems(VerticalAlign.Top)
  }
}

// ── 图片网格 ──
@Component
struct ImageGrid {
  @ObjectLink moment: MomentItem

  build() {
    Column() {
      if (this.moment.imageUris.length > 0 || this.moment.images.length > 0) {
        Grid() {
          if (this.moment.imageUris.length > 0) {
            ForEach(this.moment.imageUris, (uri: string) => {
              GridItem() {
                Image(uri)
                  .width('100%').aspectRatio(1)
                  .objectFit(ImageFit.Cover).borderRadius(4)
              }
            }, (uri: string) => uri)
          } else {
            ForEach(this.moment.images, (img: Resource) => {
              GridItem() {
                Image(img)
                  .width('100%').aspectRatio(1)
                  .objectFit(ImageFit.Cover).borderRadius(4)
              }
            }, (img: Resource) => JSON.stringify(img))
          }
        }
        .columnsTemplate(
          (this.moment.imageUris.length > 0 ? this.moment.imageUris.length : this.moment.images.length) === 1 ? '1fr' :
            (this.moment.imageUris.length > 0 ? this.moment.imageUris.length : this.moment.images.length) === 4 ? '1fr 1fr' :
              '1fr 1fr 1fr'
        )
        .rowsGap(4).columnsGap(4)
        .width(
          (this.moment.imageUris.length > 0 ? this.moment.imageUris.length : this.moment.images.length) === 1
            ? 200 : '100%'
        )
        .height(
          (this.moment.imageUris.length > 0 ? this.moment.imageUris.length : this.moment.images.length) === 1 ? 200 :
            (this.moment.imageUris.length > 0 ? this.moment.imageUris.length : this.moment.images.length) <= 3 ? 100 :
              (this.moment.imageUris.length > 0 ? this.moment.imageUris.length : this.moment.images.length) <= 6 ? 208 : 316
        )
        .margin({ bottom: 8 })
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// ── 单条动态卡片 ──
@Component
struct MomentCard {
  @ObjectLink moment: MomentItem
  onLike: () => void = () => {}
  onOpenComment: () => void = () => {}
  onReplyComment: (comment: CommentItem) => void = () => {}
  onDeleteComment: (comment: CommentItem) => void = () => {}
  onDeleteMoment: () => void = () => {}

  @Builder
  DeleteMomentMenu() {
    Menu() {
      MenuItem({ content: '删除这条朋友圈' })
        .contentFont({ size: 15 })
        .onClick(() => {
          this.onDeleteMoment()
        })
    }
  }

  build() {
    Column() {
      Row() {
        Image(this.moment.userAvatar)
          .width(40).height(40).borderRadius(6).margin({ right: 10 })

        Column() {
          // 用户名行：自己的动态右侧显示「···」长按菜单触发删除
          Row() {
            Text(this.moment.userName)
              .fontSize(15).fontColor('#576B95')
              .fontWeight(FontWeight.Medium)
            Blank()
            // 只有自己的动态才显示操作按钮
            if (this.moment.userName === CURRENT_USER) {
              Text('···')
                .fontSize(18).fontColor('#bbbbbb')
                .padding({ left: 12, top: 2, bottom: 2 })
                .bindMenu(this.DeleteMomentMenu())
            }
          }
          .width('100%')
          .margin({ bottom: 6 })

          if (this.moment.content !== '') {
            Text(this.moment.content)
              .fontSize(15).fontColor('#1a1a1a')
              .lineHeight(22).margin({ bottom: 8 })
          }

          ImageGrid({ moment: this.moment })

          Row() {
            Text(this.moment.timeStr).fontSize(12).fontColor('#999999')
            Blank()

            Row() {
              Text(this.moment.likes.includes(CURRENT_USER) ? '❤️' : '🤍').fontSize(16)
              if (this.moment.likes.length > 0) {
                Text(` ${this.moment.likes.length}`).fontSize(13).fontColor('#576B95')
              }
            }
            .padding({ left: 10, right: 8, top: 4, bottom: 4 })
            .onClick(() => { this.onLike() })

            Row() {
              Text('💬').fontSize(16)
              if (this.moment.comments.length > 0) {
                Text(` ${this.moment.comments.length}`).fontSize(13).fontColor('#576B95')
              }
            }
            .padding({ left: 8, right: 4, top: 4, bottom: 4 })
            .onClick(() => { this.onOpenComment() })
          }
          .width('100%').margin({ bottom: 6 })

          if (this.moment.likes.length > 0 || this.moment.comments.length > 0) {
            Column() {
              if (this.moment.likes.length > 0) {
                Row() {
                  Text('❤ ').fontSize(13).fontColor('#576B95')
                  Text(this.moment.likes.join('，'))
                    .fontSize(13).fontColor('#576B95').layoutWeight(1)
                }
                .width('100%').padding({ top: 4, bottom: 4 })
              }

              if (this.moment.likes.length > 0 && this.moment.comments.length > 0) {
                Divider().color('#d9d9d9').strokeWidth(0.5).margin({ top: 2, bottom: 2 })
              }

              ForEach(this.moment.comments, (comment: CommentItem) => {
                CommentRow({
                  comment: comment,
                  onReply: (c: CommentItem) => { this.onReplyComment(c) },
                  onDelete: (c: CommentItem) => { this.onDeleteComment(c) }
                })
              }, (comment: CommentItem) => comment.id.toString())
            }
            .width('100%').padding(8).borderRadius(4)
            .backgroundColor('#f0f0f0').alignItems(HorizontalAlign.Start)
          }
        }
        .layoutWeight(1).alignItems(HorizontalAlign.Start)
      }
      .width('100%').alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor(Color.White)
  }
}

// ── 主页面 ──
@Entry
@Component
struct MomentsPage {
  private headerHeight: number = 260
  private scroller: Scroller = new Scroller()
  private hasRestored: boolean = false

  @State statusBarHeight: number = 40
  @State showCommentInput: boolean = false
  @State commentText: string = ''
  @State commentTargetMomentId: number = -1
  @State replyTargetComment: CommentItem | null = null

  @State moments: MomentItem[] = [
    new MomentItem(1, '小李', $r('app.media.ic_user_head1'),
      '周末爬山，风景超美！心情大好 🏔️',
      [$r('app.media.ic_moment')], [],
      ['小王', '小张'],
      [
        new CommentItem(1, '小王', '好羡慕！下次带我一起'),
        new CommentItem(2, '小张', '这是哪里？')
      ], '刚刚'),
    new MomentItem(2, '小王', $r('app.media.ic_user_head1'),
      '今天做了红烧肉，味道很不错！',
      [], [], [], [], '10分钟前'),
    new MomentItem(3, '小张', $r('app.media.ic_user_head1'),
      '今天天气真好，出去拍了几张照片',
      [$r('app.media.ic_scan'), $r('app.media.ic_listen'), $r('app.media.ic_game')], [],
      ['小李', '小王'],
      [new CommentItem(3, '小赵', '拍的真好看！')],
      '1小时前'),
    new MomentItem(4, '小赵', $r('app.media.ic_user_head1'),
      '人生苦短，及时行乐。今天又是元气满满的一天 ☀️',
      [], [], [], [], '2小时前'),
    new MomentItem(5, '小陈', $r('app.media.ic_user_head1'),
      '书山有路勤为径，学习使我快乐 📚',
      [], [],
      ['小李', '小王', '小张', '小赵'],
      [
        new CommentItem(4, '小王', '说得对！'),
        new CommentItem(5, '小李', '继续加油')
      ], '昨天'),
  ]

  // ── 持久化：全量保存所有动态（含点赞、评论）──
  saveMoments() {
    const arr: string[] = this.moments.map((m: MomentItem) => {
      // 序列化评论列表
      const commentsArr: string[] = m.comments.map((c: CommentItem) => {
        return '{"id":' + c.id +
          ',"userName":' + JSON.stringify(c.userName) +
          ',"content":' + JSON.stringify(c.content) +
          ',"replyTo":' + JSON.stringify(c.replyTo) + '}'
      })
      return '{"id":' + m.id +
        ',"userName":' + JSON.stringify(m.userName) +
        ',"content":' + JSON.stringify(m.content) +
        ',"imageUris":' + JSON.stringify(m.imageUris) +
        ',"likes":' + JSON.stringify(m.likes) +
        ',"comments":[' + commentsArr.join(',') + ']' +
        ',"timeStr":' + JSON.stringify(m.timeStr) +
        ',"isPreset":' + (m.images.length > 0 ? 'true' : 'false') + '}'
    })
    AppStorage.setOrCreate<string>('momentsList', '[' + arr.join(',') + ']')
  }

  // ── 首次进入时还原所有动态（含点赞、评论）──
  restoreMoments() {
    if (this.hasRestored) {
      return
    }
    this.hasRestored = true
    const saved = AppStorage.get<string>('momentsList')
    if (!saved || saved === '') {
      return
    }
    try {
      const parsed: Record<string, Object>[] = JSON.parse(saved) as Record<string, Object>[]
      if (!parsed || parsed.length === 0) {
        return
      }
      const restored: MomentItem[] = parsed.map((obj: Record<string, Object>) => {
        const id = obj['id'] as number
        if (id > momentIdCounter) {
          momentIdCounter = id
        }
        // 还原评论列表
        const rawComments = obj['comments'] as Record<string, Object>[]
        const comments: CommentItem[] = rawComments ? rawComments.map((c: Record<string, Object>) => {
          const cid = c['id'] as number
          if (cid > commentIdCounter) {
            commentIdCounter = cid
          }
          return new CommentItem(
            cid,
            c['userName'] as string,
            c['content'] as string,
            c['replyTo'] as string
          )
        }) : []

        const isPreset = obj['isPreset'] as boolean
        const userName = obj['userName'] as string

        // 预置数据：还原时用对应的 Resource 图片（images 字段无法序列化，按 id 匹配回来）
        let images: Resource[] = []
        if (isPreset) {
          if (id === 1) { images = [$r('app.media.ic_moment')] }
          else if (id === 3) { images = [$r('app.media.ic_scan'), $r('app.media.ic_listen'), $r('app.media.ic_game')] }
        }

        // 逐项提取 imageUris
        const rawImageUris: Object = obj['imageUris']
        const imageUris: string[] = []
        if (rawImageUris !== undefined && rawImageUris !== null) {
          const uriArr: Object[] = rawImageUris as Object[]
          for (let i = 0; i < uriArr.length; i++) {
            const u = uriArr[i] as string
            if (u && u.length > 0) { imageUris.push(u) }
          }
        }

        // 逐项提取 likes
        const rawLikes: Object = obj['likes']
        const likes: string[] = []
        if (rawLikes !== undefined && rawLikes !== null) {
          const likesArr: Object[] = rawLikes as Object[]
          for (let i = 0; i < likesArr.length; i++) {
            const l = likesArr[i] as string
            if (l && l.length > 0) { likes.push(l) }
          }
        }

        return new MomentItem(
          id, userName,
          $r('app.media.ic_user_head1'),
          obj['content'] as string,
          images,
          imageUris,
          likes,
          comments,
          obj['timeStr'] as string
        )
      })
      // 用持久化数据完整替换默认列表
      this.moments = restored
    } catch (e) {
      console.error('还原动态失败:', e)
    }
  }

  // ── 删除自己的动态 ──
  handleDeleteMoment(moment: MomentItem) {
    this.moments = this.moments.filter((m: MomentItem) => m.id !== moment.id)
    // 删除后同步持久化
    this.saveMoments()
  }

  onPageShow() {
    try {
      window.getLastWindow(getContext(this)).then((win) => {
        const avoidArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
        this.statusBarHeight = px2vp(avoidArea.topRect.height)
      })
    } catch (e) {
      this.statusBarHeight = 40
    }

    this.restoreMoments()

    const raw = AppStorage.get<string>('newMomentData')
    console.info('[Moments] onPageShow raw:', raw ?? 'null')
    if (!raw || raw === '') {
      return
    }
    try {
      const parsed: Record<string, Object> = JSON.parse(raw) as Record<string, Object>
      const content: string = parsed['content'] !== undefined ? parsed['content'] as string : ''
      // 逐项提取，避免 ArkTS 直接 as string[] 转换失败导致图片丢失
      const rawUris: Object = parsed['imageUris']
      const imageUris: string[] = []
      if (rawUris !== undefined && rawUris !== null) {
        const uriArr: Object[] = rawUris as Object[]
        for (let i = 0; i < uriArr.length; i++) {
          const u = uriArr[i] as string
          if (u && u.length > 0) {
            imageUris.push(u)
          }
        }
      }
      console.info('[Moments] content:', content, '| imageUris count:', imageUris.length)
      if (content !== '' || imageUris.length > 0) {
        const newMoment = new MomentItem(
          ++momentIdCounter, CURRENT_USER,
          $r('app.media.ic_user_head1'),
          content, [], imageUris,
          [], [], '刚刚'
        )
        this.moments = [newMoment, ...this.moments]
        this.saveMoments()
      }
    } catch (e) {
      console.error('解析新动态失败:', e)
    }
    AppStorage.setOrCreate<string>('newMomentData', '')
  }

  handleLike(moment: MomentItem) {
    const idx = moment.likes.indexOf(CURRENT_USER)
    if (idx >= 0) {
      moment.likes.splice(idx, 1)
    } else {
      moment.likes.push(CURRENT_USER)
    }
    moment.likes = [...moment.likes]
    this.saveMoments()
  }

  handleOpenComment(momentId: number) {
    this.commentTargetMomentId = momentId
    this.replyTargetComment = null
    this.commentText = ''
    this.showCommentInput = true
  }

  handleReplyComment(momentId: number, comment: CommentItem) {
    this.commentTargetMomentId = momentId
    this.replyTargetComment = comment
    this.commentText = ''
    this.showCommentInput = true
  }

  handleDeleteComment(moment: MomentItem, comment: CommentItem) {
    const idx = moment.comments.findIndex((c: CommentItem) => c.id === comment.id)
    if (idx >= 0) {
      moment.comments.splice(idx, 1)
      moment.comments = [...moment.comments]
      this.saveMoments()
    }
  }

  handleSubmitComment() {
    const text = this.commentText.trim()
    if (text === '') {
      this.showCommentInput = false
      return
    }
    const moment = this.moments.find((m: MomentItem) => m.id === this.commentTargetMomentId)
    if (!moment) { return }

    const newComment = new CommentItem(
      ++commentIdCounter, CURRENT_USER, text,
      this.replyTargetComment ? this.replyTargetComment.userName : ''
    )
    moment.comments.push(newComment)
    moment.comments = [...moment.comments]
    this.saveMoments()

    this.commentText = ''
    this.replyTargetComment = null
    this.showCommentInput = false
  }

  get inputPlaceholder(): string {
    return this.replyTargetComment
      ? `回复 ${this.replyTargetComment.userName}...`
      : '写评论...'
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {

      Scroll(this.scroller) {
        Column() {
          Stack({ alignContent: Alignment.BottomEnd }) {
            Image($r('app.media.1'))
              .width('100%').height(this.headerHeight).objectFit(ImageFit.Cover)

            Column()
              .width('100%').height(this.headerHeight)
              .linearGradient({
                direction: GradientDirection.Bottom,
                colors: [['rgba(0,0,0,0)', 0.4], ['rgba(0,0,0,0.35)', 1.0]]
              })

            Row() {
              Text(CURRENT_USER)
                .fontSize(17).fontColor(Color.White)
                .fontWeight(FontWeight.Bold).margin({ right: 12 })
              Image($r('app.media.ic_user_head1'))
                .width(66).height(66).borderRadius(8)
                .border({ width: 2, color: Color.White })
            }
            .margin({ right: 16, bottom: 16 })
          }
          .width('100%')

          Row() {
            Blank()
            Text('📷')
              .fontSize(22).margin({ right: 16 })
              .onClick(() => {
                router.pushUrl({ url: 'pages/discovery/moments/PostMomentPage' })
              })
          }
          .width('100%').height(44)
          .backgroundColor('#ededed')
          .borderWidth({ bottom: 1 }).borderColor('#d9d9d9')

          Column() {
            ForEach(this.moments, (moment: MomentItem, index: number) => {
              MomentCard({
                moment: moment,
                onLike: () => { this.handleLike(moment) },
                onOpenComment: () => { this.handleOpenComment(moment.id) },
                onReplyComment: (comment: CommentItem) => {
                  this.handleReplyComment(moment.id, comment)
                },
                onDeleteComment: (comment: CommentItem) => {
                  this.handleDeleteComment(moment, comment)
                },
                onDeleteMoment: () => {
                  this.handleDeleteMoment(moment)
                }
              })
              if (index < this.moments.length - 1) {
                Divider().vertical(false).color('#f0f0f0').strokeWidth(1).margin({ left: 66 })
              }
            }, (moment: MomentItem) => moment.id.toString())
          }
          .width('100%')

          Text('没有更多了').fontSize(13).fontColor('#bbb').padding(20)
        }
        .width('100%')
      }
      .width('100%').height('100%').scrollBar(BarState.Off).edgeEffect(EdgeEffect.Spring)

      Row() {
        Button() {
          Text('←').fontSize(18).fontColor(Color.White)
        }
        .width(36).height(36)
        .backgroundColor('rgba(0,0,0,0.25)').borderRadius(18).margin({ left: 12 })
        .onClick(() => { router.back() })

        Blank()
        Text('朋友圈').fontSize(17).fontColor(Color.White).fontWeight(FontWeight.Bold)
        Blank()

        Button() {
          Text('📷').fontSize(16)
        }
        .width(36).height(36)
        .backgroundColor('rgba(0,0,0,0.25)').borderRadius(18).margin({ right: 12 })
        .onClick(() => {
          router.pushUrl({ url: 'pages/discovery/moments/PostMomentPage' })
        })
      }
      .width('100%')
      .height(this.statusBarHeight + 56)
      .padding({ top: this.statusBarHeight, left: 0, right: 0, bottom: 0 })
      .alignItems(VerticalAlign.Center)

      if (this.showCommentInput) {
        Column()
          .width('100%').height('100%')
          .backgroundColor('rgba(0,0,0,0.3)')
          .onClick(() => { this.showCommentInput = false })

        Column() {
          if (this.replyTargetComment !== null) {
            Row() {
              Text(`回复 ${this.replyTargetComment!.userName} 的评论`)
                .fontSize(12).fontColor('#576B95').layoutWeight(1)
              Text('✕')
                .fontSize(14).fontColor('#999').padding({ left: 8 })
                .onClick(() => { this.replyTargetComment = null })
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 8, bottom: 4 })
            .backgroundColor('#f5f5f5')
          }

          Row() {
            TextArea({ placeholder: this.inputPlaceholder, text: this.commentText })
              .layoutWeight(1).height(40).fontSize(15)
              .backgroundColor('#f5f5f5').borderRadius(20)
              .padding({ left: 16, right: 16, top: 10, bottom: 10 })
              .maxLines(1).caretColor('#07C160')
              .onChange((val: string) => { this.commentText = val })

            Button('发送')
              .height(40).fontSize(14).fontColor(Color.White)
              .backgroundColor(this.commentText.trim().length > 0 ? '#07C160' : '#c8c8c8')
              .borderRadius(20).margin({ left: 10 }).padding({ left: 16, right: 16 })
              .onClick(() => { this.handleSubmitComment() })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
          .backgroundColor(Color.White)
        }
        .width('100%')
        .position({ x: 0, y: '75%' })
        .shadow({ radius: 12, color: 'rgba(0,0,0,0.15)', offsetY: -2 })
      }

    }
    .width('100%').height('100%').backgroundColor('#ededed')
  }
}

