import mainViewModel from '../viewmodel/MainViewModel';
import ItemData from '../viewmodel/ItemData';
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Component
export default struct  Setting{
  @Prop username:string
  @Prop password:string
  @Prop permission:string

  @Builder settingCell(item: ItemData) {
    Row() {
      Row({ space: 12 }) {
        Image(item.img)
          .width($r('app.float.setting_size'))
          .height($r('app.float.setting_size'))
        Text(item.title)
          .fontSize($r('app.float.normal_text_size'))
      }

      Button(){
        Image($r('app.media.right_grey'))
      }
      .backgroundColor(Color.Transparent)
      .width(20)
      .height($r('app.float.setting_jump_height'))
      .onClick(()=>{
        router.pushUrl({ url: 'view/Userdata' });
      })
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .padding({
      left: $r('app.float.setting_settingCell_left'),
      right: $r('app.float.setting_settingCell_right')
    })
  }

  build(){
    Scroll() {
      Column({ space: 12 }) {
        Column(){
          Text($r('app.string.mainPage_tabTitles_mine'))
            .fontWeight(FontWeight.Medium)
            .fontSize($r('app.float.page_title_text_size'))
            .margin({ top: $r('app.float.mainPage_tabTitles_margin') })
            .padding({ left: $r('app.float.mainPage_tabTitles_padding') })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)

        Row() {
          Image($r('app.media.account'))
            .width($r('app.float.setting_account_size'))
            .height($r('app.float.setting_account_size'))
          Column() {
            Text(this.username)
              .fontSize($r('app.float.setting_account_fontSize'))
            Text("用户权限:" + this.permission)
              .fontSize($r('app.float.little_text_size'))
              .margin({ top: $r('app.float.setting_name_margin') })
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: $r('app.float.setting_account_margin') })
        }
        .margin({ top: $r('app.float.setting_account_margin') })
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .height($r('app.float.setting_account_height'))
        .backgroundColor(Color.White)
        .padding({ left: $r('app.float.setting_account_padding') })
        .borderRadius($r('app.float.setting_account_borderRadius'))

        List() {
          ForEach(mainViewModel.getSettingListData(), (item: ItemData) => {
            ListItem() {
              this.settingCell(item)
            }
            .height($r('app.float.setting_list_height'))
          }, (item:ItemData) => JSON.stringify(item))
        }
        .backgroundColor(Color.White)
        .width('100%')
        .height("42%")
        // .divider({
        //   strokeWidth: $r('app.float.setting_list_strokeWidth'),
        //   color: Color.Grey,
        //   startMargin: $r('app.float.setting_list_startMargin'),
        //   endMargin: $r('app.float.setting_list_endMargin')
        // })
        .borderRadius($r('app.float.setting_list_borderRadius'))
        .padding({ top: $r('app.float.setting_list_padding'), bottom: $r('app.float.setting_list_padding') })

        Blank()
        Button($r('app.string.setting_button'), { type: ButtonType.Capsule })
          .width("90%")
          .height($r('app.float.login_button_height'))
          .fontSize($r('app.float.normal_text_size'))
          .fontColor($r('app.color.setting_button_fontColor'))
          .fontWeight(FontWeight.Medium)
          .backgroundColor($r('app.color.setting_button_backgroundColor'))
          .margin({ bottom: $r('app.float.setting_button_bottom')})
          .onClick(() => {
            // router.replaceUrl({ url: 'pages/Index' });
            // 弹出自定义的询问框
            promptAction.showDialog({
              message: '您确定要退出登录吗？',
              buttons: [
                {
                  text: '取消',
                  color: '#FF0000'
                },
                {
                  text: '确认',
                  color: '#0099FF'
                }
              ]
            }).then((result) => {
              if (result.index === 0) {
                // 用户点击了“取消”按钮
                console.info('User canceled the operation.');
              } else if (result.index === 1) {
                // 用户点击了“确认”按钮
                console.info('User confirmed the operation.');
                router.replaceUrl({ url: 'pages/Index' });
              }
            }).catch((err) => {
              console.error(`Invoke showDialog failed, code is ${err.code}, message is ${err.message}`);
            })
          })
      }
      .height('100%')
    }
  }

}