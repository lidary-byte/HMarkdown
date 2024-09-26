/**
 * @Author : lcc
 * @CreateData : 2024/7/22
 * @Description:
 */
import { KEY_FONT_STYLE, KEY_LINE_SPACE, KEY_TEXT_LINE_SPACE, KEY_THEME } from '../config/Constant'
import { MarkdownFontStyle, MarkdownTheme } from '../config/MarkdownTheme'
import { LengthMetrics } from '@kit.ArkUI'

@Component
export struct Html {
  @Prop html: string
  @Consume(KEY_FONT_STYLE) fontStyle: MarkdownFontStyle
  @Consume(KEY_LINE_SPACE) lineSpace: number
  @Consume(KEY_THEME) theme: MarkdownTheme
  @Consume(KEY_TEXT_LINE_SPACE) textLineSpace: number

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