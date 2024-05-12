import router from '@ohos.router'
import  axios  from '@ohos/axios'
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct LoginPage {
  @State username: string = 'username';
  @State password: string = 'password';

  build() {
    Column() {
      Image($r('app.media.tieba'))
        .width(100)
        .height(100)
        .margin({
          top:"100vp"
        })
      Text("登录界面")
        .fontSize(20)
        .margin({
          top:"9vp"
        })
      Text("登录账号以使用更多服务")
        .fontSize(16)
        .fontColor(Color.Gray)
        .margin({
          top:"9vp"
        })
      TextInput({ placeholder: '请输入用户名' })
        .maxLength(20)
        .type(InputType.Number)
        .onChange((value: string) => {
          this.username = value;
        })
        .margin({
          top:"40vp",
          bottom:"10vp"
        })
      TextInput({ placeholder: '请输入密码' })
        .maxLength(20)
        .type(InputType.Password)
        .onChange((value: string) => {
          this.password = value;
        })
      Row() {
        Button("短信验证码登录")
          .fontSize(13)
          .fontColor(Color.Blue)
          .backgroundColor(Color.Transparent)
          .margin({
            left:"-4vp",
            top:"-17vp"
          })
          .onClick(() => {
            promptAction.showToast({
              message: '暂不支持此服务',
              duration: 2000,
              bottom: 90
            });
          })
        Button("忘记密码")
          .fontSize(14)
          .fontColor(Color.Blue)
          .backgroundColor(Color.Transparent)
          .margin({
            right:"-4vp",
            top:"-17vp"
          })
          .onClick(() => {
            promptAction.showToast({
              message: '暂不支持此服务',
              duration: 2000,
              bottom: 90
            });
          })
      }
        .width("94%")
        .margin({
          top:"10vp",
          bottom:"10vp"
        })
        .justifyContent(FlexAlign.SpaceBetween)
      Button("登录", { type: ButtonType.Capsule })
        .width(300)
        .onClick(()=>{
          axios({
            method: "get",
            url: 'http://localhost:3000/find/'+this.username+ '/' + this.password,
          }).then(res => {
              console.info('result:' + JSON.stringify(res.data));
              router.replaceUrl({
                url: 'pages/MainPage',
                params:{
                  username:this.username,
                  password:this.password,
                  permission:"normal"
                }
              })
          }).catch(error => {
            if (error.response) {
              if(error.response.status == 404){//用户名不存在
                promptAction.showToast({
                  message: '用户名不存在',
                  duration: 2000,
                  bottom: 90
                });
              }
              else if(error.response.status == 401){//密码错误
                promptAction.showToast({
                  message: '密码错误',
                  duration: 2000,
                  bottom: 90
                });
              }
              console.error(error.response.data.message);
            } else {
              // 其他错误
              console.error(error);
            }
          })
        })
        .margin({
          bottom:"10vp"
        })
      Button("注册账号", { type: ButtonType.Capsule })
        .width(300)
        .fontColor(Color.Blue)
        .backgroundColor(Color.White)
        .onClick(()=>{
          axios({
            method: "post",
            url: 'http://localhost:3000/publish',
            data:{
              username:this.username,
              password:this.password,
              permission:"normal"
            },
          }).then(res => {
            console.info('result:' + JSON.stringify(res.data));
            promptAction.showToast({
              message: '注册成功',
              duration: 2000,
              bottom: 90
            });
          }).catch(error => {
            console.error(error);
            promptAction.showToast({
              message: '用户名已存在',
              duration: 2000,
              bottom: 90
            });
          })
        })
        .margin({
          bottom:"10vp"
        })
      LoadingProgress().width(50).height(50).color(Color.Blue)
      Blank()
      Row(){
        Line().width("30%").height(0.5).backgroundColor(Color.Gray)
        Text("其他登录方式").fontColor(Color.Black).fontSize(14)
          .margin({
            left:10,
            right:10
          })
        Line().width("30%").height(0.5).backgroundColor(Color.Gray)
      }.margin({bottom:"10vp"})
      Row({space:50}) {
        Button(){
            Image($r('app.media.zhihu')).width(40).height(40)
            .onClick(() => {
              promptAction.showToast({
                message: '暂不支持此服务',
                duration: 2000,
                bottom: 90
              });
            })
        }.backgroundColor(Color.Transparent)
        Button(){
            Image($r('app.media.wechat')).width(40).height(40)
            .onClick(() => {
              promptAction.showToast({
                message: '暂不支持此服务',
                duration: 2000,
                bottom: 90
              });
            })
        }.backgroundColor(Color.Transparent)
      }
        .width("100%")
        .justifyContent(FlexAlign.Center)
    }
      .alignItems(HorizontalAlign.Center)
      .backgroundImage($r('app.media.loginPageBackground3'))
      .backgroundImageSize({
        height:`100%`,
        width:`100%`
      })
      .width("100%")
      .height("100%")
      .padding({
        left:"10vp",
        right:"10vp",
        bottom:"10vp"
      })
  }
}