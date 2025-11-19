/**
 * @Author : lcc
 * @CreateData : 2024/7/6
 * @Description:
 */
import { Token, Tokens } from '../core'
import { Inline } from './Inline'
import { MarkdownOptionsClass } from '../Index'

@ComponentV2
export struct MList {
  @Param @Require tokens: Tokens.List
  @Param @Require options: MarkdownOptionsClass

  build() {
    Column({ space: this.options.lineSpacing }) {
      ForEach(this.tokens?.items, (item: Tokens.ListItem, index: number) => {
        Row({ space: 8 }) {
          if (this.tokens.ordered) {
            Text(typeof this.tokens.start === 'number' ? `${this.tokens.start + index}.` : '')
              .fontColor(this.options.theme.fontStyle?.fontColor)
              .fontSize(this.options.theme.fontStyle?.fontSize)
              .fontWeight(this.options.theme.fontStyle?.fontWeight)
              .lineSpacing(this.options.inlineLineSpacing)
          } else {
            Circle({ width: 6, height: 6 })
              .margin({ top: this.calcMarginTop(item.text, 6) })
              .foregroundColor(this.options.theme.themeColor)
          }
          Column({ space: this.options.lineSpacing }) {
            ForEach(item.tokens, (itemChild: Token, _: number) => {
              if (itemChild.type === 'list') {
                MList({ tokens: itemChild as Tokens.List, options: this.options })
                  .padding({ left: this.options.theme.listStyle?.marginLeft })
              } else if (itemChild.type === 'space') {
                Stack()
              } else {
                Inline({ token: itemChild['tokens'], options: this.options })
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
  }

  private calcMarginTop(tokenText?: string, circleSize?: number): number {
    if (tokenText) {
      let textHeight: Length | undefined = this.getUIContext().getMeasureUtils().measureTextSize({
        textContent: tokenText,
        constraintWidth: '100%',
        fontSize: this.options.theme.fontStyle?.fontSize,
        maxLines: 1
      }).height

      if (textHeight && typeof textHeight === 'number') {
        try {
          return this.getUIContext().px2vp(textHeight) / 2 - (circleSize ?? 0) / 2 +
            Number.parseInt(this.options.lineSpacing?.toString() ?? '0') / 2
        } catch (_) {
        }
      }
    }
    return 0
  }
}

