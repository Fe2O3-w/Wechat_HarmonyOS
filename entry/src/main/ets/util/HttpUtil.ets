import { http } from "@kit.NetworkKit";
import { ResponseData } from "../model/ResponseData";

export namespace HttpUtil {

  /**
   * 发送一个http请求出去，并且得到响应
   * @param url
   * @param method
   * @param params
   * @param headers
   * @returns
   */
  export async function request (url:string,method:http.RequestMethod = http.RequestMethod.GET,params?:object,headers?:object,requestDataType:string = "application/json;charset=utf-8"):Promise<http.HttpResponse>{

    let paramsResult = ""
    // 判断请求方式 添加参数
    // get 请求需要将参数拼接到url后面
    if ( params && (method == http.RequestMethod.GET || (method == http.RequestMethod.POST && requestDataType == "application/x-www-form-urlencoded"))){
      // 先把参数中的所有属性名获取出来
      let keys = Object.keys(params) // 获取所有的属性名 是一个Set集合
      if (keys.length){
        // 假设 params = {a:1,b:2,c?} map=> [a=1,b=2] join => ?a=1&b=2
        paramsResult =  keys.map(key=>{
          let value:object = params[key]
          if (value == null || value == undefined){
            return ""
          } else {
            return key + "=" + params[key]
          }
        }).join("&") // 将每一个元素进行&拼接
        if (method == http.RequestMethod.GET)
          url += "?" + paramsResult
      }
    }
    // if (method != http.RequestMethod.GET && params ){ // 如果不是get请求并且带参数，那么参数都是json类型
    // 告诉服务器参数是json 类型
    if(!headers){
      headers = new Object()
    }
    // headers['Content-Type'] = "application/json;charset=utf-8"
    // headers['Content-Type'] = "application/x-www-form-urlencoded"
    headers['Content-Type'] = requestDataType
    // todo:设置token头

    // }

    // 创建请求对象 每一个请求都需要单独创建请求对象
    let httpClient:http.HttpRequest = http.createHttp()
    // 请求选项
    let options:http.HttpRequestOptions = {
      method:method, // 请求方式
      extraData:method == http.RequestMethod.GET ? "" : requestDataType == "application/json;charset=utf-8" ? params : paramsResult, // 请求参数
      header:headers, // 请求头
      connectTimeout:5000,// 连接超时时间
    }
    console.log(url + "开始请求" + JSON.stringify(options))
    // 发送请求
    let response = await httpClient.request(url,options)

    httpClient.destroy() // 销毁请求对象
    return response
  }

  /**
   * 请求一个接口，并且得到响应体中的数据
   * @param url
   * @param method
   * @param params
   * @param headers
   * @returns
   */
  export async function requestNormal <T>(url:string,method:http.RequestMethod = http.RequestMethod.GET,params?:object,headers?:object,requestDataType:string = "application/json;charset=utf-8"):Promise<ResponseData<T>>{
    let response = await request(url,method,params,headers,requestDataType)

    return new Promise<ResponseData<T>>((resolve,reject)=>{
      console.log(url + "请求结果" + response.result)
      if (response.responseCode == 200){
        let result = JSON.parse(response.result as string) as ResponseData<T>
        resolve(result)
      } else {
        let result = JSON.parse(response.result as string) as ResponseData<T>
        reject(result.meta?.msg)
      }
    })
  }

  /**
   * 发起GET请求
   *
   * @param url 请求的URL
   * @param params 请求的参数，将附加在URL后面
   * @param headers 请求头信息
   * @returns 返回一个Promise，包含HTTP请求的响应
   */
  export function get(url:string,params?:object,headers?:object):Promise<http.HttpResponse>{
    return request(url,http.RequestMethod.GET,params,headers)
  }

  /**
   * 发起POST请求
   *
   * @param url 请求的URL
   * @param params 请求的参数，作为请求体发送
   * @param headers 请求头信息
   * @param requestDataType 请求数据的类型，默认为'application/json;charset=utf-8'
   * @returns 返回一个Promise，包含HTTP请求的响应
   */
  export function post(url:string,params?:object,headers?:object,requestDataType:string = "application/json;charset=utf-8"):Promise<http.HttpResponse>{
    return request(url,http.RequestMethod.POST,params,headers,requestDataType)
  }

  /**
   * 发起普通的GET请求，用于获取常规数据响应
   *
   * @param url 请求的URL
   * @param params 请求的参数，将附加在URL后面
   * @param headers 请求头信息
   * @returns 返回一个Promise，包含封装后的响应数据
   */
  export function getNormal<T>(url:string,params?:object,headers?:object):Promise<ResponseData<T>>{
    return requestNormal<T>(url,http.RequestMethod.GET,params,headers, "application/x-www-form-urlencoded")
  }

  /**
   * 发起普通的POST请求，用于发送数据并获取常规数据响应
   *
   * @param url 请求的URL
   * @param params 请求的参数，作为请求体发送
   * @param headers 请求头信息
   * @param requestDataType 请求数据的类型，默认为'application/json;charset=utf-8'
   * @returns 返回一个Promise，包含封装后的响应数据
   */
  export function postNormal<T>(url:string,params?:object,headers?:object,requestDataType:string = "application/json;charset=utf-8"):Promise<ResponseData<T>>{
    return requestNormal<T>(url,http.RequestMethod.POST,params,headers,requestDataType)
  }

  export async function requestByQueryString<T> (url:string,method:http.RequestMethod = http.RequestMethod.GET,params?:object,headers?:object,requestDataType:string = "application/json;charset=utf-8"):Promise<ResponseData<T>>{

    let paramsResult = ""
    if ( params ){
      // 先把参数中的所有属性名获取出来
      let keys = Object.keys(params) // 获取所有的属性名 是一个Set集合
      if (keys.length){
        // 假设 params = {a:1,b:2,c?} map=> [a=1,b=2] join => ?a=1&b=2
        paramsResult =  keys.map(key=>{
          let value:object = params[key]
          if (value == null || value == undefined){
            return ""
          } else {
            return key + "=" + params[key]
          }
        }).join("&") // 将每一个元素进行&拼接
        url += "?" + paramsResult
      }
    }
    // 告诉服务器参数是json 类型
    if(!headers){
      headers = new Object()
    }
    // headers['Content-Type'] = "application/json;charset=utf-8"
    // headers['Content-Type'] = "application/x-www-form-urlencoded"
    headers['Content-Type'] = requestDataType
    // todo:设置token头

    // 创建请求对象 每一个请求都需要单独创建请求对象
    let httpClient:http.HttpRequest = http.createHttp()
    // 请求选项
    let options:http.HttpRequestOptions = {
      method:method, // 请求方式
      extraData: params, // 请求参数
      header:headers // 请求头
    }
    // 发送请求
    let response = await httpClient.request(url,options)

    httpClient.destroy() // 销毁请求对象
    return new Promise<ResponseData<T>>((resolve,reject)=>{
      if (response.responseCode == 200){
        let result = JSON.parse(response.result as string) as ResponseData<T>
        resolve(result)
      } else {
        reject(response.result)
      }
    })
  }
}
