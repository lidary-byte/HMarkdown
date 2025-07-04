/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { KEY_FONT_STYLE, KEY_LINE_SPACE, KEY_TEXT_LINE_SPACE, KEY_THEME } from '../config/Constant'
import { MarkdownFontStyle, MarkdownTheme } from '../config/MarkdownTheme'
import { Token } from '../core'
import { LengthMetrics } from '@ohos.arkui.node'
import { SpanText } from '../v2/component/span/SpanText'


@Component
export struct Inline {
  maxLine?: number
  @Prop token: Token[]
  @Consume(KEY_FONT_STYLE) fontStyle: MarkdownFontStyle
  @Consume(KEY_LINE_SPACE) lineSpace: number
  @Consume(KEY_THEME) theme: MarkdownTheme
  @Consume(KEY_TEXT_LINE_SPACE) textLineSpace: number
  @Consume mdInlineModifier: AttributeModifier<TextAttribute>

  build() {
    Row() {
      Text() {
        SpanText(this.token, this)
      }
      .fontColor(this.fontStyle?.fontColor)
      .fontSize(this.fontStyle?.fontSize)
      .fontWeight(this.fontStyle?.fontWeight)
      .maxLines(this.maxLine)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
      .lineSpacing(LengthMetrics.vp(this.textLineSpace))
      .attributeModifier(this.mdInlineModifier)
    }
  }
}
