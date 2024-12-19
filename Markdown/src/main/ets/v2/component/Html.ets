/**
 * @Author : lcc
 * @CreateData : 2024/7/22
 * @Description:
 */
import { LengthMetrics } from '@kit.ArkUI'
import { KEY_FONT_STYLE, KEY_LINE_SPACE, KEY_TEXT_LINE_SPACE, KEY_THEME } from '../../config/Constant'
import { MarkdownFontStyle, MarkdownTheme } from '../../config/MarkdownTheme'

@ComponentV2
export struct Html {
  @Param @Require html: string
  @Consumer(KEY_FONT_STYLE) fontStyle?: MarkdownFontStyle
  @Consumer(KEY_LINE_SPACE) lineSpace?: number
  @Consumer(KEY_THEME) theme?: MarkdownTheme
  @Consumer(KEY_TEXT_LINE_SPACE) textLineSpace?: number

  build() {
    Row() {
      Text(this.html)
      .fontColor(this.fontStyle?.fontColor)
      .fontSize(this.fontStyle?.fontSize)
      .fontWeight(this.fontStyle?.fontWeight)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
      .lineSpacing(LengthMetrics.vp(this.textLineSpace))
    }
  }
}