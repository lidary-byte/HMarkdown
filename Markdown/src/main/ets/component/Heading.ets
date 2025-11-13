import { inlineToken } from './span/SpanText'
import { MarkdownTheme } from '../config/MarkdownTheme'
import { Tokens } from '../core'

@ComponentV2
export struct Heading {
  @Param @Require token: Tokens.Heading
  @Param @Require theme: MarkdownTheme
  inlineTextController = new TextController()
  inlineTextStyle = new MutableStyledString('')

  aboutToAppear(): void {
    this.watchToken()
  }

  @Monitor('theme')
  watchTheme() {
    this.watchToken()
  }

  @Monitor('token')
  watchToken() {
    if (this.token?.tokens) {
      inlineToken({
        token: this.token?.tokens ?? [],
        uiContext: this.getUIContext(),
        theme: this.theme,
        fontStyle: this.theme.heading?.[this.token.depth]!
      }).then((data) => {
        this.inlineTextController.setStyledString(data)
      })

    }
  }

  build() {
    Text(undefined, { controller: this.inlineTextController })
      .fontColor(this.theme.heading?.[this.token?.depth]?.fontColor)
      .fontSize(this.theme.heading?.[this.token?.depth]?.fontSize)
      .fontWeight(this.theme.heading?.[this.token?.depth]?.fontWeight)
      .lineSpacing(this.theme.heading?.[this.token?.depth]?.lineSpacing)
  }
}
