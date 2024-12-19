/**
 * @Author : lcc
 * @CreateData : 2024/7/6
 * @Description:
 */
import { KEY_LINE_SPACE, KEY_THEME } from "../../../config/Constant"
import { MarkdownTheme } from "../../../config/MarkdownTheme"
import { markConfig } from "../../../Index"


@ComponentV2
export struct SpanImage {
  @Param @Require href: string = ''
  @Consumer(KEY_THEME) theme?: MarkdownTheme
  @Local imgWidth?: number = undefined
  @Consumer(KEY_LINE_SPACE) lineSpace?: number

  build() {
    ImageSpan(this.href)
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
        this.imgWidth = imageLoadResult.width
      })
  }
}