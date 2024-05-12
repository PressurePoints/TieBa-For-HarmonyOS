import router from '@ohos.router'
import  axios  from '@ohos/axios'

import Home from '../view/Home';
import Message from '../view/Message';
import Send from '../view/Send';
import Skimbar from '../view/Skimbar';
import Setting from '../view/Setting'

@Entry
@Component
struct MainPage {
  @State username:string = router.getParams()['username'];
  @State password:string = router.getParams()['password'];
  @State permission:string = router.getParams()['permission'];

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
      }
      .padding({ left: $r('app.float.mainPage_padding'), right: $r('app.float.mainPage_padding') })
      .backgroundColor(Color.White)
      .tabBar(this.TabBuilder("进吧", 1,
        $r('app.media.Skimbar_selected'), $r('app.media.Skimbar'),false))

      TabContent() {
        Send()
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
