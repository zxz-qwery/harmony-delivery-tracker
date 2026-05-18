@Component
export struct PoiCard {

  @Prop name: string
  @Prop address: string
  @Prop distance: string

  build() {

    Row() {

      Column() {

        Text(this.name)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)

        Text(this.address)
          .fontSize(14)
          .fontColor('#666')
          .margin({ top: 6 })

        Text(this.distance)
          .fontSize(12)
          .fontColor('#999')
          .margin({ top: 4 })

      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('>')
        .fontSize(20)
        .fontColor('#999')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#fff')
    .borderRadius(18)
    .margin({ bottom: 12 })
  }
}