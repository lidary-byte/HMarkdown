/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description:
 */
import { IMarkConfig } from '../config/MarkConfig'
import { Tokens } from '../core/Tokens'
import { MarkdownComponent } from '../MarkdownComponent'

@Component
export struct BlockQuote {
  token?: Tokens.Blockquote
  @State blockHeight: Length = 0
  @Consume config: IMarkConfig

  build() {
    Row() {
      Divider()
        .vertical(true)
        .strokeWidth( this.config.theme?.blockQuote?.driveWidth ?? 0)
        .height(this.blockHeight)
        .color( this.config.theme?.blockQuote?.driveColor ??  this.config.theme?.themeColor)
      MarkdownComponent({ tokenList: this.token?.tokens })
        .margin({ left: 10, right: 20 })
        .layoutWeight(1)
        .padding({ top:  this.config.lineSpace, bottom:  this.config.lineSpace })
    }
    .backgroundColor( this.config.theme?.blockQuote?.backgroundColor)
    .borderRadius({
      topLeft:  this.config.theme?.blockQuote?.borderRadius,
      bottomLeft:  this.config.theme?.blockQuote?.borderRadius
    })
    .clip(true)
    .onSizeChange((_: SizeOptions, newValue: SizeOptions) => {
      if (newValue.height) {
        this.blockHeight = newValue.height
      }
    })
  }
}