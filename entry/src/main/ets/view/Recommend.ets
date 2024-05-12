import  mainViewModel from '../viewmodel/MainViewModel'

@Component
export  default  struct  Recommend{
  private swiperController: SwiperController = new SwiperController();
  @State changeValue: string=''
  @State submitValue: string=''
  controller: SearchController=new SearchController()
  scroller: Scroller = new Scroller()
  build(){
    Scroll(this.scroller) {
      Column() {
        Search({ value: this.changeValue, placeholder: 'Please input...', controller: this.controller })
          .searchButton('SEARCH')
          .width("100%")
          .height(40)
          .backgroundColor('#F5F5F5')
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 14, weight: 400 })
          .textFont({ size: 14, weight: 400 })
          .onSubmit((value: string) => {
            this.submitValue = value
          })
          .onChange((value: string) => {
            this.changeValue = value
          })
        // .margin(20)
        Swiper(this.swiperController) {
          ForEach(mainViewModel.getSwiperImages(), (img: Resource) => {
            Image(img).borderRadius($r('app.float.home_swiper_borderRadius'))
          }, (img: Resource) => JSON.stringify(img.id))
        }
        .margin({ top: $r('app.float.home_swiper_margin') })
        .autoPlay(true)
        //占位符
        Button().height(900)
      }
      .padding({
        left:"10vp",
        right:"10vp"
      })
      // .justifyContent(FlexAlign.Start)
    }
    .scrollable(ScrollDirection.Vertical)  // 滚动方向纵向
    // .scrollBar(BarState.On)  // 滚动条常驻显示
    .scrollBarColor(Color.Gray)  // 滚动条颜色
    .scrollBarWidth(10) // 滚动条宽度
  }
}