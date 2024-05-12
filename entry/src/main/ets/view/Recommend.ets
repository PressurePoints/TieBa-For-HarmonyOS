import  mainViewModel from '../viewmodel/MainViewModel'
import  axios  from '@ohos/axios'

class Posts {
  id:number;
  username: string;
  post_title: string;
  post_content:string;
  post_likes:number;
  post_favourites:number;
  constructor(  id: number, username: string, post_title: string, post_content:string, post_likes:number, post_favourites:number) {
    this.id = id;
    this.username = username;
    this.post_title = post_title;
    this.post_content = post_content;
    this.post_likes = post_likes;
    this.post_favourites = post_favourites;
  }
}

@Component
export  default  struct  Recommend{

  startCount() {
    let timer = setInterval(function(){
      // console.info("Tick")
      this.getPosts();
    }.bind(this), 1500)
  }

  // @Consume posts_copy:any;
  @State temp:any = this.getPosts();
  @State temp2:any = this.startCount();
  @State posts:Posts[] = null;

  IncreaseFavourite(item:Posts):void{
    axios({
      method: "post",
      url: 'http://localhost:3000/post/favourite/increase',
      data:{
        id:item.id
      },
    }).then(res => {
      this.getPosts();
    }).catch(error => {
      console.error(error);
    })
  }

  IncreaseLike(item:Posts):void{
    axios({
      method: "post",
      url: 'http://localhost:3000/post/like/increase',
      data:{
        id:item.id
      },
    }).then(res => {
      this.getPosts();
    }).catch(error => {
      console.error(error);
    })
  }

  getPosts(): void{
    axios({
      method: "get",
      url: 'http://localhost:3000/post/get'
    }).then(res => {
      // console.info('result:' + JSON.stringify(res.data));
      const data = res.data;
      this.posts = data.map(post => new Posts(
        post.id,
        post.username,
        post.title,
        post.content,
        post.likes,
        post.favourites
      ));
    }).catch(error => {
      console.error(error);
    })
  }
  sharePost(index:number): void{

  }

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

        List() {
          ForEach(this.posts, (item: Posts) => {
            ListItem() {
              Column(){
                Row(){
                  Image($r('app.media.ba')).width("5%").margin({right:"10vp"})
                  Text("闲聊吧").fontSize(16).fontWeight("bold").margin({right:"10vp"})
                  Text("关注人数 : 0").fontSize(13).fontColor(Color.Gray)
                }
                .justifyContent(FlexAlign.Start)
                .width("100%")
                Text(item.post_title).fontSize(24).fontWeight("bold").margin({top:"10vp"})
                Text(item.post_content).fontSize(16).margin({top:"2vp",bottom:"20vp"})
                Row({space: "50vp"}){
                  Button(){
                    Row(){
                      Image($r('app.media.share')).width(20).height(20).margin({right:"10vp"})
                      Text("分享").fontColor(Color.Gray)
                    }
                  }
                  .backgroundColor(Color.Transparent)
                  .width("20%")

                  Button(){
                    Row(){
                      Image($r('app.media.favourite')).width(20).height(20).margin({right:"10vp"})
                      Text(item.post_favourites.toString()).fontColor(Color.Gray).fontSize(16)
                    }
                  }
                  .onClick(()=>{
                    this.IncreaseFavourite(item);
                  })
                  .backgroundColor(Color.Transparent)
                  .width("20%")

                  Button(){
                    Row(){
                      Image($r('app.media.like')).width(20).height(20).margin({right:"10vp"})
                      Text(item.post_likes.toString()).fontColor(Color.Gray).fontSize(16)
                    }
                  }
                  .onClick(()=>{
                    this.IncreaseLike(item);
                  })
                  .backgroundColor(Color.Transparent)
                  .width("20%")
                }
                .justifyContent(FlexAlign.Center)
                .width("100%")
              }
              // .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Start)
              .width("100%")
              .padding({
                left:"10vp",
                right:"10vp",
                top:"10vp",
                bottom:"10vp"
              })
              .backgroundColor(Color.White)
            }
            .margin({top:"10vp"})
          })
        }

        // Button("查看", { type: ButtonType.Capsule }).width("100%")
        //   .onClick(() => {
        //     console.info('receive data:' + JSON.stringify(this.posts))
        //   })
        //占位符
        Button().height(900).backgroundColor(Color.Black)
          .onClick(() => {
            // console.info('receive data:' + JSON.stringify(this.posts_copy))
          })
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