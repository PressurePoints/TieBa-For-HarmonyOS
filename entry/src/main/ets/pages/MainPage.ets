import router from '@ohos.router'
import  axios  from '@ohos/axios'
let username = router.getParams()['username']
let password = router.getParams()['password']
let permission = router.getParams()['permission']

@Entry
@Component
struct MainPage {
  @State message: string = 'Hello World'
  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Text(username)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Text(password)
          .fontSize(60)
          .fontWeight(FontWeight.Bold)
        Text(permission)
          .fontSize(70)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}

