/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { Token } from '../core'
import { parseInlineToken } from '../core/parseInlineToken'
import { MarkdownOptions } from '../Index'
import { getTheme } from '../utils'


@ComponentV2
export struct Inline {
  @Param @Require options: MarkdownOptions
  @Param @Require token: Token[]
  inlineTextController = new TextController()

  aboutToAppear(): void {
    this.watchToken()
  }

  @Monitor('token','options')
  watchToken() {
    parseInlineToken({
      token: this.token,
      options: this.options,
      uiContext: this.getUIContext()
    }).then((data) => {
      this.inlineTextController.setStyledString(data)
    })

  }

  parseToken() {
    parseInlineToken({
      token: this.token,
      options: this.options,
      uiContext: this.getUIContext()
    }).then((data) => {
      this.inlineTextController.setStyledString(data)
    })
  }

  build() {
    Text(undefined, { controller: this.inlineTextController })
      .fontColor(getTheme(this.options).fontStyle?.fontColor)
      .fontSize(getTheme(this.options).fontStyle?.fontSize)
      .fontWeight(getTheme(this.options).fontStyle?.fontWeight)
      .maxLines(this.options.maxLines)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
      .lineSpacing(this.options.inlineLineSpace)
  }
}
