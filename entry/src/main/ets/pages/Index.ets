import router from '@ohos.router'

// import cert from '@ohos.security.cert';

// @Styles function blueTextStyle  () {
//   .width(16)
//   .height(16)
//   .backgroundColor(Color.Blue)
// }

@Entry
@Component
struct LoginPage {
  @State userName: string = 'Hello World';
  @State password: string = 'Hello World';

  build() {
    Column() {
      Blank()
        .height(70)

      Image($r('app.media.logo'))
        .width(100)
        .height(100)

      Text("登录界面")
        .fontSize(20)

      Text("登录账号以使用更多服务")
        .fontSize(16)
        .fontColor(Color.Gray)

      Blank()
        .height(50)

      TextInput({ placeholder: '请输入用户名' })
        // .width(300)
        .maxLength(20)
        .type(InputType.Number)
          // .inputStyle()
        .onChange((value: string) => {
          this.userName = value;
        }
        )

      TextInput({ placeholder: '请输入密码' })
        // .width(300)
        .maxLength(20)
        .type(InputType.Password)
        .onChange((value: string) => {
          this.password = value;
        }
        )

      Row() {
        Text("短信验证码登录")
          .fontSize(12)
          .fontColor(Color.Blue)
        Text("忘记密码")
          .fontSize(12)
          .fontColor(Color.Blue)
      }
      .width(330)
      .justifyContent(FlexAlign.SpaceBetween)

      Blank()
        .height(50)

      Button("登录", { type: ButtonType.Capsule })
        .width(300)
        .onClick(() => {
          router.replaceUrl({ url: 'pages/MainPage' });
        })

      Button("注册账号", { type: ButtonType.Capsule })
        .width(300)
        .fontColor(Color.Blue)
        .backgroundColor(Color.White)

      Blank()
        .height(50)

      Text("其他登录方式")

      Row() {
        Image($r('app.media.login_method1')).width(60).height(60)
        Image($r('app.media.login_method2')).width(60).height(60)
      }
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .alignItems(HorizontalAlign.Center)

  }
}