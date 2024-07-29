import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import call from '@ohos.telephony.call';

import fs from '@ohos.file.fs';
// import { logE } from '../utils/LogUtils'




import util from '@ohos.util';
import buffer from '@ohos.buffer';

export default class EntryAbility extends UIAbility {
  onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');

  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
    this.findPath()
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }

  async findPath() {
    let context = this.context;
    let databaseDir = context.databaseDir
    // logE(`databaseDir : ${databaseDir} `)
    // 创建数据库文件
    // let calendar = databaseDir + "/rdb/text.txt"
    // fs.mkdir(calendar,(dara)=>{
    //   // LogUtils.logD("get file info succeed, the size of file is " + dara.data);
    //   // fs.stat(calendar)
    //   //   .then((stat)=>{
    //   //     LogUtils.logD("get file info succeed, the size of file is " + stat.size);
    //   //   })
    //   // fs.listFile(calendar).then((value)=>{
    //   //   LogUtils.logD("calendar: " + value);
    //   // })
    //   LogUtils.logD("创建DB文件成功 ");
    //
    //   fs.stat(calendar).then((sta) =>{
    //     LogUtils.logD("sta: " +sta.size);
    //   }).catch((err)=>{
    //     LogUtils.logD("get file info failed with error message: " + err.message + ", error code: " + err.code);
    //   })
    // })

    // context.resourceManager.getRawFd('rili.db')
    //   .then((fd)=>{
    //     LogUtils.logD("fd: " +fd.length);
    //   })
    let outputStream = fs.createStreamSync(databaseDir + '/rili_temp.db', "w+");
    context.resourceManager.getRawFileContent('rili.db')
      .then((ser) => {
        // this.readFile(ser.buffer, outputStream)
        // fs.stat(databaseDir + '/rili_temp.db').then((sta)=>{
        //   //LogUtils.logD("sta: " +sta.size);
        // })
      });

    // 以流的形式读取源文件内容并写入目的文件


    // fs.listFile(databaseDir)
    // .then((value)=>{
    //   LogUtils.logD(` databaseDir : ${value}`)
    // })


    // let pathDir = context.filesDir;
    // LogUtils.logD(`path : ${pathDir} `)

    // 创建文件夹 创建文件
    // let fileTestDir = pathDir+"/testDir"
    // // 创建文件夹
    // fs.mkdir(fileTestDir)


    // let filePath = pathDir + "/test.txt";
    // fs.mkdir(filePath).then(()=>{
    //   // 是异步操作
    //   fs.stat(filePath).then((stat) => {
    //     LogUtils.logD("get file info succeed, the size of file is " + stat.size);
    //   }).catch((err) => {
    //     LogUtils.logD("get file info failed with error message: " + err.message + ", error code: " + err.code);
    //   });
    //
    // })

    // 读取resources rawfile
    // 创建文件
    // let appPath = "/data/app/el2/100/database/com.fmm.wannianli/entry/rdb"
    // let appPath = "/data/storage/el2/"
    // let resPath = appPath + "/test.txt"
    // fs.mkdir(resPath).then(()=>{
    //   // 是异步操作
    //   fs.stat(resPath).then((stat) => {
    //     LogUtils.logD("get file info succeed, the size of file is " + stat.size);
    //   }).catch((err) => {
    //     LogUtils.logD("get file info failed with error message: " + err.message + ", error code: " + err.code);
    //   });
    //
    // })


    // 查看dir中的文件
    // let files = fs.listFile(pathDir,{
    //   recursion:false // 是否递归子目录下文件名，默认为false。
    // })
    //   .then((files) =>{
    //     files.forEach(element => {
    //       LogUtils.logD(`element ：${element}` )
    //     });
    //   })
    // LogUtils.logD(`end` )

    // let  result =context.resourceManager.getRawFile("resources/rawfile/rili.db")

    // 读取文件 raw 目录下的 txt
    // let result = context.resourceManager.getRawFileContent('test.txt')
    //   .then(value => {
    //     let rawf = value
    //     var tDecoder = new util.TextDecoder('utf-8', {
    //       ignoreBOM: true
    //     })
    //     var res = tDecoder.decodeWithStream(rawf, {
    //       stream: false
    //     })
    //     LogUtils.logD(`result ${res}`);
    //   },)

    //

    // context.resourceManager.getRawFile('test.txt')
    //   .then(value => {
    //     LogUtils.logD(`value.length :${value.length}`)
    //     LogUtils.logD(`value.toString :${value.toString()}`)
    //
    //     fs.write(value.length,value)
    //   })


    // LogUtils.logD(`result ${result}`);
  }


  // async readFile(inputStream:ArrayBuffer, outputStream:Stream) {
    //LogUtils.logD("readLen "+inputStream.byteLength  )


    // await outputStream.write(buf);

    // let bufSize = 4096;
    // let readSize = 0;
    // let buf = new ArrayBuffer(bufSize);
    // let readLen = await inputStream.read(buf, {
    //   offset: readSize
    // });
    //
    //
    // readSize += readLen;
    //
    // while (readLen > 0) {
    //   LogUtils.logD("readLen "+readLen)
    //   await outputStream.write(buf);
    //   readLen = await inputStream.read(buf, {
    //     offset: readSize
    //   });
    //   readSize += readLen;
    // }
    // // 关闭文件流
    // inputStream.closeSync();
    // outputStream.closeSync();
  }

  // async arrayBufferToStream(arrayBuffer: ArrayBuffer):  {
  //   // 创建一个可读流
  //   const stream = new Readable();
  //
  //   // 将 ArrayBuffer 转换为 Buffer
  //   const buffer = Buffer.from(arrayBuffer);
  //
  //   // 将 Buffer 推送到流中
  //   stream.push(buffer);
  //
  //   // 推送 null 表示数据推送完成
  //   stream.push(null);
  //
  //   return stream;
  // }
// }

