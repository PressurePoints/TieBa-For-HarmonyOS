import promptAction from '@ohos.promptAction'
import router from '@ohos.router'
import axios from '@ohos/axios'

let username = router.getParams()['username']
let password = router.getParams()['password']
let permission = router.getParams()['permission']

@Entry
@Component
export default struct pass_modified{
  @State modified:string=''
  @State modified_confirm:string=''

  build(){
    Column({space:15}){
      TextInput({ placeholder: '请修改密码' })
        .maxLength(20)
        .type(InputType.Number)
        .onChange((value: string) => {
          this.modified = value;
        })
        .margin({
          top:"40vp",
          bottom:"10vp"
        })
      TextInput({ placeholder: '请确认密码' })
        .maxLength(20)
        .type(InputType.Number)
        .onChange((value: string) => {
          this.modified_confirm = value;
        })
        .margin({
          top:"40vp",
          bottom:"10vp"
        })
      Button("确认修改",{type:ButtonType.Capsule})
        .onClick(()=>{
          if(this.modified == ''){
            promptAction.showToast({
              message: '请输入新密码',
              duration: 2000,
              bottom: 90
            });
            return;
          }
          if(this.modified_confirm == ''){
            promptAction.showToast({
              message: '请确认新密码',
              duration: 2000,
              bottom: 90
            });
            return;
          }
          if(this.modified_confirm != this.modified){
            promptAction.showToast({
              message: '两次输入密码不一致，请确认',
              duration: 2000,
              bottom: 90
            });
            return;
          }
          if(this.modified == password){
            promptAction.showToast({
              message: '新密码与旧密码一致哦',
              duration: 2000,
              bottom: 90
            });
            return;
          }
          axios({
            method: "post",
            url: 'http://localhost:3000/upd/newPassword',
            data:{
              username:username,
              newPassword:this.modified
            },
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
          })
        })
    }
    .padding({
      top:200,
      left:"10vp",
      right:"10vp"
    })
  }
}