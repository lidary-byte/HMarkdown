import { SpanText } from './span/SpanText'
import { LengthMetrics } from '@ohos.arkui.node'
import { HeadingTheme, MarkdownFontStyle, MarkdownTheme } from '../../config/MarkdownTheme'
import { Tokens } from '../../core'
import { KEY_FONT_STYLE, KEY_LINE_SPACE, KEY_TEXT_LINE_SPACE, KEY_THEME } from '../../config/Constant'

@ComponentV2
export struct Heading {
  @Param token?: Tokens.Heading = undefined
  @Local headingFontStyle?: HeadingTheme = undefined
  @Consumer(KEY_FONT_STYLE) fontStyle?: MarkdownFontStyle
  @Consumer(KEY_THEME) theme?: MarkdownTheme
  @Consumer(KEY_LINE_SPACE) lineSpace?: number
  @Consumer(KEY_TEXT_LINE_SPACE) textLineSpace?: number

  aboutToAppear(): void {
    if (this.token?.depth == 1) {
      this.headingFontStyle = this.theme?.h1
    } else if (this.token?.depth == 2) {
      this.headingFontStyle = this.theme?.h2
    } else if (this.token?.depth == 3) {
      this.headingFontStyle = this.theme?.h3
    } else if (this.token?.depth == 4) {
      this.headingFontStyle = this.theme?.h4
    } else if (this.token?.depth == 5) {
      this.headingFontStyle = this.theme?.h5
    } else if (this.token?.depth == 6) {
      this.headingFontStyle = this.theme?.h6
    }
  }

  build() {
    Text() {
      SpanText(this.token?.tokens, this)
    }
    .fontColor(this.fontStyle?.fontColor)
    .fontWeight(this.headingFontStyle?.fontWeight)
    .fontSize(this.headingFontStyle?.fontSize)
    .lineSpacing(new LengthMetrics(this.textLineSpace))
  }
}
