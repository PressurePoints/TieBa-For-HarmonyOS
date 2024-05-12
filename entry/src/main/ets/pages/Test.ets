@Entry
@Component
struct TimerPage {
  @State message: string = '定时器'
  @State cot: number = 0
  @State stop_timer:boolean = false;

  onPageShow() {
    // clearTimeout(timeoutID);
    this.startCount()
  }

  aboutToAppear() {

  }

  build() {

    Column({ space: 20 }) {
      Text(this.message + this.cot)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .textAlign(TextAlign.Center)
        .height(150)
        .backgroundColor(Color.Red)

      Text("dianji ")
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .textAlign(TextAlign.Center)
        .onClick(() => {
          this.cot++;
        })
        .height(150)
        .backgroundColor(Color.Blue)
      Text("清空定时器")
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .textAlign(TextAlign.Center)
        .onClick(() => {
          this.stop_timer= true;
        })
        .height(150)
        .backgroundColor(Color.Orange)
    }.height('100%').justifyContent(FlexAlign.Center)
  }

  startCount() {
    let timer = setInterval(function(){
      if (this.stop_timer) {
        clearInterval(timer)
      }
      console.log('setTimeout  do after 1s delay.');
      try {
        this.cot = this.cot + 1;
      } catch (e) {
        console.log('setTimeout  do after 1s delay.' + e);
      }

    }.bind(this), 1500)
  }
}