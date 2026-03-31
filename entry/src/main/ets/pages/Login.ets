import { router, promptAction } from '@kit.ArkUI';
import { LoginResponse } from '../model/LoginResponse';
import { LoginUserModel } from '../model/LoginUserModel';
import { ResponseData } from '../model/ResponseData';
import { AccountLogin } from '../request/API';


@Entry
@Component
struct Login{

  @State loginUser:LoginUserModel={}
  login() {
    // 校验账号不能为空
    if (!this.loginUser.username) {
      promptAction.showToast({ message: "账号不能为空" })
      return
    }
    // 校验密码不能为空
    if (!this.loginUser.password) {
      promptAction.showToast({ message: "密码不能为空" })
      return
    }
    let userParams: LoginUserModel = {
      username: this.loginUser.username,
      password: this.loginUser.password
    }
    AccountLogin(userParams).then((data: ResponseData<LoginResponse>) => {
      console.log(JSON.stringify(data),'登录成功')
      this.handleLogin(data)
    }).catch((err: string) => {
      console.log("账号密码登录错误", JSON.stringify(err))
    }).finally(() => {
    })
  }

  handleLogin(result: ResponseData<LoginResponse>) {
    if (result.meta?.status == 201) {   //后端约定返回201表示成功
      router.replaceUrl({ url: "pages/Index" })
    } else {
      promptAction.showToast({ message: result.meta?.msg })
    }
  }

  build() {
    Column() {
      Image($r('app.media.img_1'))
        .height(90);

      Column() {
        Text('Community')
          .fontSize(30)
          .fontWeight(FontWeight.Bold);
      }
      .margin({ top: 20 });

      // 账号输入框（极简写法，无类型报错）
      TextInput({ text:$$this.loginUser.username,placeholder:"请输入登录账号" })
        .borderRadius(0)
        .fontSize(25)
        .placeholderFont({ size: 25 })
        .backgroundColor('#ffffff')
        .border({ width: { bottom: 1 }, color: '#e5e5e5' })
        .margin({ top: 30 })


      // 密码输入框（用字符串 "password" 替代 InputType.Password）
      TextInput({text:$$this.loginUser.password,placeholder:"请输入登录密码" })
        .borderRadius(0)
        .fontSize(25)
        .placeholderFont({ size: 25 })
        .backgroundColor('#ffffff')
        .border({ width: { bottom: 1 }, color: '#e5e5e5' })
        .margin({ top: 30 })


      Button('登 录')
        .width('100%')
        .margin({ top: 20 })
        .onClick(() => this.login());

      Row({ space: 20 }) {
        Text('忘记密码');
        Text('注册')
          .onClick(() => {
            router.pushUrl({ url: 'pages/Register' });
          });
      }
      .margin({ top: 10 });

      Text('Community 版权所有2026')
        .fontColor('#8e8e8e')
        .margin({ top: 50 });
    }
    .width('100%')
    .height('90%')
    .justifyContent(FlexAlign.Center);
  }


}