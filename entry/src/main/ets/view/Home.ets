import  Concern from'../view/Concern';
import  Hot from '../view/Hot';
import  Recommend from'../view/Recommend';
import  mainViewModel from '../viewmodel/MainViewModel'

@Component
export  default  struct  Home{
  // @Consume posts:any;
  // @Provide posts_copy:any = this.posts

  @State changeValue: string=''
  @State submitValue: string=''
  controller: SearchController=new SearchController()
  @State fontColor: string = '#182431'
  @State selectedFontColor: string = '#007DFF'
  @State currentIndex: number = 0


  build(){
    Tabs({barPosition:BarPosition.Start}){
      TabContent(){
        Concern()
        // Button("查看", { type: ButtonType.Capsule }).width("100%")
        //   .onClick(() => {
        //     // console.info('receive posts:' + JSON.stringify(this.posts))
        //     // console.info('receive posts_copy:' + JSON.stringify(this.posts_copy))
        //   })
      }.tabBar(new SubTabBarStyle('关注'))

      TabContent(){
        Recommend()
      }.tabBar(new SubTabBarStyle('推荐'))

      TabContent(){
        Hot()
      }.tabBar(new SubTabBarStyle('热门'))
    }
    .width("100%")
    .height('100%')
    .backgroundImage($r('app.media.homebackground'))
    .backgroundImageSize({
      height:`100%`,
      width:`100%`
    })
    .barMode(BarMode.Fixed)
    .onChange((index: number) => {
      this.currentIndex = index;
    })
  }
}