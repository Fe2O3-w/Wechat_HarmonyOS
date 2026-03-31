// // import router from '@ohos.router'
// // import picker from '@ohos.file.picker'
// // import fs from '@ohos.file.fs'
// //
// // // 路由参数类型
// // interface PostResult {
// //   content: string
// //   imageUris: string[]
// // }
// //
// // @Entry
// // @Component
// // struct PostMomentPage {
// //   @State content: string = ''
// //   @State selectedImages: string[] = []   // 已选图片 uri 列表
// //   @State isPosting: boolean = false
// //
// //   private maxImages: number = 9
// //
// //   // 调起系统图库选图
// //   async pickImages() {
// //     try {
// //       const photoPicker = new picker.PhotoViewPicker()
// //       const result = await photoPicker.select({
// //         MIMEType: picker.PhotoViewMIMETypes.IMAGE_TYPE,
// //         maxSelectNumber: this.maxImages - this.selectedImages.length
// //       })
// //       if (result && result.photoUris && result.photoUris.length > 0) {
// //         // 将选中的 uri 追加到列表，不超过 9 张
// //         const newUris = result.photoUris.slice(
// //           0, this.maxImages - this.selectedImages.length
// //         )
// //         this.selectedImages = [...this.selectedImages, ...newUris]
// //       }
// //     } catch (err) {
// //       console.error('选图失败:', JSON.stringify(err))
// //     }
// //   }
// //
// //   // 删除某张图片
// //   removeImage(index: number) {
// //     const arr = [...this.selectedImages]
// //     arr.splice(index, 1)
// //     this.selectedImages = arr
// //   }
// //
// //   // 是否可以发布
// //   get canPost(): boolean {
// //     return (this.content.trim().length > 0 || this.selectedImages.length > 0) && !this.isPosting
// //   }
// //
// //   // 发布
// //   doPost() {
// //     if (!this.canPost) return
// //     this.isPosting = true
// //
// //     // 把结果传回朋友圈页面，通过 router 参数
// //     const postResult: PostResult = {
// //       content: this.content.trim(),
// //       imageUris: [...this.selectedImages]
// //     }
// //
// //     // 将数据存入 AppStorage 供 MomentsPage 读取
// //     AppStorage.setOrCreate<string>('newMomentData', JSON.stringify(postResult))
// //
// //     this.isPosting = false
// //     router.back()
// //   }
// //
// //   build() {
// //     Column() {
// //       // ── 顶部导航栏 ──
// //       Row() {
// //         Text('取消')
// //           .fontSize(16)
// //           .fontColor("#576B95")
// //           .padding({ left: 16, right: 16, top: 12, bottom: 12 })
// //           .onClick(() => { router.back() })
// //
// //         Blank()
// //
// //         Text('发表')
// //           .fontSize(16)
// //           .fontColor("#ffffff")
// //           .fontWeight(FontWeight.Medium)
// //           .padding({ left: 20, right: 20, top: 8, bottom: 8 })
// //           .borderRadius(6)
// //           .backgroundColor(this.canPost ? "#07C160" : "#a8d5b8")
// //           .onClick(() => { this.doPost() })
// //           .margin({ right: 16 })
// //       }
// //       .width('100%')
// //       .height(56)
// //       .backgroundColor(Color.White)
// //       .borderWidth({ bottom: 1 })
// //       .borderColor("#e8e8e8")
// //
// //       // ── 内容区域（可滚动）──
// //       Scroll() {
// //         Column() {
// //
// //           // 文字输入区
// //           TextArea({
// //             placeholder: '这一刻的想法...',
// //             text: this.content
// //           })
// //             .width('100%')
// //             .height(120)
// //             .fontSize(16)
// //             .fontColor("#1a1a1a")
// //             .placeholderColor("#bbbbbb")
// //             .placeholderFont({ size: 16 })
// //             .backgroundColor(Color.White)
// //             .padding({ left: 16, right: 16, top: 16, bottom: 8 })
// //             .caretColor("#07C160")
// //             .onChange((val: string) => { this.content = val })
// //
// //           // 图片网格区
// //           if (this.selectedImages.length > 0 || this.selectedImages.length < this.maxImages) {
// //             GridRow({
// //               columns: 3,
// //               gutter: { x: 6, y: 6 }
// //             }) {
// //               // 已选图片
// //               ForEach(this.selectedImages, (uri: string, index: number) => {
// //                 GridCol() {
// //                   Stack({ alignContent: Alignment.TopEnd }) {
// //                     Image(uri)
// //                       .width('100%')
// //                       .aspectRatio(1)
// //                       .objectFit(ImageFit.Cover)
// //                       .borderRadius(6)
// //
// //                     // 删除按钮
// //                     Text('✕')
// //                       .fontSize(11)
// //                       .fontColor(Color.White)
// //                       .width(20)
// //                       .height(20)
// //                       .textAlign(TextAlign.Center)
// //                       .backgroundColor('rgba(0,0,0,0.55)')
// //                       .borderRadius(10)
// //                       .margin({ top: 4, right: 4 })
// //                       .onClick(() => { this.removeImage(index) })
// //                   }
// //                   .width('100%')
// //                   .aspectRatio(1)
// //                 }
// //               }, (uri: string) => uri)
// //
// //               // 添加按钮（未满9张时显示）
// //               if (this.selectedImages.length < this.maxImages) {
// //                 GridCol() {
// //                   Column() {
// //                     Text('+')
// //                       .fontSize(36)
// //                       .fontColor("#c0c0c0")
// //                       .fontWeight(FontWeight.Lighter)
// //                     Text('添加图片')
// //                       .fontSize(12)
// //                       .fontColor("#c0c0c0")
// //                       .margin({ top: 2 })
// //                   }
// //                   .width('100%')
// //                   .aspectRatio(1)
// //                   .justifyContent(FlexAlign.Center)
// //                   .backgroundColor("#f5f5f5")
// //                   .borderRadius(6)
// //                   .border({ width: 1, color: "#e0e0e0", style: BorderStyle.Dashed })
// //                   .onClick(() => { this.pickImages() })
// //                 }
// //               }
// //             }
// //             .padding({ left: 16, right: 16, top: 8, bottom: 16 })
// //           }
// //
// //           // 图片数量提示
// //           if (this.selectedImages.length > 0) {
// //             Text(`已选 ${this.selectedImages.length} / ${this.maxImages} 张`)
// //               .fontSize(12)
// //               .fontColor("#999")
// //               .padding({ left: 16, bottom: 8 })
// //               .alignSelf(ItemAlign.Start)
// //           }
// //
// //           // 分割线
// //           Divider()
// //             .color("#f0f0f0")
// //             .strokeWidth(1)
// //             .margin({ left: 16, right: 16 })
// //
// //           // 底部选项栏（所在位置、提醒谁看等，仅 UI 占位）
// //           Column() {
// //             Row() {
// //               Text('📍')
// //                 .fontSize(16)
// //                 .margin({ right: 8 })
// //               Text('所在位置')
// //                 .fontSize(15)
// //                 .fontColor("#333333")
// //               Blank()
// //               Text('>')
// //                 .fontSize(14)
// //                 .fontColor("#c0c0c0")
// //             }
// //             .width('100%')
// //             .padding({ left: 16, right: 16, top: 14, bottom: 14 })
// //
// //             Divider().color("#f0f0f0").strokeWidth(1).margin({ left: 16 })
// //
// //             Row() {
// //               Text('👥')
// //                 .fontSize(16)
// //                 .margin({ right: 8 })
// //               Text('提醒谁看')
// //                 .fontSize(15)
// //                 .fontColor("#333333")
// //               Blank()
// //               Text('>')
// //                 .fontSize(14)
// //                 .fontColor("#c0c0c0")
// //             }
// //             .width('100%')
// //             .padding({ left: 16, right: 16, top: 14, bottom: 14 })
// //
// //             Divider().color("#f0f0f0").strokeWidth(1).margin({ left: 16 })
// //
// //             Row() {
// //               Text('🔒')
// //                 .fontSize(16)
// //                 .margin({ right: 8 })
// //               Text('谁可以看')
// //                 .fontSize(15)
// //                 .fontColor("#333333")
// //               Blank()
// //               Text('公开  >')
// //                 .fontSize(14)
// //                 .fontColor("#c0c0c0")
// //             }
// //             .width('100%')
// //             .padding({ left: 16, right: 16, top: 14, bottom: 14 })
// //           }
// //           .width('100%')
// //           .backgroundColor(Color.White)
// //           .margin({ top: 10 })
// //         }
// //         .width('100%')
// //         .alignItems(HorizontalAlign.Start)
// //       }
// //       .layoutWeight(1)
// //       .scrollBar(BarState.Off)
// //       .backgroundColor("#f5f5f5")
// //     }
// //     .width('100%')
// //     .height('100%')
// //     .backgroundColor("#f5f5f5")
// //   }
// // }
// // import router from '@ohos.router'
// // import picker from '@ohos.file.picker'
// //
// // @Entry
// // @Component
// // struct PostMomentPage {
// //   @State content: string = ''
// //   @State selectedImages: string[] = []
// //   // 用 @State 让按钮颜色响应式更新
// //   @State canPost: boolean = false
// //
// //   private maxImages: number = 9
// //
// //   // 每次内容或图片变化时同步更新 canPost
// //   updateCanPost() {
// //     this.canPost = this.content.trim().length > 0 || this.selectedImages.length > 0
// //   }
// //
// //   // 调起系统图库选图
// //   async pickImages() {
// //     try {
// //       const photoPicker = new picker.PhotoViewPicker()
// //       const result = await photoPicker.select({
// //         MIMEType: picker.PhotoViewMIMETypes.IMAGE_TYPE,
// //         maxSelectNumber: this.maxImages - this.selectedImages.length
// //       })
// //       if (result && result.photoUris && result.photoUris.length > 0) {
// //         const newUris = result.photoUris.slice(0, this.maxImages - this.selectedImages.length)
// //         this.selectedImages = [...this.selectedImages, ...newUris]
// //         this.updateCanPost()
// //       }
// //     } catch (err) {
// //       console.error('选图失败:', JSON.stringify(err))
// //     }
// //   }
// //
// //   // 删除某张图片
// //   removeImage(index: number) {
// //     const arr = [...this.selectedImages]
// //     arr.splice(index, 1)
// //     this.selectedImages = arr
// //     this.updateCanPost()
// //   }
// //
// //   // 取消：直接返回上一页，不保存任何数据
// //   doCancel() {
// //     router.back()
// //   }
// //
// //   // 发表：写入 AppStorage 后返回朋友圈页面
// //   doPost() {
// //     if (!this.canPost) {
// //       return
// //     }
// //     // 用 JSON 序列化传递数据，避免对象字面量类型问题
// //     const contentStr: string = this.content.trim()
// //     const urisStr: string = JSON.stringify(this.selectedImages)
// //     // 拼成固定格式字符串，MomentsPage 的 onPageShow 用 Record 解析
// //     const payload: string = '{"content":' + JSON.stringify(contentStr) + ',"imageUris":' + urisStr + '}'
// //     AppStorage.setOrCreate<string>('newMomentData', payload)
// //     router.back()
// //   }
// //
// //   build() {
// //     Column() {
// //       // ── 顶部导航栏 ──
// //       Row() {
// //         // 取消按钮
// //         Text('取消')
// //           .fontSize(16)
// //           .fontColor('#576B95')
// //           .padding({ left: 16, right: 16, top: 12, bottom: 12 })
// //           .onClick(() => {
// //             this.doCancel()
// //           })
// //
// //         Blank()
// //
// //         // 发表按钮（颜色由 @State canPost 驱动）
// //         Text('发表')
// //           .fontSize(16)
// //           .fontColor(Color.White)
// //           .fontWeight(FontWeight.Medium)
// //           .padding({ left: 20, right: 20, top: 8, bottom: 8 })
// //           .borderRadius(6)
// //           .backgroundColor(this.canPost ? '#07C160' : '#a8d5b8')
// //           .margin({ right: 16 })
// //           .onClick(() => {
// //             this.doPost()
// //           })
// //       }
// //       .width('100%')
// //       .height(56)
// //       .backgroundColor(Color.White)
// //       .borderWidth({ bottom: 1 })
// //       .borderColor('#e8e8e8')
// //
// //       // ── 内容区域 ──
// //       Scroll() {
// //         Column() {
// //
// //           // 文字输入区
// //           TextArea({
// //             placeholder: '这一刻的想法...',
// //             text: this.content
// //           })
// //             .width('100%')
// //             .height(140)
// //             .fontSize(16)
// //             .fontColor('#1a1a1a')
// //             .placeholderColor('#bbbbbb')
// //             .placeholderFont({ size: 16 })
// //             .backgroundColor(Color.White)
// //             .padding({ left: 16, right: 16, top: 16, bottom: 8 })
// //             .caretColor('#07C160')
// //             .onChange((val: string) => {
// //               this.content = val
// //               this.updateCanPost()
// //             })
// //
// //           // 图片网格区
// //           GridRow({
// //             columns: 3,
// //             gutter: { x: 6, y: 6 }
// //           }) {
// //             // 已选图片
// //             ForEach(this.selectedImages, (uri: string, index: number) => {
// //               GridCol() {
// //                 Stack({ alignContent: Alignment.TopEnd }) {
// //                   Image(uri)
// //                     .width('100%')
// //                     .aspectRatio(1)
// //                     .objectFit(ImageFit.Cover)
// //                     .borderRadius(6)
// //
// //                   // 删除按钮
// //                   Text('✕')
// //                     .fontSize(11)
// //                     .fontColor(Color.White)
// //                     .width(20)
// //                     .height(20)
// //                     .textAlign(TextAlign.Center)
// //                     .backgroundColor('rgba(0,0,0,0.55)')
// //                     .borderRadius(10)
// //                     .margin({ top: 4, right: 4 })
// //                     .onClick(() => {
// //                       this.removeImage(index)
// //                     })
// //                 }
// //                 .width('100%')
// //                 .aspectRatio(1)
// //               }
// //             }, (uri: string) => uri)
// //
// //             // 添加按钮（未满9张时显示）
// //             if (this.selectedImages.length < this.maxImages) {
// //               GridCol() {
// //                 Column() {
// //                   Text('+')
// //                     .fontSize(40)
// //                     .fontColor('#c0c0c0')
// //                     .fontWeight(FontWeight.Lighter)
// //                     .margin({ bottom: 4 })
// //                   Text('添加图片')
// //                     .fontSize(12)
// //                     .fontColor('#c0c0c0')
// //                 }
// //                 .width('100%')
// //                 .aspectRatio(1)
// //                 .justifyContent(FlexAlign.Center)
// //                 .backgroundColor('#f5f5f5')
// //                 .borderRadius(6)
// //                 .border({ width: 1, color: '#e0e0e0', style: BorderStyle.Dashed })
// //                 .onClick(() => {
// //                   this.pickImages()
// //                 })
// //               }
// //             }
// //           }
// //           .padding({ left: 16, right: 16, top: 8, bottom: 8 })
// //
// //           // 图片数量提示
// //           if (this.selectedImages.length > 0) {
// //             Text(`已选 ${this.selectedImages.length} / ${this.maxImages} 张`)
// //               .fontSize(12)
// //               .fontColor('#999')
// //               .padding({ left: 16, bottom: 8 })
// //               .alignSelf(ItemAlign.Start)
// //           }
// //
// //           Divider()
// //             .color('#f0f0f0')
// //             .strokeWidth(1)
// //             .margin({ left: 16, right: 16 })
// //
// //           // 底部选项（UI 占位）
// //           Column() {
// //             Row() {
// //               Text('📍').fontSize(16).margin({ right: 8 })
// //               Text('所在位置').fontSize(15).fontColor('#333333')
// //               Blank()
// //               Text('>').fontSize(14).fontColor('#c0c0c0')
// //             }
// //             .width('100%')
// //             .padding({ left: 16, right: 16, top: 14, bottom: 14 })
// //
// //             Divider().color('#f0f0f0').strokeWidth(1).margin({ left: 16 })
// //
// //             Row() {
// //               Text('👥').fontSize(16).margin({ right: 8 })
// //               Text('提醒谁看').fontSize(15).fontColor('#333333')
// //               Blank()
// //               Text('>').fontSize(14).fontColor('#c0c0c0')
// //             }
// //             .width('100%')
// //             .padding({ left: 16, right: 16, top: 14, bottom: 14 })
// //
// //             Divider().color('#f0f0f0').strokeWidth(1).margin({ left: 16 })
// //
// //             Row() {
// //               Text('🔒').fontSize(16).margin({ right: 8 })
// //               Text('谁可以看').fontSize(15).fontColor('#333333')
// //               Blank()
// //               Text('公开  >').fontSize(14).fontColor('#c0c0c0')
// //             }
// //             .width('100%')
// //             .padding({ left: 16, right: 16, top: 14, bottom: 14 })
// //           }
// //           .width('100%')
// //           .backgroundColor(Color.White)
// //           .margin({ top: 10 })
// //         }
// //         .width('100%')
// //         .alignItems(HorizontalAlign.Start)
// //       }
// //       .layoutWeight(1)
// //       .scrollBar(BarState.Off)
// //       .backgroundColor('#f5f5f5')
// //     }
// //     .width('100%')
// //     .height('100%')
// //     .backgroundColor('#f5f5f5')
// //   }
// // }
// import router from '@ohos.router'
// import picker from '@ohos.file.picker'
// import window from '@ohos.window'
// import promptAction from '@ohos.promptAction'
// import { PhotoPickerUtils } from '../../../utils/PhotoPickerUtils'
// import { PermissionUtils } from '../../../utils/PermissionUtils'
//
// @Entry
// @Component
// struct PostMomentPage {
//   @State content: string = ''
//   @State selectedImages: string[] = []
//   @State canPost: boolean = false
//   @State statusBarHeight: number = 40   // 状态栏高度，单位 vp，onPageShow 里动态获取
//
//   private maxImages: number = 9
//
//   // 获取状态栏真实高度，避免与系统时间栏重叠
//   onPageShow() {
//     try {
//       window.getLastWindow(getContext(this)).then((win) => {
//         const avoidArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
//         // topRect.height 单位是 px，转换为 vp
//         this.statusBarHeight = px2vp(avoidArea.topRect.height)
//       })
//     } catch (e) {
//       // 获取失败时保留默认值 40vp
//       this.statusBarHeight = 40
//     }
//   }
//
//   // 内容/图片变化时同步 canPost
//   updateCanPost() {
//     this.canPost = this.content.trim().length > 0 || this.selectedImages.length > 0
//   }
//
//   // 调起系统图库选图（先申请读媒体权限，否则部分机型上无法拷贝到沙箱）
//
//   async pickImages() {
//     const granted = await PermissionUtils.request(['ohos.permission.READ_MEDIA', 'ohos.permission.WRITE_MEDIA'])
//     if (!granted) {
//       promptAction.showToast({ message: '需要相册权限才能选择图片', duration: 2000 })
//       return
//     }
//     try {
//       const photoPicker = new picker.PhotoViewPicker()
//       const result = await photoPicker.select({
//         MIMEType: picker.PhotoViewMIMETypes.IMAGE_TYPE,
//         maxSelectNumber: this.maxImages - this.selectedImages.length
//       })
//       if (result && result.photoUris && result.photoUris.length > 0) {
//         const newUris = result.photoUris.slice(0, this.maxImages - this.selectedImages.length)
//         this.selectedImages = [...this.selectedImages, ...newUris]
//         this.updateCanPost()
//       }
//     } catch (err) {
//       console.error('选图失败:', JSON.stringify(err))
//     }
//   }
//
//   // 删除某张图片
//   removeImage(index: number) {
//     const arr = [...this.selectedImages]
//     arr.splice(index, 1)
//     this.selectedImages = arr
//     this.updateCanPost()
//   }
//
//   // 取消
//   doCancel() {
//     router.back()
//   }
//
//   // 发表：先把相册图片拷入应用 filesDir，再写入 newMomentData，避免退出后 URI 失效
//   async doPost() {
//     if (!this.canPost) {
//       return
//     }
//     const persistedUris: string[] = []
//     for (let i = 0; i < this.selectedImages.length; i++) {
//       const saved = await PhotoPickerUtils.copyFileToMomentStorage(this.selectedImages[i])
//       if (saved !== '') {
//         persistedUris.push(saved)
//       }
//     }
//     if (this.selectedImages.length > 0 && persistedUris.length === 0) {
//       promptAction.showToast({ message: '图片保存失败，请检查存储权限后重试', duration: 2000 })
//       return
//     }
//     const contentJson: string = JSON.stringify(this.content.trim())
//     const urisJson: string = JSON.stringify(persistedUris)
//     const payload: string = '{"content":' + contentJson + ',"imageUris":' + urisJson + '}'
//     AppStorage.setOrCreate<string>('newMomentData', payload)
//     router.back()
//   }
//
//   build() {
//     Column() {
//
//       // ── 状态栏安全区占位（高度动态适配，避免与系统时间栏重叠）──
//       Row()
//         .width('100%')
//         .height(this.statusBarHeight)
//         .backgroundColor(Color.White)
//
//       // ── 顶部导航栏 ──
//       Row() {
//         Text('取消')
//           .fontSize(16)
//           .fontColor('#576B95')
//           .padding({ left: 16, right: 16, top: 12, bottom: 12 })
//           .onClick(() => { this.doCancel() })
//
//         Blank()
//
//         Text('发表')
//           .fontSize(16)
//           .fontColor(Color.White)
//           .fontWeight(FontWeight.Medium)
//           .padding({ left: 20, right: 20, top: 8, bottom: 8 })
//           .borderRadius(6)
//           .backgroundColor(this.canPost ? '#07C160' : '#a8d5b8')
//           .margin({ right: 16 })
//           .onClick(() => { this.doPost() })
//       }
//       .width('100%')
//       .height(56)
//       .backgroundColor(Color.White)
//       .borderWidth({ bottom: 1 })
//       .borderColor('#e8e8e8')
//
//       // ── 内容区域 ──
//       Scroll() {
//         Column() {
//
//           // 文字输入区
//           TextArea({
//             placeholder: '这一刻的想法...',
//             text: this.content
//           })
//             .width('100%')
//             .height(140)
//             .fontSize(16)
//             .fontColor('#1a1a1a')
//             .placeholderColor('#bbbbbb')
//             .placeholderFont({ size: 16 })
//             .backgroundColor(Color.White)
//             .padding({ left: 16, right: 16, top: 16, bottom: 8 })
//             .caretColor('#07C160')
//             .onChange((val: string) => {
//               this.content = val
//               this.updateCanPost()
//             })
//
//           // 图片网格区
//           GridRow({
//             columns: 3,
//             gutter: { x: 6, y: 6 }
//           }) {
//             ForEach(this.selectedImages, (uri: string, index: number) => {
//               GridCol() {
//                 Stack({ alignContent: Alignment.TopEnd }) {
//                   Image(uri)
//                     .width('100%')
//                     .aspectRatio(1)
//                     .objectFit(ImageFit.Cover)
//                     .borderRadius(6)
//
//                   Text('✕')
//                     .fontSize(11)
//                     .fontColor(Color.White)
//                     .width(20)
//                     .height(20)
//                     .textAlign(TextAlign.Center)
//                     .backgroundColor('rgba(0,0,0,0.55)')
//                     .borderRadius(10)
//                     .margin({ top: 4, right: 4 })
//                     .onClick(() => { this.removeImage(index) })
//                 }
//                 .width('100%')
//                 .aspectRatio(1)
//               }
//             }, (uri: string) => uri)
//
//             // 添加按钮
//             if (this.selectedImages.length < this.maxImages) {
//               GridCol() {
//                 Column() {
//                   Text('+')
//                     .fontSize(40)
//                     .fontColor('#c0c0c0')
//                     .fontWeight(FontWeight.Lighter)
//                     .margin({ bottom: 4 })
//                   Text('添加图片')
//                     .fontSize(12)
//                     .fontColor('#c0c0c0')
//                 }
//                 .width('100%')
//                 .aspectRatio(1)
//                 .justifyContent(FlexAlign.Center)
//                 .backgroundColor('#f5f5f5')
//                 .borderRadius(6)
//                 .border({ width: 1, color: '#e0e0e0', style: BorderStyle.Dashed })
//                 .onClick(() => { this.pickImages() })
//               }
//             }
//           }
//           .padding({ left: 16, right: 16, top: 8, bottom: 8 })
//
//           // 图片数量提示
//           if (this.selectedImages.length > 0) {
//             Text(`已选 ${this.selectedImages.length} / ${this.maxImages} 张`)
//               .fontSize(12)
//               .fontColor('#999')
//               .padding({ left: 16, bottom: 8 })
//               .alignSelf(ItemAlign.Start)
//           }
//
//           Divider()
//             .color('#f0f0f0')
//             .strokeWidth(1)
//             .margin({ left: 16, right: 16 })
//
//           // 底部选项（UI 占位）
//           Column() {
//             Row() {
//               Text('📍').fontSize(16).margin({ right: 8 })
//               Text('所在位置').fontSize(15).fontColor('#333333')
//               Blank()
//               Text('>').fontSize(14).fontColor('#c0c0c0')
//             }
//             .width('100%')
//             .padding({ left: 16, right: 16, top: 14, bottom: 14 })
//
//             Divider().color('#f0f0f0').strokeWidth(1).margin({ left: 16 })
//
//             Row() {
//               Text('👥').fontSize(16).margin({ right: 8 })
//               Text('提醒谁看').fontSize(15).fontColor('#333333')
//               Blank()
//               Text('>').fontSize(14).fontColor('#c0c0c0')
//             }
//             .width('100%')
//             .padding({ left: 16, right: 16, top: 14, bottom: 14 })
//
//             Divider().color('#f0f0f0').strokeWidth(1).margin({ left: 16 })
//
//             Row() {
//               Text('🔒').fontSize(16).margin({ right: 8 })
//               Text('谁可以看').fontSize(15).fontColor('#333333')
//               Blank()
//               Text('公开  >').fontSize(14).fontColor('#c0c0c0')
//             }
//             .width('100%')
//             .padding({ left: 16, right: 16, top: 14, bottom: 14 })
//           }
//           .width('100%')
//           .backgroundColor(Color.White)
//           .margin({ top: 10 })
//         }
//         .width('100%')
//         .alignItems(HorizontalAlign.Start)
//       }
//       .layoutWeight(1)
//       .scrollBar(BarState.Off)
//       .backgroundColor('#f5f5f5')
//
//     }
//     .width('100%')
//     .height('100%')
//     .backgroundColor('#f5f5f5')
//   }
// }
import router from '@ohos.router'
import window from '@ohos.window'
import picker from '@ohos.file.picker'
import { PhotoPickerUtils } from '../../../utils/PhotoPickerUtils'

@Entry
@Component
struct PostMomentPage {
  @State content: string = ''
  @State selectedImages: string[] = []   // 已复制到沙箱的持久化 uri
  @State canPost: boolean = false
  @State isPickingImages: boolean = false // 防止重复点击选图
  @State statusBarHeight: number = 40

  private maxImages: number = 9

  onPageShow() {
    try {
      window.getLastWindow(getContext(this)).then((win) => {
        const avoidArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
        this.statusBarHeight = px2vp(avoidArea.topRect.height)
      })
    } catch (e) {
      this.statusBarHeight = 40
    }
  }

  updateCanPost() {
    this.canPost = this.content.trim().length > 0 || this.selectedImages.length > 0
  }

  // 选图：直接使用系统返回的 URI（先验证图片是否能显示）
  async pickImages() {
    if (this.isPickingImages) {
      return
    }
    this.isPickingImages = true
    try {
      const photoPicker = new picker.PhotoViewPicker()
      const result = await photoPicker.select({
        MIMEType: picker.PhotoViewMIMETypes.IMAGE_TYPE,
        maxSelectNumber: this.maxImages - this.selectedImages.length
      })
      if (result && result.photoUris && result.photoUris.length > 0) {
        const sliced = result.photoUris.slice(0, this.maxImages - this.selectedImages.length)
        console.info('[Post] 选图原始URIs:', JSON.stringify(sliced))

        // ── 先尝试用 PhotoPickerUtils 复制到沙箱 ──
        const persistedUris: string[] = []
        for (const uri of sliced) {
          try {
            const saved = await PhotoPickerUtils.copyFileToMomentStorage(uri)
            console.info('[Post] 复制结果:', saved)
            if (saved.length > 0) {
              persistedUris.push(saved)
            } else {
              // 复制失败则直接用原始 URI（本次会话内有效）
              console.warn('[Post] 复制失败，使用原始URI:', uri)
              persistedUris.push(uri)
            }
          } catch (copyErr) {
            const e = copyErr as Error
            console.error('[Post] 复制异常:', e.message)
            persistedUris.push(uri)
          }
        }

        console.info('[Post] 最终URIs:', JSON.stringify(persistedUris))
        this.selectedImages = [...this.selectedImages, ...persistedUris]
        this.updateCanPost()
      }
    } catch (err) {
      const e = err as Error
      console.error('[Post] 选图失败:', e.message)
    }
    this.isPickingImages = false
  }

  removeImage(index: number) {
    const arr = [...this.selectedImages]
    arr.splice(index, 1)
    this.selectedImages = arr
    this.updateCanPost()
  }

  doCancel() {
    router.back()
  }

  doPost() {
    if (!this.canPost) {
      return
    }
    const contentJson: string = JSON.stringify(this.content.trim())
    const urisJson: string = JSON.stringify(this.selectedImages)
    const payload: string = '{"content":' + contentJson + ',"imageUris":' + urisJson + '}'
    console.info('[Post] 发表 payload:', payload)
    AppStorage.setOrCreate<string>('newMomentData', payload)
    router.back()
  }

  build() {
    Column() {

      // 状态栏安全区
      Row()
        .width('100%')
        .height(this.statusBarHeight)
        .backgroundColor(Color.White)

      // 顶部导航栏
      Row() {
        Text('取消')
          .fontSize(16)
          .fontColor('#576B95')
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
          .onClick(() => { this.doCancel() })

        Blank()

        Text('发表')
          .fontSize(16)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Medium)
          .padding({ left: 20, right: 20, top: 8, bottom: 8 })
          .borderRadius(6)
          .backgroundColor(this.canPost ? '#07C160' : '#a8d5b8')
          .margin({ right: 16 })
          .onClick(() => { this.doPost() })
      }
      .width('100%')
      .height(56)
      .backgroundColor(Color.White)
      .borderWidth({ bottom: 1 })
      .borderColor('#e8e8e8')

      // 内容区域
      Scroll() {
        Column() {

          // 文字输入
          TextArea({
            placeholder: '这一刻的想法...',
            text: this.content
          })
            .width('100%')
            .height(140)
            .fontSize(16)
            .fontColor('#1a1a1a')
            .placeholderColor('#bbbbbb')
            .placeholderFont({ size: 16 })
            .backgroundColor(Color.White)
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })
            .caretColor('#07C160')
            .onChange((val: string) => {
              this.content = val
              this.updateCanPost()
            })

          // 图片网格
          GridRow({ columns: 3, gutter: { x: 6, y: 6 } }) {
            ForEach(this.selectedImages, (uri: string, index: number) => {
              GridCol() {
                Stack({ alignContent: Alignment.TopEnd }) {
                  Image(uri)
                    .width('100%')
                    .aspectRatio(1)
                    .objectFit(ImageFit.Cover)
                    .borderRadius(6)

                  Text('✕')
                    .fontSize(11)
                    .fontColor(Color.White)
                    .width(20)
                    .height(20)
                    .textAlign(TextAlign.Center)
                    .backgroundColor('rgba(0,0,0,0.55)')
                    .borderRadius(10)
                    .margin({ top: 4, right: 4 })
                    .onClick(() => { this.removeImage(index) })
                }
                .width('100%')
                .aspectRatio(1)
              }
            }, (uri: string) => uri)

            // 添加按钮
            if (this.selectedImages.length < this.maxImages) {
              GridCol() {
                Column() {
                  if (this.isPickingImages) {
                    // 选图中显示加载提示
                    Text('加载中...')
                      .fontSize(13)
                      .fontColor('#c0c0c0')
                  } else {
                    Text('+')
                      .fontSize(40)
                      .fontColor('#c0c0c0')
                      .fontWeight(FontWeight.Lighter)
                      .margin({ bottom: 4 })
                    Text('添加图片')
                      .fontSize(12)
                      .fontColor('#c0c0c0')
                  }
                }
                .width('100%')
                .aspectRatio(1)
                .justifyContent(FlexAlign.Center)
                .backgroundColor('#f5f5f5')
                .borderRadius(6)
                .border({ width: 1, color: '#e0e0e0', style: BorderStyle.Dashed })
                .onClick(() => { this.pickImages() })
              }
            }
          }
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })

          if (this.selectedImages.length > 0) {
            Text(`已选 ${this.selectedImages.length} / ${this.maxImages} 张`)
              .fontSize(12)
              .fontColor('#999')
              .padding({ left: 16, bottom: 8 })
              .alignSelf(ItemAlign.Start)
          }

          Divider()
            .color('#f0f0f0')
            .strokeWidth(1)
            .margin({ left: 16, right: 16 })

          // 底部选项（UI 占位）
          Column() {
            Row() {
              Text('📍').fontSize(16).margin({ right: 8 })
              Text('所在位置').fontSize(15).fontColor('#333333')
              Blank()
              Text('>').fontSize(14).fontColor('#c0c0c0')
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 14, bottom: 14 })

            Divider().color('#f0f0f0').strokeWidth(1).margin({ left: 16 })

            Row() {
              Text('👥').fontSize(16).margin({ right: 8 })
              Text('提醒谁看').fontSize(15).fontColor('#333333')
              Blank()
              Text('>').fontSize(14).fontColor('#c0c0c0')
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 14, bottom: 14 })

            Divider().color('#f0f0f0').strokeWidth(1).margin({ left: 16 })

            Row() {
              Text('🔒').fontSize(16).margin({ right: 8 })
              Text('谁可以看').fontSize(15).fontColor('#333333')
              Blank()
              Text('公开  >').fontSize(14).fontColor('#c0c0c0')
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 14, bottom: 14 })
          }
          .width('100%')
          .backgroundColor(Color.White)
          .margin({ top: 10 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor('#f5f5f5')

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}

