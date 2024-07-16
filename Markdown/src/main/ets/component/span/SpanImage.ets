/**
 * @Author : lcc
 * @CreateData : 2024/7/6
 * @Description:
 */
import { KEY_THEME } from '../../config/Constant'
import { MarkdownTheme } from '../../config/MarkdownTheme'
import { markConfig } from '../../Index'

@Component
export struct SpanImage {
  @Consume(KEY_THEME) theme: MarkdownTheme
  href: string = ''
  @State imgHeight?: number = undefined
  @State imgWidth?: number = undefined

  build() {
    ImageSpan(this.href)
      .height(this.imgHeight)
      .width(this.imgWidth)
      .objectFit(this.theme?.image?.objectFit)
      .onClick(() => {
        markConfig.registerImageClick(this.href)
      })
      .onComplete((imageLoadResult) => {
        this.imgWidth = px2vp(imageLoadResult.width)
        this.imgHeight = px2vp(imageLoadResult.height)
      })
  }
}