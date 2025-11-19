import { Tokens } from '../core'
import { MarkdownOptions } from '../Index'
import { getTheme } from '../utils'
import { MarkdownComponent } from './MarkdownComponent'

/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description:
 */
@ComponentV2
export struct BlockQuote {
  @Param @Require token: Tokens.Blockquote
  @Param @Require options: MarkdownOptions
  @Local blockHeight: Length = 0

  build() {
    Row() {
      Divider()
        .vertical(true)
        .strokeWidth(getTheme(this.options).blockQuoteStyle?.driveWidth)
        .height(this.blockHeight)
        .color(getTheme(this.options).blockQuoteStyle?.driveColor)
      MarkdownComponent({ tokenList: this.token?.tokens, options: this.options })
        .margin({ left: 10, right: 20 })
        .layoutWeight(1)
        .padding({ top: this.options.inlineLineSpace, bottom: this.options.inlineLineSpace })
    }
    .backgroundColor(getTheme(this.options).blockQuoteStyle?.backgroundColor)
    .borderRadius(getTheme(this.options).blockQuoteStyle?.borderRadius)
    .onSizeChange((_: SizeOptions, newValue: SizeOptions) => {
      if (newValue.height) {
        this.blockHeight = newValue.height
      }
    })
  }
}