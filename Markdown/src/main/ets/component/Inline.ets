/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { inlineToken } from './span/SpanText'
import { Token } from '../core'
import { MarkdownFontStyle, MarkdownTheme } from '../config/MarkdownTheme'


@ComponentV2
export struct Inline {
  maxLine?: number
  @Param @Require theme: MarkdownTheme
  @Param @Require token: Token[]
  @Param @Require fontStyle: MarkdownFontStyle
  inlineTextController = new TextController()

  aboutToAppear(): void {
    this.watchToken()
  }

  @Monitor('theme')
  watchTheme() {
    this.watchToken()
  }

  @Monitor('token')
  watchToken() {
    inlineToken({
      token: this.token,
      theme: this.theme,
      fontStyle: this.fontStyle,
      uiContext: this.getUIContext()
    }).then((data) => {
      this.inlineTextController.setStyledString(data)
    })

  }

  build() {
    Text(undefined, { controller: this.inlineTextController })
      .fontColor(this.fontStyle?.fontColor)
      .fontSize(this.fontStyle?.fontSize)
      .fontWeight(this.fontStyle?.fontWeight)
      .maxLines(this.maxLine)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
      .lineSpacing(this.theme.inlineLineSpacing)
    // .attributeModifier(this._mdInlineModifier)
  }
}
