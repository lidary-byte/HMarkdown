/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description:
 */
import { KEY_LINE_SPACE, KEY_THEME } from "../../config/Constant"
import { MarkdownTheme } from "../../config/MarkdownTheme"
import { Tokens } from "../../core"
import { MarkdownComponentV2 } from "./MarkdownComponentV2"


@ComponentV2
export struct BlockQuote {
  @Param @Require token: Tokens.Blockquote
  @Local blockHeight: Length = 0
  @Consumer(KEY_THEME) theme?: MarkdownTheme
  @Consumer(KEY_LINE_SPACE) lineSpace?: number

  build() {
    Row() {
      Divider()
        .vertical(true)
        .strokeWidth(this.theme?.blockQuote?.driveWidth ?? 0)
        .height(this.blockHeight)
        .color(this.theme?.blockQuote?.driveColor ?? this.theme?.themeColor)
      MarkdownComponentV2({ tokenList: this.token?.tokens })
        .margin({ left: 10, right: 20 })
        .layoutWeight(1)
        .padding({ top: this.lineSpace, bottom: this.lineSpace })
    }
    .backgroundColor(this.theme?.blockQuote?.backgroundColor)
    .borderRadius({
      topLeft: this.theme?.blockQuote?.borderRadius,
      bottomLeft: this.theme?.blockQuote?.borderRadius
    })
    .clip(true)
    .onSizeChange((_: SizeOptions, newValue: SizeOptions) => {
      if (newValue.height) {
        this.blockHeight = newValue.height
      }
    })
  }
}