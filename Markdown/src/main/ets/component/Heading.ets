import { HeadingTheme, MarkdownFontStyle, MarkdownTheme } from '../config/MarkdownTheme'
import { Tokens } from '../core'
import { SpanText } from './span/SpanText'
import { KEY_DEFAULT_FONT, KEY_LINE_SPACE, KEY_THEME } from '../config/Constant'
import { LengthMetrics } from '@ohos.arkui.node'

@Component
export struct Heading {
  token?: Tokens.Heading
  @State headingFontStyle?: HeadingTheme = undefined

  @StorageLink(KEY_DEFAULT_FONT) fontStyle?: MarkdownFontStyle = undefined
  @StorageLink(KEY_THEME) theme?: MarkdownTheme = undefined
  @StorageLink(KEY_LINE_SPACE) lineSpace?: number = undefined

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
    .lineSpacing(new LengthMetrics(this.lineSpace))
  }
}
