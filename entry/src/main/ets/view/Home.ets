import  Concern from'../view/Concern';
import  Hot from '../view/Hot';
import  Recommend from'../view/Recommend';

@Component
export  default  struct  Home{
  private swiperController: SwiperController = new SwiperController();
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