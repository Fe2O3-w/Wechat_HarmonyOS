/**
 * 泛型类 ResponseData 用于表示 API 调用的响应数据
 * 它包含了成功状态、消息、代码和结果等信息
 *
 * @template T 泛型参数，表示响应数据的结果类型
 */
export class ResponseData<T = null | undefined> {
  /**
   * API 调用的结果数据
   * 类型由泛型参数 T 指定，可以根据不同的调用返回不同的数据类型
   */
  data?: T
  meta?: Meta
}

interface Meta {
  msg: string
  status: number
}