
// import LogUtils  from '../utils/LogUtils'
import hilog from '@ohos.hilog';
import {http} from '@kit.NetworkKit'
import {BusinessError} from '@kit.BasicServicesKit'

export class CalendarDBUtils{


  findDay(){
    // LogUtils.logD("查询 日")
    //console.log("findDay");
    this.doNetwork()
  }

  copyDB2rdb(){


  }


  doNetwork(){
    // 每一个httpRequest对应一个HTTP请求任务，不可复用
    let httpRequest =http.createHttp()
    // 用于订阅HTTP响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息
    // 从API 8开始，使用on('headersReceive', Callback)替代on('headerReceive', AsyncCallback)。 8+
    httpRequest.on('headerReceive',(header)=>{
      console.info('header: ' + JSON.stringify(header));
    })
    let url ="http://47.94.175.79:8080/getCurrent"
    httpRequest.request(url, {
      method:http.RequestMethod.GET,
      // 开发者根据自身业务需要添加header字段
      header: {
        'Content-Type': 'application/json'
      }
    },(err: BusinessError, data: http.HttpResponse) => {
      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        console.info('Result:' + JSON.stringify(data.result));
        console.info('code:' + JSON.stringify(data.responseCode));
        // data.header为HTTP响应头，可根据业务需要进行解析
        console.info('header:' + JSON.stringify(data.header));
        console.info('cookies:' + JSON.stringify(data.cookies)); // 8+
        // 当该请求使用完毕时，调用destroy方法主动销毁
        httpRequest.destroy();
      } else {
        console.error('error:' + JSON.stringify(err));
        // 取消订阅HTTP响应头事件
        httpRequest.off('headersReceive');
        // 当该请求使用完毕时，调用destroy方法主动销毁
        httpRequest.destroy();
        CalendarPickerDialog.show()
      }
    })


  }




}

let calendarDBUtil = new CalendarDBUtils()

export default calendarDBUtil as CalendarDBUtils
