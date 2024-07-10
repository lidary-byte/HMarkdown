import { HeadingTheme } from '../config/MarkdownTheme'
import { Tokens } from '../core'
import { SpanText } from './span/SpanText'
import { IMarkConfig } from '../config/MarkConfig'

@Component
export struct Heading {
  token?: Tokens.Heading
  @State theme?: HeadingTheme = undefined
  @Link markConfig: IMarkConfig

  aboutToAppear(): void {
    if (this.token?.depth == 1) {
      this.theme = this.markConfig.theme?.h1
    } else if (this.token?.depth == 2) {
      this.theme = this.markConfig.theme?.h2
    } else if (this.token?.depth == 3) {
      this.theme = this.markConfig.theme?.h3
    } else if (this.token?.depth == 4) {
      this.theme = this.markConfig.theme?.h4
    } else if (this.token?.depth == 5) {
      this.theme = this.markConfig.theme?.h5
    } else if (this.token?.depth == 6) {
      this.theme = this.markConfig.theme?.h6
    }
  }

  build() {
    Text() {
      SpanText(this.token?.tokens, this.theme?.fontColor)
    }
    .fontColor(this.theme?.fontColor)
    .fontWeight(this.theme?.fontWeight)
    .fontSize(this.theme?.fontSize)
    .lineSpacing(this.markConfig.textLineSpace)
  }
}
