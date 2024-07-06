/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { CodeToken, highlightCodeAnalyzer } from '../analyzer/HighlightAnalyzer'
import { Tokens } from '../core'


@Component
struct TrafficLight {
  @Styles
  circle(){
    .width(16)
    .height(16)
    .borderRadius(8)
  }

  build() {
    Flex({
      justifyContent: FlexAlign.SpaceBetween
    }) {
      Row()
        .circle()
        .backgroundColor('#fc625d')
      Row()
        .circle()
        .backgroundColor('#fdbc40')
      Row()
        .circle()
        .backgroundColor('#35cd4b')
    }
    .width(70)
  }
}

const codeHighlight: Record<string, ResourceColor | undefined> = {
  'keyword': '#A626A4',
  'type': '#4078F2',
  'number': '#986801',
  'symbol': '#E4564A',
  'string': '#50A14E',
  'text': undefined,
  'boolean': '#986801',
}

@Component
export struct Code {
  token?: Tokens.Code
  // style?: BiuMarkDownStyle
  private codes: string[] = []
  private codeLineHeight: number = 25

  // @Consume themeColor: ResourceColor
  // @Consume fontColor: ResourceColor
  // @Consume fontSize: Length

  aboutToAppear() {
    this.codes = this.token?.text.split("\n") ?? []
  }

  @Builder
  codeLine(code: string) {
    Text() {
      ForEach(highlightCodeAnalyzer(code), (token: CodeToken) => {
        Span(token.text)
        // .fontColor(codeHighlight[token.type] ?? this.fontColor)
        // .fontSize(this.fontSize)
      })
    }
    .textAlign(TextAlign.Start)
  }

  build() {


    //代码体
    Row() {


      //代码

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

        })
    }
    .width('100%')
    .borderRadius(10)
    .alignItems(VerticalAlign.Top)
    .backgroundColor('#F6F8FA')
  }
}
