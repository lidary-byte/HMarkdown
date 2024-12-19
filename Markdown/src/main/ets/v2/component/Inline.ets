/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { SpanText } from './span/SpanText'
import { LengthMetrics } from '@ohos.arkui.node'
import { Token } from '../../core'
import { MarkdownFontStyle, MarkdownTheme } from '../../config/MarkdownTheme'
import { KEY_FONT_STYLE, KEY_LINE_SPACE, KEY_TEXT_LINE_SPACE, KEY_THEME } from '../../config/Constant'


@ComponentV2
export struct Inline {
  maxLine?: number
  @Param @Require token: Token[]
  @Consumer(KEY_FONT_STYLE) fontStyle?: MarkdownFontStyle
  @Consumer(KEY_LINE_SPACE) lineSpace?: number
  @Consumer(KEY_THEME) theme?: MarkdownTheme
  @Consumer(KEY_TEXT_LINE_SPACE) textLineSpace?: number
  @Consumer() _mdInlineModifier?: AttributeModifier<TextAttribute>

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
      .attributeModifier(this._mdInlineModifier)
    }
  }
}
