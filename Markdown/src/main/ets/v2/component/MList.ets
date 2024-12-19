/**
 * @Author : lcc
 * @CreateData : 2024/7/6
 * @Description:
 */
import { Inline } from './Inline'
import { LengthMetrics, MeasureText } from '@kit.ArkUI'
import { Token, Tokens } from '../../core'
import { KEY_FONT_STYLE, KEY_LINE_SPACE, KEY_TEXT_LINE_SPACE, KEY_THEME } from '../../config/Constant'
import { isFirstCharDigit } from '../../utils'
import { MarkdownFontStyle, MarkdownTheme } from '../../config/MarkdownTheme'

@ComponentV2
export struct MList {
  @Param @Require tokens: Tokens.List
  @Consumer(KEY_LINE_SPACE) lineSpace?: number

  build() {
    Column({ space: this.lineSpace }) {
      ForEach(this.tokens?.items, (item: Tokens.ListItem, index: number) => {
        ForEach(item.tokens, (itemChild: Token) => {
          if (itemChild.type === 'list') {
            MList({ tokens: itemChild as Tokens.List })
              .padding({ left: 32 })
          } else {
            UnorderedList({
              token: item.tokens[0]['tokens'],
              index: isFirstCharDigit(item.raw.trimStart()) ? Number(item.raw.trimStart().charAt(0)) :
                undefined
            })
          }
        })
      }, (item: Tokens.ListItem) => item.raw)
    }.alignItems(HorizontalAlign.Start)
    .padding({ left: 18 })
  }
}

/**
 * 无序列表
 */
@ComponentV2
struct UnorderedList {
  @Param @Require token: Token[]
  @Consumer(KEY_FONT_STYLE) fontStyle?: MarkdownFontStyle
  @Consumer(KEY_LINE_SPACE) lineSpace?: number
  @Consumer(KEY_THEME) theme?: MarkdownTheme
  @Consumer(KEY_TEXT_LINE_SPACE) textLineSpace?: number
  @Local marginTop: number = 0
  @Param index: number = 0

  aboutToAppear(): void {
    this.calcMargin()
  }

  @Monitor('token')
  calcMargin() {
    if (undefined !== this.token) {
      const tokenText = this.token?.map((item) => {
        return item['text'] as string
      })?.join()
      let textHeight: Length | undefined = MeasureText.measureTextSize({
        textContent: tokenText,
        constraintWidth: '100%',
        fontSize: this.fontStyle?.fontSize,
        maxLines: 1
      }).height

      if (textHeight && typeof textHeight === 'number') {
        this.marginTop = px2vp(textHeight / 2)
      }
    }
  }

  build() {
    Row({ space: 8 }) {
      if (this.index !== undefined) {
        Text(`${this.index}.`)
          .fontColor(this.fontStyle?.fontColor)
          .fontSize(this.fontStyle?.fontSize)
          .fontWeight(this.fontStyle?.fontWeight)
          .lineSpacing(LengthMetrics.vp(this.textLineSpace))
      } else {
        Circle({ width: 6, height: 6 })
          .margin({ top: this.marginTop })
          .foregroundColor(this.fontStyle?.fontColor)
      }

      Inline({ token: this.token })
        .layoutWeight(1)
    }.alignItems(VerticalAlign.Top)
    .width('100%')
  }
}