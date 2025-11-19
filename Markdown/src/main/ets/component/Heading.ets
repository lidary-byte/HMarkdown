import { Tokens } from '../core'
import { parseInlineToken } from '../core/parseInlineToken'
import { MarkdownOptions } from '../Index'
import { getTheme } from '../utils'

@ComponentV2
export struct Heading {
  @Param @Require token: Tokens.Heading
  @Param @Require options: MarkdownOptions
  inlineTextController = new TextController()
  inlineTextStyle = new MutableStyledString('')

  aboutToAppear(): void {
    this.watchToken()
  }

  @Monitor('options.theme')
  watchTheme() {
    this.watchToken()
  }

  @Monitor('token')
  watchToken() {
    if (this.token?.tokens) {
      let fontStyle = getTheme(this.options).headingStyle?.[this.token.depth]!
      parseInlineToken({
        token: this.token?.tokens ?? [],
        uiContext: this.getUIContext(),
        options: this.options,
        // fontStyle: this.options.theme.headingStyle?.[this.token.depth]!
      }).then((data) => {
        try {
          let style = data?.getStyles(0, data.getString().length, StyledStringKey.FONT)
          style?.forEach((e) => {
            data?.replaceStyle({
              start: e.start,
              length: e.length,
              styledKey: StyledStringKey.FONT,
              styledValue:
              new TextStyle({
                fontWeight: fontStyle.fontWeight,
                fontColor: e.styledValue['fontColor'],
              })
            })
          })

        } catch (error) {
        }
        this.inlineTextController.setStyledString(data)
      })

    }
  }

  build() {
    Text(undefined, { controller: this.inlineTextController })
      .fontColor(getTheme(this.options).headingStyle?.[this.token?.depth]?.fontColor)
      .fontSize(getTheme(this.options).headingStyle?.[this.token?.depth]?.fontSize)
      .fontWeight(getTheme(this.options).headingStyle?.[this.token?.depth]?.fontWeight)
      .lineSpacing(this.options.inlineLineSpace)
  }
}
