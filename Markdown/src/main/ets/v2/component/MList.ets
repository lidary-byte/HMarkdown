/**
 * @Author : lcc
 * @CreateData : 2024/7/6
 * @Description:
 */
import { LengthMetrics } from '@kit.ArkUI'
import { Token, Tokens } from '../../core'
import { KEY_FONT_STYLE, KEY_LINE_SPACE, KEY_TEXT_LINE_SPACE } from '../../config/Constant'
import { MarkdownFontStyle } from '../../config/MarkdownTheme'
import { Inline } from './Inline'

@ComponentV2
export struct MList {
  @Param @Require tokens: Tokens.List
  @Consumer(KEY_LINE_SPACE) lineSpace?: number
  @Consumer(KEY_FONT_STYLE) fontStyle?: MarkdownFontStyle
  @Consumer(KEY_TEXT_LINE_SPACE) textLineSpace?: number

  build() {
    Column({ space: this.lineSpace }) {
      ForEach(this.tokens?.items, (item: Tokens.ListItem, index: number) => {
        Row({ space: 8 }) {
          if (this.tokens.ordered) {
            Text(typeof this.tokens.start === 'number' ? `${this.tokens.start + index}.` : '')
              .fontColor(this.fontStyle?.fontColor)
              .fontSize(this.fontStyle?.fontSize)
              .fontWeight(this.fontStyle?.fontWeight)
              .lineSpacing(LengthMetrics.vp(this.textLineSpace))
          } else {
            Circle({ width: 6, height: 6 })
              .margin({ top: this.calcMarginTop(item.text) })
              .foregroundColor(this.fontStyle?.fontColor)
          }
          Column({ space: this.lineSpace }) {
            ForEach(item.tokens, (itemChild: Token, _: number) => {
              if (itemChild.type === 'list') {
                MList({ tokens: itemChild as Tokens.List })
                  .padding({ left: 32 })
              } else if (itemChild.type === 'space') {
                Stack()
              } else {
                Inline({ token: itemChild['tokens'] })
              }
            }, (item: Token) => item.raw)
          }.layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        }.width('100%')
        .alignItems(VerticalAlign.Top)
      }, (item: Tokens.ListItem) => item.raw)
    }.layoutWeight(1)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({ left: 18 })
  }

  private calcMarginTop(tokenText?: string): number {
    if (tokenText) {
      let textHeight: Length | undefined = this.getUIContext().getMeasureUtils().measureTextSize({
        textContent: tokenText,
        constraintWidth: '100%',
        fontSize: this.fontStyle?.fontSize,
        maxLines: 1
      }).height

      if (textHeight && typeof textHeight === 'number') {
        return this.getUIContext().px2vp(textHeight / 2)
      }
    }
    return 0
  }
}

