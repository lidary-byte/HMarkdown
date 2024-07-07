/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { Tokens } from '../core'
import { markTheme } from '../Index'
import { SpanText } from './span/SpanText'

const defaultHorPadding: number = 20

const itemLineHeight: number = 44

function textAlign(align?: 'center' | 'left' | 'right' | null) {
  if (align === 'left') {
    return TextAlign.Start
  }
  if (align === 'right') {
    return TextAlign.End
  }
  return TextAlign.Center
}


@Component
export struct Table {
  token?: Tokens.Table
  // 每一列最大宽度
  @State itemMaxWidth: Map<number, number> = new Map()

  build() {

    Column() {
      TableHeader({ tokens: this.token?.header, itemMaxWidth: this.itemMaxWidth })
      TableDivider(false, true)
      TableBody({ tokens: this.token?.rows, itemMaxWidth: this.itemMaxWidth })
    }.alignItems(HorizontalAlign.Start)
    .borderWidth(1.5)
    .borderColor(markTheme().blockQuote?.backgroundColor)
  }
}


@Component
export struct TableHeader {
  tokens: Tokens.TableCell[] = []
  @Link itemMaxWidth: Map<number, number>

  build() {

    Scroll() {
      Row() {
        ForEach(this.tokens, (item: Tokens.TableCell, index: number) => {
          Text(item.text)
            .fontWeight(FontWeight.Bold)
            .textAlign(textAlign(item.align))
            .padding({ top: 10, bottom: 10 })
            .maxLines(1)
            .width(this.itemMaxWidth[index])
            .fontColor(markTheme().defaultFont?.fontColor)
            .fontSize(markTheme().defaultFont?.fontSize)
            .onSizeChange((_: SizeOptions, newValue: SizeOptions) => {
              const width: number = this.itemMaxWidth[index]
              if (typeof newValue.width === 'number') {
                if (!width) {
                  this.itemMaxWidth[index] = newValue.width + defaultHorPadding
                } else {
                  if (newValue.width > width) {
                    this.itemMaxWidth[index] = newValue.width + defaultHorPadding
                  }
                }
                console.error('-------body:' + index + "----" + item.text + '------' + width + '-------' +
                newValue.width)
              }
            })

          TableDivider(true, index != this.tokens.length - 1)
        })
      }
    }.scrollable(ScrollDirection.Horizontal)
    .height(itemLineHeight)
    .scrollBar(BarState.Off)

  }
}


@Component
struct TableBody {
  tokens: Tokens.TableCell[][] = []
  @Link itemMaxWidth: Map<number, number>

  build() {
    Column() {
      ForEach(this.tokens, (row: Tokens.TableCell[], index: number) => {
        Scroll() {
          Row() {
            ForEach(row, (item: Tokens.TableCell, index: number) => {
              Text() {
                SpanText(item.tokens)
              }
              .textAlign(textAlign(item.align))
              .fontColor(markTheme().defaultFont?.fontColor)
              .padding({ top: 10, bottom: 10 })
              .maxLines(1)
              .fontSize(markTheme().defaultFont?.fontSize)
              .width(this.itemMaxWidth[index])
              .onSizeChange((_: SizeOptions, newValue: SizeOptions) => {
                const width: number = this.itemMaxWidth[index]
                if (typeof newValue.width === 'number') {
                  if (!width) {
                    this.itemMaxWidth[index] = newValue.width + defaultHorPadding
                  } else {
                    if (newValue.width > width) {
                      this.itemMaxWidth[index] = newValue.width + defaultHorPadding
                    }
                  }
                  console.error('-------body:' + index + "----" + item.text + '------' + width + '-------' +
                  newValue.width)
                }
              })

              TableDivider(true, index != row.length - 1)
            })
          }
        }.scrollBar(BarState.Off)
        .scrollable(ScrollDirection.Horizontal)
        .height(itemLineHeight)

        TableDivider(false, index != this.tokens.length - 1)
      })
    }
  }
}

@Builder
function TableDivider(vertical: boolean, isShow: boolean) {
  if (isShow) {
    Divider().color(markTheme().blockQuote?.backgroundColor)
      .strokeWidth(1.5)
      .vertical(vertical)
  }
}