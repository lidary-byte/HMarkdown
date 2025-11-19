import { Tokens } from '../core'
import { MarkdownOptionsClass } from '../Index'
import { MarkdownComponent } from './MarkdownComponent'

/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description:
 */
@ComponentV2
export struct BlockQuote {
  @Param @Require token: Tokens.Blockquote
  @Param @Require options: MarkdownOptionsClass
  @Local blockHeight: Length = 0

  build() {
    Row() {
      Divider()
        .vertical(true)
        .strokeWidth(this.options.theme.blockQuoteStyle?.driveWidth)
        .height(this.blockHeight)
        .color(this.options.theme.blockQuoteStyle?.driveColor)
      MarkdownComponent({ tokenList: this.token?.tokens, options: this.options })
        .margin({ left: 10, right: 20 })
        .layoutWeight(1)
        .padding({ top: this.options.inlineLineSpacing, bottom: this.options.inlineLineSpacing })
    }
    .backgroundColor(this.options.theme.blockQuoteStyle?.backgroundColor)
    .borderRadius(this.options.theme.blockQuoteStyle?.borderRadius)
    .onSizeChange((_: SizeOptions, newValue: SizeOptions) => {
      if (newValue.height) {
        this.blockHeight = newValue.height
      }
    })
  }
}