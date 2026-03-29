export interface ChatContentItemData {
  name?: string
  voicePath?: string
  headSrc?: Resource
  msg?: string
  img?: Resource          // 本地资源图片（$r 引用）
  imgUri?: string         // ✅ 新增：相册/拍照选择的动态 URI
  msgType?: number
  // msgType: 0=文本  1=图片  2=语音
  self?: Boolean
}
