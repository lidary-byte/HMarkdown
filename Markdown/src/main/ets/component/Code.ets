/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { CodeToken, highlightCodeAnalyzer } from '../core/analyzer/HighlightAnalyzer'
import { Tokens } from '../core'
import { copyToPasteboard } from '../utils'
import { IMarkConfig } from '../config/MarkConfig'


@Component
export struct Code {
  token?: Tokens.Code
  private codes: string[] = []
  private codeLineHeight: number = 25
  @Consume config: IMarkConfig
  aboutToAppear() {
    this.codes = this.token?.text.split("\n") ?? []
  }

  @Builder
  codeLine(code: string) {
    Text() {
      ForEach(highlightCodeAnalyzer(code), (token: CodeToken) => {
        Span(token.text)
          .fontColor(this.config.theme?.codeHighlight?.[token.type])
          .fontSize(this.config.theme?.defaultFont?.fontSize)
      })
    }
    .textAlign(TextAlign.Start)
  }

  build() {
    //代码体
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
        .scrollBarColor('#33000000')
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
    .borderRadius(10)
    .alignItems(VerticalAlign.Top)
    .backgroundColor('#F6F8FA')
  }
}
