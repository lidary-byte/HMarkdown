/**
 * @Author : lcc
 * @CreateData : 2024/7/6
 * @Description:
 */
import { KEY_FONT_STYLE, KEY_LINE_SPACE, KEY_TEXT_LINE_SPACE, KEY_THEME } from '../config/Constant'
import { Token, Tokens } from '../core'
import { Inline } from './Inline'
import { MarkdownFontStyle, MarkdownTheme } from '../config/MarkdownTheme'
import { MeasureText } from '@kit.ArkUI'

@Component
export struct MList {
  @Prop tokens: Tokens.List
  @Consume(KEY_LINE_SPACE) lineSpace: number

  build() {

    Column({ space: this.lineSpace }) {
      ForEach(this.tokens?.items, (item: Tokens.ListItem) => {
        ForEach(item.tokens, (itemChild: Token) => {
          if (itemChild.type === 'list') {
            MList({ tokens: itemChild as Tokens.List })
              .margin({ left: 32 })
          } else {
            UnorderedList({ token: item.tokens[0]['tokens'] })
          }
        })
      })
    }.alignItems(HorizontalAlign.Start)
  }
}

/**
 * 无序列表
 */
@Component
struct UnorderedList {
  @Prop @Watch('calcMargin') token: Token[]
  @Consume(KEY_FONT_STYLE) fontStyle: MarkdownFontStyle
  @Consume(KEY_LINE_SPACE) lineSpace: number
  @Consume(KEY_THEME) theme: MarkdownTheme
  @Consume(KEY_TEXT_LINE_SPACE) textLineSpace: number
  @State marginTop: number = 0

  aboutToAppear(): void {
    this.calcMargin()
  }

  calcMargin() {
    const tokenText: string = this.token.map((item) => {
      return item['text'] as string
    }).join()
    let textHeight: Length | undefined = MeasureText.measureTextSize({
      textContent: tokenText,
      constraintWidth: '100%',
      fontSize: this.fontStyle?.fontSize,
      maxLines: 1
    }).height

    if (textHeight && typeof textHeight === 'number') {
      this.marginTop = px2vp(textHeight / 2 - vp2px(6) / 2)
    }
    // console.error('-------行高:' + firstLineSize.height)
  }

  build() {
    Row({ space: 8 }) {
      Circle({ width: 6, height: 6 })
        .margin({ top: this.marginTop })
        .foregroundColor(this.fontStyle.fontColor)

      Inline({ token: this.token })
    }.alignItems(VerticalAlign.Top)
  }
}