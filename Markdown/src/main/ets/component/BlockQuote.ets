/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description:
 */
import { IMarkConfig } from '../config/MarkConfig'
import { Tokens } from '../core/Tokens'
// import { markConfig } from '../Index'
import { MarkdownComponent } from '../MarkdownComponent'

@Component
export struct BlockQuote {
  token?: Tokens.Blockquote
  @State blockHeight: Length = 0
  @Link markConfig: IMarkConfig

  build() {
    Row() {
      Divider()
        .vertical(true)
        .strokeWidth(this.markConfig.theme?.blockQuote?.driveWidth ?? 0)
        .height(this.blockHeight)
        .color(this.markConfig.theme?.blockQuote?.driveColor ?? this.markConfig.theme?.themeColor)
      MarkdownComponent({ tokenList: this.token?.tokens, config: this.markConfig })
        .margin({ left: 10, right: 20 })
        .layoutWeight(1)
        .padding({ top: this.markConfig.lineSpace, bottom: this.markConfig.lineSpace })
    }
    .backgroundColor(this.markConfig.theme?.blockQuote?.backgroundColor)
    .borderRadius({
      topLeft: this.markConfig.theme?.blockQuote?.borderRadius,
      bottomLeft: this.markConfig.theme?.blockQuote?.borderRadius
    })
    .clip(true)
    .onSizeChange((_: SizeOptions, newValue: SizeOptions) => {
      if (newValue.height) {
        this.blockHeight = newValue.height
      }
    })
  }
}