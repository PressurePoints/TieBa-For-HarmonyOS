import router from '@ohos.router'
import  axios  from '@ohos/axios'

import Home from '../view/Home';
import Message from '../view/Message';
import Send from '../view/Send';
import Skimbar from '../view/Skimbar';
import Setting from '../view/Setting'

import Prompt from '@system.prompt';

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

@Entry
@Component
struct MainPage {
  // @State posts:any = this.getPosts();
  // @Provide posts:any = this.getPosts();
  @State post_increase:number = 0;

  @State username:string = router.getParams()['username'];
  @State password:string = router.getParams()['password'];
  @State permission:string = router.getParams()['permission'];

  @State title:string='';
  @State essay:string='';

  @State currentIndex: number = 0;
  @State currentIndex1: number = 0;
  private tabsController: TabsController = new TabsController();
  private tabsController1: TabsController = new TabsController();
  @Builder TabBuilder(title: string, index: number, selectedImg: Resource, normalImg: Resource,up:Boolean) {
    Column() {
      Image(this.currentIndex === index ? selectedImg : normalImg)
        .width($r('app.float.mainPage_baseTab_size'))
        .height($r('app.float.mainPage_baseTab_size'))
      Text(title)
        .margin({ top: $r('app.float.mainPage_baseTab_top') })
        .fontSize($r('app.float.main_tab_fontSize'))
        .fontColor(this.currentIndex === index ? $r('app.color.mainPage_selected') : $r('app.color.mainPage_normal'))
    }
    .justifyContent(FlexAlign.Center)
    .height($r('app.float.mainPage_barHeight'))
    .width('100%')
    .onClick(() => {
      this.currentIndex = index;
      if(!up)
        this.tabsController.changeIndex(this.currentIndex);
      else
        this.tabsController1.changeIndex(this.currentIndex1);
    })
  }

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
        // this.posts = this.getPosts();
        this.post_increase++;
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
    Tabs({
      barPosition: BarPosition.End,
      controller: this.tabsController
    }) {
      TabContent() {
        Home()
      }
      // .padding({ left: $r('app.float.mainPage_padding'), right: $r('app.float.mainPage_padding') })
      // .backgroundColor(Color.Blue)
      .tabBar(this.TabBuilder("首页", 0,
        $r('app.media.home_selected'), $r('app.media.home_normal'),false))

      TabContent() {
        Skimbar()
        // Button("查看", { type: ButtonType.Capsule }).width("100%")
        //   .onClick(() => {
        //     console.info('POSTS::' + JSON.stringify(this.posts))
        //   })
      }
      .padding({ left: $r('app.float.mainPage_padding'), right: $r('app.float.mainPage_padding') })
      .backgroundColor(Color.White)
      .tabBar(this.TabBuilder("进吧", 1,
        $r('app.media.Skimbar_selected'), $r('app.media.Skimbar'),false))

      TabContent() {
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
      .padding({ left: $r('app.float.mainPage_padding'), right: $r('app.float.mainPage_padding') })
      .backgroundColor(Color.White)
      .tabBar(this.TabBuilder("发帖", 2,
        $r('app.media.upload'), $r('app.media.upload'),false))

      TabContent() {
        Message()
      }
      .padding({ left: $r('app.float.mainPage_padding'), right: $r('app.float.mainPage_padding') })
      .backgroundColor(Color.White)
      .tabBar(this.TabBuilder("消息", 3,
        $r('app.media.Message1_selected'), $r('app.media.Message1'),false))

      TabContent() {
        Setting({username:this.username, password:this.password, permission:this.permission})
      }
      .padding({ left: $r('app.float.mainPage_padding'), right: $r('app.float.mainPage_padding') })
      .backgroundColor(Color.White)
      .tabBar(this.TabBuilder("我的", 4,
        $r('app.media.my_selected'), $r('app.media.my'),false))
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .barHeight($r('app.float.mainPage_barHeight'))
    .barMode(BarMode.Fixed)
    .onChange((index: number) => {
      this.currentIndex = index;
    })
  }
}
