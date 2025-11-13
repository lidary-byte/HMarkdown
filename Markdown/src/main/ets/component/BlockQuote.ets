/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description:
 */
import { MarkdownTheme } from '../config/MarkdownTheme'
import { Tokens } from '../core'
import { MarkdownComponent } from './MarkdownComponent'


@ComponentV2
export struct BlockQuote {
  @Param @Require token: Tokens.Blockquote
  @Param @Require theme: MarkdownTheme
  @Local blockHeight: Length = 0

  build() {
    Row() {
      Divider()
        .vertical(true)
        .strokeWidth(this.theme.blockQuote?.driveWidth ?? 0)
        .height(this.blockHeight)
        .color(this.theme.blockQuote?.driveColor)
      MarkdownComponent({ tokenList: this.token?.tokens, theme: this.theme })
        .margin({ left: 10, right: 20 })
        .layoutWeight(1)
        .padding({ top: this.theme.blockQuote?.lineSpacing, bottom: this.theme.blockQuote?.lineSpacing })
    }
    .backgroundColor(this.theme.blockQuote?.backgroundColor)
    .borderRadius(this.theme.blockQuote?.borderRadius)
    .clip(true)
    .onSizeChange((_: SizeOptions, newValue: SizeOptions) => {
      if (newValue.height) {
        this.blockHeight = newValue.height
      }
    })
  }
}