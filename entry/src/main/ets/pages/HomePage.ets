import { getAddressByLocation } from '../api/amap'

@Entry
@Component
export struct HomePage {
  @State address: string = '地址解析中...'

  aboutToAppear() {
    this.loadAddress()
  }

  async loadAddress() {

    try {

      const res = await getAddressByLocation(
        112.9388,
        28.2282
      )

      this.address =
        res.regeocode.formatted_address
    } catch (e) {

      this.address = '地址获取失败'

      console.error(JSON.stringify(e))
    }
  }

  build() {
    Column() {

      Row() {
        Text('📍 智能位置追踪')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .padding(20)

      Column() {

        Text('当前位置')
          .fontSize(18)
          .fontColor('#666')

        Text(this.address)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 10 })

      }
      .width('90%')
      .padding(20)
      .backgroundColor('#fff')
      .borderRadius(20)

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}