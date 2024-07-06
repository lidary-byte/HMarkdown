import { HeadingTheme } from '../config/MarkdownTheme'
import { Tokens } from '../core'
import { SpanText } from './span/SpanText'
import { markConfig, markTheme } from '../Index'

@Component
export struct Heading {
  token?: Tokens.Heading
  @State theme?: HeadingTheme = undefined

  aboutToAppear(): void {
    if (this.token?.depth == 1) {
      this.theme = markTheme().h1
    } else if (this.token?.depth == 2) {
      this.theme = markTheme().h2
    } else if (this.token?.depth == 3) {
      this.theme = markTheme().h3
    } else if (this.token?.depth == 4) {
      this.theme = markTheme().h4
    } else if (this.token?.depth == 5) {
      this.theme = markTheme().h5
    } else if (this.token?.depth == 6) {
      this.theme = markTheme().h6
    }
  }

  build() {
    Text() {
      SpanText(this.token?.tokens, this.theme?.fontColor)
    }
    .fontColor(this.theme?.fontColor)
    .fontWeight(this.theme?.fontWeight)
    .fontSize(this.theme?.fontSize)
    .lineSpacing(markConfig().textLineSpace)
  }
}
