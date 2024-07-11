import { MarkdownFontStyle } from '../config/MarkdownTheme'
import { Tokens } from '../core'
import { SpanText } from './span/SpanText'
import { IMarkConfig } from '../config/MarkConfig'

@Component
export struct Heading {
  token?: Tokens.Heading
  @State fontStyle?: MarkdownFontStyle = undefined
  @Consume config: IMarkConfig

  aboutToAppear(): void {
    if (this.token?.depth == 1) {
      this.fontStyle = this.config.theme?.h1
    } else if (this.token?.depth == 2) {
      this.fontStyle = this.config.theme?.h2
    } else if (this.token?.depth == 3) {
      this.fontStyle = this.config.theme?.h3
    } else if (this.token?.depth == 4) {
      this.fontStyle = this.config.theme?.h4
    } else if (this.token?.depth == 5) {
      this.fontStyle = this.config.theme?.h5
    } else if (this.token?.depth == 6) {
      this.fontStyle = this.config.theme?.h6
    }
  }

  build() {
    Text() {
      SpanText(this.token?.tokens, this)
    }
    .fontColor(this.fontStyle?.fontColor)
    .fontWeight(this.fontStyle?.fontWeight)
    .fontSize(this.fontStyle?.fontSize)
    .lineSpacing(this.config.textLineSpace)
  }
}
