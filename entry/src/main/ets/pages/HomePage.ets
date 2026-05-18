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
  @State longitude: number = 112.9388
  @State latitude: number = 28.2282
  @State categoryList: string[] = [
    '咖啡',
    '奶茶',
    '火锅',
    '商场'
  ]
  @State currentCategory: string = '咖啡'

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
    this.initPage()
  }

  async initPage() {

    try {

      // mock 定位
      const longitude = 112.9388
      const latitude = 28.2282

      await this.loadAddress(
        longitude,
        latitude
      )

      await this.loadPoi(
        longitude,
        latitude,
        this.currentCategory
      )

    } catch (e) {

      this.address = '加载失败'
      this.loading = false

      console.error(JSON.stringify(e))
    }
  }

  async loadPoi(
    longitude: number,
    latitude: number,
    keywords: string
  ) {

    try {

      this.loading = true

      const res = await getNearbyPoi(
        longitude,
        latitude,
        keywords
      )
      this.poiList = (res.pois || []).map((item: PoiItem) => ({
        name: item.name || '',
        address: item.address || '',
        distance: item.distance || '0'
      } as PoiItem))

    } catch (e) {

      console.error(JSON.stringify(e))

    } finally {

      this.loading = false
    }
  }

  async loadAddress(
    longitude: number,
    latitude: number) {

    try {

      const res = await getAddressByLocation(
        longitude,
        latitude
      )
      this.address =
        res.regeocode?.formatted_address || '地址获取失败'
    } catch (e) {

      this.address = '地址获取失败'

      console.error(JSON.stringify(e))
    }
  }

  build() {

    Scroll() {

      Column() {

        Column() {

          Row() {

            Column() {

              Text('附近探索')
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
                .fontColor('#222')

              Text('发现你周边的热门地点')
                .fontSize(14)
                .fontColor('#999')
                .margin({ top: 6 })

            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Text('📍')
              .fontSize(30)
          }
          .width('100%')
        }
        .width('90%')
        .margin({
          top: 20,
          bottom: 20
        })

        // 地址卡片

        Column() {

          Text('当前定位')
            .fontSize(14)
            .fontColor('#999')

          Text(this.address)
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#222')
            .margin({ top: 10 })

        }
        .alignItems(HorizontalAlign.Start)
        .width('90%')
        .padding(22)
        .backgroundColor('#ffffff')
        .borderRadius(28)
        .shadow({
          radius: 20,
          color: 'rgba(0,0,0,0.08)',
          offsetX: 0,
          offsetY: 6
        })

        // 分类区域

        Column() {

          Text('附近推荐')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .margin({
              bottom: 18
            })
          Scroll() {

            Row() {

              ForEach(
                this.categoryList,
                (item: string) => {

                  Text(item)
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(
                      this.currentCategory === item
                        ? '#ffffff'
                        : '#666666'
                    )
                    .backgroundColor(
                      this.currentCategory === item
                        ? '#ff2442'
                        : '#ffffff'
                    )
                    .padding({
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 10
                    })
                    .borderRadius(24)
                    .shadow({
                      radius: 10,
                      color: 'rgba(0,0,0,0.05)',
                      offsetX: 0,
                      offsetY: 2
                    })
                    .margin({ right: 12 })
                    .onClick(async () => {

                      this.currentCategory = item

                      await this.loadPoi(
                        this.longitude,
                        this.latitude,
                        item
                      )
                    })
                }
              )
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .margin({
            bottom: 20
          })

          // 列表区域

          if (this.loading) {

            Column() {

              this.skeletonItem()
              this.skeletonItem()
              this.skeletonItem()

            }

          } else {

            Column() {

              ForEach(
                this.poiList,
                (item: PoiItem) => {

                  PoiCard({
                    name: item.name,
                    address: item.address,
                    distance: item.distance + 'm'
                  })
                }
              )
            }
          }
        }
        .width('90%')
        .margin({
          top: 24,
          bottom: 30
        })
      }
      .width('100%')
    }
    .scrollBar(BarState.Off)
    .backgroundColor('#f7f8fa')
  }
}
