@Component
export  default  struct  Message{
  build(){
    Column(){
      Text("暂未开放，敬请期待").fontColor(Color.Black).fontSize(30)
      LoadingProgress().width(300).height(300).color(Color.Gray)
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