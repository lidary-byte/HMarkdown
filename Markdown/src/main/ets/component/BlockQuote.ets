/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description:
 */
import { Tokens } from '../core/Tokens'
import { markConfig, markTheme } from '../Index'
import { MarkdownComponent } from '../MarkdownComponent'

@Component
export struct BlockQuote {
  token?: Tokens.Blockquote
  @State blockHeight: Length = 0

  build() {
    Row() {
      Divider()
        .vertical(true)
        .strokeWidth(markTheme()?.blockQuote?.driveWidth ?? 0)
        .height(this.blockHeight)
        .color(markTheme()?.blockQuote?.driveColor ?? markTheme()?.themeColor)
      MarkdownComponent({ tokenList: this.token?.tokens })
        .margin({ left: 10, right: 20 })
        .layoutWeight(1)
        .padding({ top: markConfig().lineSpace, bottom: markConfig().lineSpace })
    }
    .backgroundColor(markTheme().blockQuote?.backgroundColor)
    .borderRadius({ topLeft: markTheme().blockQuote?.borderRadius, bottomLeft: markTheme().blockQuote?.borderRadius })
    .clip(true)
    .onSizeChange((_: SizeOptions, newValue: SizeOptions) => {
      if (newValue.height) {
        this.blockHeight = newValue.height
      }

    })
  }
}