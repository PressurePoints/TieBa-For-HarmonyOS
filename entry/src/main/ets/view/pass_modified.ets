import Prompt from '@system.prompt'
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
          while(this.modified!=this.modified_confirm&&this.modified_confirm!=''&&this.modified!='')
            Prompt.showToast({
              message:"两次输入不一致，请确认"
            })
          Prompt.showToast({
            message:"修改成功"
          })
          axios({
            method:"",
            url:'http://localhost:3000/',
            data:{
              username:username,
              password:this.modified,
              permission:"normal"
            }
          })
          router.pushUrl({url:'../view/Userdata'})

        })
    }.padding({top:200})
  }
}