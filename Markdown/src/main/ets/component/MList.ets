/**
 * @Author : lcc
 * @CreateData : 2024/7/6
 * @Description:
 */
import { Token, Tokens } from '../core'
import { MarkdownTheme } from '../config/MarkdownTheme'
import { Inline } from './Inline'

@ComponentV2
export struct MList {
  @Param @Require tokens: Tokens.List
  @Param @Require theme: MarkdownTheme

  build() {
    Column({ space: this.theme.lineSpacing }) {
      ForEach(this.tokens?.items, (item: Tokens.ListItem, index: number) => {
        Row({ space: 8 }) {
          if (this.tokens.ordered) {
            Text(typeof this.tokens.start === 'number' ? `${this.tokens.start + index}.` : '')
              .fontColor(this.theme.list?.fontStyle?.fontColor)
              .fontSize(this.theme.list?.fontStyle?.fontSize)
              .fontWeight(this.theme.list?.fontStyle?.fontWeight)
              .lineSpacing(this.theme.inlineLineSpacing)
          } else {
            Circle({ width: 6, height: 6 })
              .margin({ top: this.calcMarginTop(item.text) })
              .foregroundColor(this.theme?.themeColor)
          }
          Column({ space: this.theme.lineSpacing }) {
            ForEach(item.tokens, (itemChild: Token, _: number) => {
              if (itemChild.type === 'list') {
                MList({ tokens: itemChild as Tokens.List, theme: this.theme })
                  .padding({ left: 32 })
              } else if (itemChild.type === 'space') {
                Stack()
              } else {
                Inline({ token: itemChild['tokens'], theme: this.theme, fontStyle: this.theme.list?.fontStyle })
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
    .padding({ left: this.theme.list?.marginLeft })
  }

  private calcMarginTop(tokenText?: string): number {
    if (tokenText) {
      let textHeight: Length | undefined = this.getUIContext().getMeasureUtils().measureTextSize({
        textContent: tokenText,
        constraintWidth: '100%',
        fontSize: this.theme.list?.fontStyle?.fontSize,
        maxLines: 1
      }).height

      if (textHeight && typeof textHeight === 'number') {
        return this.getUIContext().px2vp(textHeight / 2)
      }
    }
    return 0
  }
}

