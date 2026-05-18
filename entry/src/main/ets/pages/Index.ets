import router from '@ohos.router'

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('进入项目')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          router.pushUrl({
            url: 'pages/HomePage'
          })
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}