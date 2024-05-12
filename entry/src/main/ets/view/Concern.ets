@Component
export  default  struct  Concern{
  build(){
    Column(){
      Text("Loading•••").fontColor(Color.Black).fontSize(40)
      LoadingProgress().width(300).height(300).color(Color.White)
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width("100%")
    .height("100%")
    .padding({
      left:"10vp",
      right:"10vp",
    })
  }
}