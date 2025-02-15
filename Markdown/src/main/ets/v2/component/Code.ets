/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { KEY_FONT_STYLE, KEY_THEME } from "../../config/Constant"
import { MarkdownFontStyle, MarkdownTheme } from "../../config/MarkdownTheme"
import { Tokens } from "../../core"
import { CodeToken, highlightCodeAnalyzer } from "../../core/analyzer/HighlightAnalyzer"
import { copyToPasteboard } from "../../utils"


@ComponentV2
export struct Code {
  @Param token?: Tokens.Code = undefined
  private codes: string[] = []
  private codeLineHeight: number = 25
  @Consumer(KEY_FONT_STYLE) fontStyle?: MarkdownFontStyle
  @Consumer(KEY_THEME) theme?: MarkdownTheme
  aboutToAppear() {
    this.codes = this.token?.text.split("\n") ?? []
  }

  @Builder
  codeLine(code: string) {
    Text() {
      ForEach(highlightCodeAnalyzer(code), (token: CodeToken) => {
        Span(token.text)
          .fontColor(this.theme?.codeHighlight?.[token.type])
          .fontSize(this.fontStyle?.fontSize)
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
