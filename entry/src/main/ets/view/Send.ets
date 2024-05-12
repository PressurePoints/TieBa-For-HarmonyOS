import Prompt from '@system.prompt';
import  axios  from '@ohos/axios'

@Extend(TextInput)
function inputStyle() {
  .placeholderColor($r('app.color.placeholder_color'))
  .height($r('app.float.login_input_height'))
  .fontSize($r('app.float.big_text_size'))
  .backgroundColor($r('app.color.background'))
  .width('100%')
  .padding({ left: 0 })
  .margin({ top: $r('app.float.input_margin_top') })
}

@Extend(Line)
function lineStyle() {
  .width('100%')
  .height($r('app.float.line_height'))
  .backgroundColor($r('app.color.line_color'))
}

@Extend(Text)
function blueTextStyle() {
  .fontColor($r('app.color.login_blue_text_color'))
  .fontSize($r('app.float.small_text_size'))
  .fontWeight(FontWeight.Medium)
}


@Component
export  default  struct  Send{
  @Prop username:string;
  @Prop password:string;

  @State title:string='';
  @State essay:string='';

  Send(): void {
    if (this.title === '' || this.essay === '') {
      Prompt.showToast({
        message: '标题或文章不能为空'
      })
    } else {//发送信息
      console.log(this.title);
      console.log(this.essay);
      axios({
        method: "post",
        url: 'http://localhost:3000/post/publish',
        data:{
          username:this.username,
          title:this.title,
          content:this.essay
        },
      }).then(res => {
        Prompt.showToast({
          message:'发送成功'
        })
      }).catch(error => {
        console.error(error);
        Prompt.showToast({
          message:'发送失败'
        })
      })
    }
  }

  build() {
    Column({ space: 12 }) {
      TextInput({ placeholder: "请输入完整的帖子标题" })
        .maxLength(11)
        .inputStyle()
        .onChange((value: string) => {
          this.title = value;
        })
      Line().lineStyle()
      TextArea({ placeholder: "请输入正文" })
        .placeholderFont({ size: 16, weight: 400 })
        .width("100%")
        .height(200)
        .margin(5)
        .fontSize(16)
        .fontColor('#182431')
        .backgroundColor('#FFFFFF')
        .onChange((value: string) => {
          this.essay = value;
        })
      Line().lineStyle()
      Button('发送')
        .backgroundColor('#007DFF')
        .margin(15)
        .onClick(() => {
          this.Send()
        })
    }
      .width("100%")
      .height("100%")
      .padding({
        left:"10vp",
        right:"10vp",
        top:"80vp"
      })
  }
}