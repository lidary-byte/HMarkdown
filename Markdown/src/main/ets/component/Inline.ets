/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { Token } from '../core'
import { parseInlineToken } from '../core/parseInlineToken'
import { MarkdownOptionsClass } from '../Index'


@ComponentV2
export struct Inline {
  @Param @Require options: MarkdownOptionsClass
  @Param @Require token: Token[]
  inlineTextController = new TextController()

  aboutToAppear(): void {
    this.watchToken()
  }

  @Monitor('options.theme')
  watchTheme() {
    this.watchToken()
  }

  @Monitor('token')
  watchToken() {
    parseInlineToken({
      token: this.token,
      theme: this.options.theme,
      uiContext: this.getUIContext()
    }).then((data) => {
      this.inlineTextController.setStyledString(data)
    })

  }

  build() {
    Text(undefined, { controller: this.inlineTextController })
      .fontColor(this.options.theme.fontStyle?.fontColor)
      .fontSize(this.options.theme.fontStyle?.fontSize)
      .fontWeight(this.options.theme.fontStyle?.fontWeight)
      .maxLines(this.options.maxLines)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
      .lineSpacing(this.options.inlineLineSpacing)
  }
}
