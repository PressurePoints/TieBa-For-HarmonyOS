import router from '@ohos.router';
import  axios from '@ohos/axios'

@Entry
@Component
export default struct Userdata{
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
          })
        })
      Button("个人信息修改",{type:ButtonType.Capsule})
        .align(Alignment.Center)
        .padding({  left: 10 })
        .width(300)
        .margin({
          bottom:"10vp"
        })
      Button("注销账户",{type:ButtonType.Capsule})
        .align(Alignment.Center)
        .padding({  left: 10 })
        .margin({
          bottom:"10vp"
        })
        .width(300)//可参照数据库加入变量如昵称等
    }
    .padding({left:22,top:100})
  }
}