/**
 * @Author : lcc
 * @CreateData : 2024/7/6
 * @Description:
 */
import { KEY_LINE_SPACE, KEY_THEME } from '../../config/Constant'
import { MarkdownTheme } from '../../config/MarkdownTheme'
import { markConfig } from '../../Index'

@Component
export struct SpanImage {
  @Consume(KEY_THEME) theme: MarkdownTheme
  href: string = ''
  // @State imgHeight?: number = undefined
  @State imgWidth?: number = undefined
  @Consume(KEY_LINE_SPACE) lineSpace: number

  build() {
    ImageSpan(this.href)// .height(this.imgHeight)
      // .width('100%')
      .width(this.imgWidth)
      .objectFit(this.theme?.image?.objectFit)
      .margin({ bottom: this.lineSpace, top: this.lineSpace })
      .verticalAlign(ImageSpanAlignment.CENTER)
      .constraintSize({
        maxWidth: '100%'
      })
      .onClick(() => {
        markConfig.registerImageClick(this.href)
      })
      .onComplete((imageLoadResult) => {
        this.imgWidth = imageLoadResult.width //px2vp(imageLoadResult.width)
        // this.imgHeight = px2vp(imageLoadResult.height)
      })
  }
}