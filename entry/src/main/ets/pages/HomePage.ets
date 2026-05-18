import { getAddressByLocation } from '../api/amap'
import { PoiCard } from '../components/PoiCard'
import { getNearbyPoi } from '../api/amap'

interface PoiItem {
  name: string;
  address: string;
  distance: string;
}

@Entry
@Component
export struct HomePage {
  @State address: string = '地址解析中...'
  @State poiList: PoiItem[] = []
  @State loading: boolean = true

  @Builder
  skeletonItem() {

    Column() {

      Text('')
        .width('60%')
        .height(20)
        .backgroundColor('#e5e5e5')
        .borderRadius(8)

      Text('')
        .width('80%')
        .height(16)
        .backgroundColor('#ececec')
        .borderRadius(8)
        .margin({ top: 12 })

      Text('')
        .width('40%')
        .height(14)
        .backgroundColor('#f2f2f2')
        .borderRadius(8)
        .margin({ top: 12 })

    }
    .width('100%')
    .padding(16)
    .backgroundColor('#fff')
    .borderRadius(18)
    .margin({ bottom: 12 })
  }
  aboutToAppear() {
    this.loadAddress()
    this.loadPoi()
  }

  async loadPoi() {

    try {
      const res = await getNearbyPoi(
        112.9388,
        28.2282,
        '咖啡'
      )

      this.poiList = res.pois || []

    } catch (e) {

      console.error(JSON.stringify(e))

    } finally {

      this.loading = false
    }
  }

  async loadAddress() {

    try {

      const res = await getAddressByLocation(
        112.9388,
        28.2282
      )
      this.address =
        res.regeocode?.formatted_address || '地址获取失败'
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
      .padding(10)

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


      Column() {

        Text('附近推荐')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 16 })

        if (this.loading) {

          Column() {
            this.skeletonItem()
            this.skeletonItem()
            this.skeletonItem()
          }

        } else {
          ForEach(this.poiList, (item: PoiItem) => {

            PoiCard({
              name: item.name,
              address: item.address,
              distance: item.distance + 'm'
            })

          })
        }
      }
      .width('90%')
      .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}