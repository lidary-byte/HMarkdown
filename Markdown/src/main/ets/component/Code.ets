/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { Tokens } from '../core'
import { CodeToken, highlightCodeAnalyzer } from '../core/analyzer/HighlightAnalyzer'
import { MarkdownOptions } from '../Index'
import { copyToPasteboard, getTheme } from '../utils'


@ComponentV2
export struct Code {
  @Param @Require token: Tokens.Code
  @Param @Require options: MarkdownOptions
  private codes: string[] = []
  private codeLineHeight: number = 25
  aboutToAppear() {
    this.codes = this.token?.text.split("\n") ?? []
  }

  @Builder
  codeLine(code: string) {
    Text() {
      ForEach(highlightCodeAnalyzer(code), (token: CodeToken) => {
        Span(token.text)
          .fontColor(getTheme(this.options)?.code?.fontColor?.[token.type])
          .fontSize(getTheme(this.options).code?.fontSize)
      })
    }
    .textAlign(TextAlign.Start)
  }

  build() {
    Row() {
      Column() {
        Scroll() {
          Column() {
            ForEach(this.codes, (code: string) => {
              Row() {
                this.codeLine(code)
              }
              .height(this.codeLineHeight)
            })
          }.alignItems(HorizontalAlign.Start)
          .padding({
            top: 15,
            bottom: 15,
            left: 10,
            right: 5
          })
        }
        .scrollable(ScrollDirection.Horizontal)
      }.layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Image($r('app.media.ic_copy'))
        .width(20)
        .margin({ right: 8, top: 8 })
        .onClick(() => {
          copyToPasteboard(this.token?.text)
        })
    }
    .width('100%')
    .borderRadius(getTheme(this.options).code?.borderRadius)
    .alignItems(VerticalAlign.Top)
    .backgroundColor(getTheme(this.options).code?.backgroundColor)
  }
}
