import router from '@ohos.router';
import  axios from '@ohos/axios'
import promptAction from '@ohos.promptAction';
import usb from '@ohos.usb';

@Entry
@Component
export default struct Userdata{
  @State username:string = router.getParams()['username'];
  @State password:string = router.getParams()['password'];
  @State permission:string = router.getParams()['permission'];
  // @State username:string = "null";
  // @State password:string = "null";
  // @State permission:string = "null";

  @State newUsername:string = '';
  build(){
    Column({space:15}){
      Text("用户数据管理")
      Button("修改密码",{type:ButtonType.Capsule})
        .margin({
          bottom:"10vp"
        })
        .align(Alignment.Center)
        .padding({  left: 10 })
        .width(300)
        .onClick(()=>{
          router.pushUrl({
            url: 'view/pass_modified',
            params:{
              username:this.username,
              password:this.password,
              permission:this.permission,
            }
          })
        })
      Row(){
        TextInput({ placeholder: '请输入新用户名' })
          .maxLength(20)
          .type(InputType.Number)
          .onChange((value: string) => {
            this.newUsername = value;
          })
          .width("60%")
        Button("修改用户名",{type:ButtonType.Capsule})
          .align(Alignment.Center)
          .width("40%")
          .onClick(()=>{
            if(this.newUsername == ''){
              promptAction.showToast({
                message: '请输入新用户名',
                duration: 2000,
                bottom: 90
              });
              return;
            }
            if(this.newUsername == this.username){
              promptAction.showToast({
                message: '新用户名与旧用户名一样哦',
                duration: 2000,
                bottom: 90
              });
              return;
            }
            console.info("username:" + this.username);
            console.info("newUsername:" + this.newUsername);
            axios({
              method: "post",
              url: 'http://localhost:3000/upd/newUsername',
              data:{
                username:this.username,
                newUsername:this.newUsername
              }
            }).then(res => {
              console.info('result:' + JSON.stringify(res.data));
              promptAction.showToast({
                message: '修改成功',
                duration: 2000,
                bottom: 90
              });
              router.replaceUrl({url:'pages/Index'})
            }).catch(error => {
              console.error(error);
              if(error.response.status == 404){
                promptAction.showToast({
                  message: '用户名已存在',
                  duration: 2000,
                  bottom: 90
                });
              }
            })
          })
      }
      .margin({
        bottom:"10vp"
      })
      .width(300)

      Button("注销账户",{type:ButtonType.Capsule})
        .align(Alignment.Center)
        .padding({  left: 10 })
        .margin({
          bottom:"10vp"
        })
        .width(300)//可参照数据库加入变量如昵称等
        .onClick(() => {
          // router.replaceUrl({ url: 'pages/Index' });
          // 弹出自定义的询问框
          promptAction.showDialog({
            message: '您确定要注销账户吗？不可撤回哦！',
            buttons: [
              {
                text: '取消',
                color: '#FF0000'
              },
              {
                text: '确认',
                color: '#0099FF'
              }
            ]
          }).then((result) => {
            if (result.index === 0) {
              // 用户点击了“取消”按钮
              console.info('User canceled the operation.');
            } else if (result.index === 1) {
              // 用户点击了“确认”按钮
              axios({
                method: "post",
                url: 'http://localhost:3000/del',
                data:{
                  username:this.username
                },
              }).then(res => {
                router.replaceUrl({url: 'pages/Index'})
              }).catch(error => {
                console.error(error);
              })
            }
          }).catch((err) => {
            console.error(`Invoke showDialog failed, code is ${err.code}, message is ${err.message}`);
          })
        })
    }
    .padding({left:22,top:100})
  }
}