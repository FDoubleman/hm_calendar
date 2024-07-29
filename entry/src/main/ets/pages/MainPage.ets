import hilog from '@ohos.hilog'
import { CalendarPage } from '../ui/CalendarPage'

@Entry
@Component
struct MainPage {
  @State message: string = '首页'
  @State currentIndex: number = 0
  private tabsController: TabsController = new TabsController()

  build() {
    Row() {
      Column() {
        Tabs({ controller: this.tabsController }) {
          TabContent() {
            CalendarPage()
          }
          .tabBar(this.TabBuilder('万年历', 0, $r('app.media.and_notification_week_b'), $r('app.media.and_notification_week_x')))

          TabContent() {
            Text('推荐的内容').fontSize(30)
          }
          .tabBar(this.TabBuilder('推荐', 1, $r('app.media.and_notification_week_b'), $r('app.media.and_notification_week_x')))

          TabContent() {
            Text('发现的内容').fontSize(30)
          }
          .tabBar(this.TabBuilder('我的', 2, $r('app.media.and_notification_week_b'), $r('app.media.and_notification_week_x')))
        }
        .barPosition(BarPosition.End)
        .scrollable(true)
        .barMode(BarMode.Fixed)
        .onChange((index: number) => {
          this.currentIndex = index
        })
      }
      .width('100%')
    }
    .height('100%')
  }

  @Builder TabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      console.log("targetIndex: $r{targetIndex)")
      this.currentIndex = targetIndex;
      this.tabsController.changeIndex(this.currentIndex);
    })
  }
}
