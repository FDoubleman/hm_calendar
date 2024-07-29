import router from '@ohos.router'
import { logD } from '../utils/LogUtils'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button() {
          Text("去首页")
            .fontColor(Color.Red)
            .fontSize(25)
            .fontStyle(FontStyle.Normal)
        }
        .margin(20)
        .width('60%')
        .height('5%')
        .onClick(() => {
          this.goToHomePage()
        })
      }
      .width('100%')
    }
    .height('100%')
  }

  goToHomePage() {
    router.pushUrl({ url: 'pages/MainPage' })
  }
}