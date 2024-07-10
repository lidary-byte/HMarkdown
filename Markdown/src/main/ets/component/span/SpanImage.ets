/**
 * @Author : lcc
 * @CreateData : 2024/7/6
 * @Description:
 */
import { markConfig } from '../../Index'

@Component
export struct SpanImage {
  href: string = ''
  // @State imgHeight: Length  = 0
  // @State imgWidth: Length = 0

  build() {
    ImageSpan(this.href)
      // .width(this.imgWidth)
      // .height(this.imgHeight)
      .width('100%')
      .objectFit(markConfig.theme.image?.objectFit)
      .backgroundColor(Color.Orange)
      .onClick(()=>{
        markConfig.registerImageClick(this.href)
      })
      // .onComplete((imageLoadResult) => {
      //   // if (imageLoadResult.loadingStatus == 0) {
      //     if (!(markTheme().image?.width) || typeof markTheme().image?.width === 'string') {
      //       this.imgWidth = imageLoadResult.width
      //     } else {
      //       this.imgWidth = markTheme().image!.width!
      //     }
      //
      //     if (!(markTheme().image?.height) || typeof markTheme().image?.height === 'string') {
      //       this.imgHeight = imageLoadResult.height
      //     } else {
      //       this.imgHeight = markTheme().image?.height!
      //     }
      //   // }
      // })
  }
}