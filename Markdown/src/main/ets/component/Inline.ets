/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { KEY_DEFAULT_FONT, KEY_LINE_SPACE, KEY_THEME } from '../config/Constant'
import { MarkdownFontStyle, MarkdownTheme } from '../config/MarkdownTheme'
import { Token } from '../core'
import { SpanText } from './span/SpanText'
import { LengthMetrics } from '@ohos.arkui.node'


@Component
export struct Inline {
  token?: Token[]
  @StorageLink(KEY_DEFAULT_FONT) fontStyle?: MarkdownFontStyle = undefined
  @StorageLink(KEY_LINE_SPACE) lineSpace?: number = undefined
  @StorageLink(KEY_THEME) theme?: MarkdownTheme = undefined
  build() {
    Row() {
      Text() {
        SpanText(this.token, this)
      }
      .fontColor(this.fontStyle?.fontColor)
      .fontSize(this.fontStyle?.fontSize)
      .fontWeight(this.fontStyle?.fontWeight)
      .lineSpacing(new LengthMetrics(this.lineSpace))
    }
  }
}
