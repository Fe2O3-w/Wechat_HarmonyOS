import { router, promptAction, UIContext } from '@kit.ArkUI';
import { AccountRegister } from '../request/API';
import { RegisterUserModel } from '../model/RegisterUserModel';
// 先导入
import { AlertDialog } from '@kit.ArkUI';
import { ResponseData } from '../model/ResponseData';
import { LoginResponse } from '../model/LoginResponse';

@Entry
@Component
struct Register {
  @State registerUser: RegisterUserModel = {};
  @State confirmPwd: string = '';

  build() {
    Column() {
      Image($r('app.media.img_1'))
        .height(90)
        .margin({ top: 20 });

      Text('注册页面')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 15 });

      TextInput({ text: $$this.registerUser.username, placeholder: "请输入用户名" })
        .borderRadius(0)
        .fontSize(25)
        .placeholderFont({ size: 25 })
        .backgroundColor('#ffffff')
        .border({ width: { bottom: 1 }, color: '#e5e5e5' })
        .margin({ top: 30 })

      TextInput({ text: $$this.registerUser.password, placeholder: "请输入密码" })
        .type(InputType.Password)
        .borderRadius(0)
        .fontSize(25)
        .placeholderFont({ size: 25 })
        .backgroundColor('#ffffff')
        .border({ width: { bottom: 1 }, color: '#e5e5e5' })
        .margin({ top: 30 })

      TextInput({ text: $$this.confirmPwd, placeholder: "请再次输入密码" })
        .type(InputType.Password)
        .borderRadius(0)
        .fontSize(25)
        .placeholderFont({ size: 25 })
        .backgroundColor('#ffffff')
        .border({ width: { bottom: 1 }, color: '#e5e5e5' })
        .margin({ top: 30 })

      Row({ space: 10 }) {
        Button('注 册')
          .width('45%')
          .onClick(() => this.doRegister());

        Button('登 录')
          .width('45%')
          .onClick(() => {
            router.replaceUrl({ url: 'pages/Login' });
          });
      }.margin({ top: 30 });

      Text('Community 版权所有2026')
        .fontColor('#8e8e8e')
        .margin({ top: 50 });
    }
    .width('100%')
    .height('90%')
    .justifyContent(FlexAlign.Center);
  }

  doRegister() {
    // 1. 校验（必须同步写，不能放进异步里）
    if (!this.registerUser.username) {
      promptAction.showToast({ message: "用户名不能为空" });
      return;
    }
    if (!this.registerUser.password || this.registerUser.password !== this.confirmPwd) {
      promptAction.showToast({ message: "两次密码不一致" });
      return;
    }

    // 2. 用最原始的 Promise 写法，不使用 async/await
    AccountRegister(this.registerUser)
      .then(() => {
        // 成功只提示，不跳转（最稳定）
        promptAction.showToast({ message: "✅ 注册成功！" });
        promptAction.showDialog({
          message: "✅ 注册成功！",
        });
      })
      .catch(() => {
        promptAction.showToast({ message: "❌ 注册失败" });
      });
  }}