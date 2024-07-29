import calendarDBUtil from '../db/CalendarDBUtlis'
import util from '@ohos.util';

class BasicDataSource implements IDataSource {
  private listeners: DataChangeListener[] = [];
  private originDataArray: DateBean[] = [];

  totalCount(): number {
    return 0
  }

  getData(index: number): DateBean {
    return this.originDataArray[index]
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      console.info("add listener")
      this.listeners.push(listener)
    }
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener)
    if (pos < 0) {
      console.info("remove listener")
      this.listeners.splice(pos, 1)
    }
  }

  // 通知LazyForEach组件需要重载所有子组件
  notifyDataReload(): void {
    this.listeners.forEach(listener =>
    listener.onDataReloaded()
      // 写法2：listener.onDatasetChange([{type: DataOperationType.RELOAD}]);
    )
  }

  // 通知LazyForEach组件需要在index对应索引处添加子组件
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    })
  }

  // 通知LazyForEach组件在index对应索引处数据有变化，需要重建该子组件
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
      // 写法2：listener.onDatasetChange([{type: DataOperationType.CHANGE, index: index}]);
    })
  }

  // 通知LazyForEach组件需要在index对应索引处删除该子组件
  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index);
    })
  }

  // 通知LazyForEach组件将from索引和to索引处的子组件进行交换
  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to);
    })
  }
}

class MyDataSource extends BasicDataSource {
  dataArray: DateBean[] = [];

  public totalCount(): number {
    return this.dataArray.length
  }

  public getData(index: number): DateBean {
    return this.dataArray[index]
  }

  public addData(index: number, data: DateBean): void {
    this.dataArray.splice(index, 0, data)
    this.notifyDataAdd(index)
  }

  public pushData(data: DateBean): void {
    this.dataArray.push(data);
    this.notifyDataAdd(this.dataArray.length - 1);
  }

  public deleteData(index: number): void {
    this.dataArray.splice(index, 1);
    this.notifyDataDelete(index);
  }

  public changeData(index: number, data: DateBean): void {
    this.dataArray.splice(index, 1, data);
    this.notifyDataChange(index);
  }

  public reloadData(): void {
    this.notifyDataReload();
  }

  public modifyAllData(): void {
    this.dataArray = this.dataArray.map((item: DateBean) => {
      item.data = item.data + "00"
      return item;
    })
  }
}

@Observed
class DateBean {
  data: string;

  constructor(data: string) {
    this.data = data
  }
}

@Component
@Preview
@Entry
export struct CalendarPage {
  // public listScroller :Scroller = new Scroller()
  private scroller: Scroller = new Scroller()
  @State dataBeanList: MyDataSource = new MyDataSource()

  aboutToAppear(): void {
    for (let i = 0; i < 32; i++) {
      this.dataBeanList.pushData(new DateBean('' + i))
    }
  }

  @Builder
  itemHead(text: string) {
    Text(text)
      .fontSize(20)
      .backgroundColor('#fff1f3f5')
      .width('100%')
      .padding(5)
  }

  build() {
    Column() {
      Button() {
        Text("查询日")
          .fontSize(20)
      }
      .width('50%')
      .height("5%")
      .margin(20)
      .onClick(() => {
        //calendarDBUtil.findDay()
        //this.listScroller.scrollToIndex(1)
        // this.scroller.scrollPage({
        //   next: false
        // })
        // this.dataBeanList.pushData(`100`);
        this.dataBeanList.modifyAllData()
        this.dataBeanList.reloadData()
      })

      Column({ space: 5 }) {
        Grid(this.scroller) {
          LazyForEach(this.dataBeanList, (item: DateBean, index: number) => {
            GridItem() {
              ChildComponent({date: item})
            }
            .onClick(() => {
              // this.dataBeanList.deleteData(this.dataBeanList.dataArray.indexOf(item));
              item.data = item.data + "666"
              this.dataBeanList.changeData(index, item);
            })
            .width('25%')
          }, (item: DateBean, index: number) =>
          index.toString()
          )
        }
        .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr')
        .columnsGap(2)
        .rowsGap(4)
      }
      .width('90%')
      .height('30%')
    }
    .width('100%')
    .height('100%')
  }


}

@Component
struct  ChildComponent{
  @ObjectLink date: DateBean
  build() {
    Text(this.date.data)
      .fontSize(20)
      .width(40)
      .height(40)
      .backgroundColor('#00ff00')
      .textAlign(TextAlign.Center)
  }
}