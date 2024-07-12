/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { KEY_FONT_STYLE, KEY_LINE_SPACE, KEY_TEXT_LINE_SPACE, KEY_THEME } from '../config/Constant'
import { MarkdownFontStyle, MarkdownTheme } from '../config/MarkdownTheme'
import { Token } from '../core'
import { SpanText } from './span/SpanText'
import { LengthMetrics } from '@ohos.arkui.node'


@Component
export struct Inline {
  token?: Token[]
  @Consume(KEY_FONT_STYLE) fontStyle: MarkdownFontStyle
  @Consume(KEY_LINE_SPACE) lineSpace: number
  @Consume(KEY_THEME) theme: MarkdownTheme
  @Consume(KEY_TEXT_LINE_SPACE) textLineSpace: number
  build() {
    Row() {
      Text() {
        SpanText(this.token, this)
      }
      .fontColor(this.fontStyle?.fontColor)
      .fontSize(this.fontStyle?.fontSize)
      .fontWeight(this.fontStyle?.fontWeight)
      .lineSpacing(new LengthMetrics(this.textLineSpace))
    }
  }
}
