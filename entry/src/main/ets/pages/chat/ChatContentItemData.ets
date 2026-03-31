export interface ChatContentItemData {
  name?: string
  voicePath?: string
  headSrc?: Resource
  msg?: string
<<<<<<< HEAD
  img?: Resource
  msgType?: number
  self?: Boolean
}
=======
  img?: Resource          // 本地资源图片（$r 引用）
  imgUri?: string         // ✅ 新增：相册/拍照选择的动态 URI
  msgType?: number
  // msgType: 0=文本  1=图片  2=语音
  self?: Boolean
}
>>>>>>> 56b49ca3a1d1dfe7f2835d76bacad57086da3f7d
