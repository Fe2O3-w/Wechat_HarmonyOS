import { BASE_URL } from "../constant/Constant";
import { ResponseData } from "../model/ResponseData";
import { HttpUtil } from "../util/HttpUtil";

import { LoginUserModel } from "../model/LoginUserModel";
import { LoginResponse } from "../model/LoginResponse";

import { SearchProductParamModel } from "../model/SearchProductParamModel";

import { ProductDetailModel } from "../model/ProductDetailModel";
import { RegisterUserModel } from "../model/RegisterUserModel";

/**
 * 用户登录函数
 */
export const AccountLogin:(loginUser:LoginUserModel)=>Promise<ResponseData<LoginResponse>> = (loginUser:LoginUserModel):Promise<ResponseData<LoginResponse>>=>{
  return HttpUtil.postNormal<LoginResponse>(BASE_URL + "/app/user/login",loginUser,undefined,"application/x-www-form-urlencoded")
}

// 获取商品列表   后续后端接口可以做分页
export const getCourseList = (params:SearchProductParamModel ):Promise<ResponseData<ProductDetailModel[]>> => HttpUtil.getNormal(BASE_URL + "/app/goods",params)
// 新增：注册API
export const AccountRegister: (registerUser: RegisterUserModel) => Promise<ResponseData<LoginResponse>> = (registerUser: RegisterUserModel): Promise<ResponseData<LoginResponse>> => {
  // 和登录同路径、同格式，仅接口名不同 /app/user/register
  return HttpUtil.postNormal<LoginResponse>(BASE_URL + "/app/user/register", registerUser, undefined, "application/x-www-form-urlencoded")
};