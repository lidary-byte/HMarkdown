/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { IMarkConfig } from '../config/MarkConfig'
import { Tokens } from '../core'
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
  @Consume config: IMarkConfig

  build() {
    Column() {
      TableHeader({ tokens: this.token?.header, itemMaxWidth: this.itemMaxWidth })
      TableDivider(false, true, this.config.theme?.blockQuote?.backgroundColor)
      TableBody({ tokens: this.token?.rows, itemMaxWidth: this.itemMaxWidth })
    }.alignItems(HorizontalAlign.Start)
    .borderWidth(1.5)
    .borderColor(this.config.theme?.blockQuote?.backgroundColor)
  }
}


@Component
export struct TableHeader {
  tokens: Tokens.TableCell[] = []
  @Link itemMaxWidth: Map<number, number>
  @Consume config: IMarkConfig

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
            .fontColor(this.config.theme?.defaultFont?.fontColor)
            .fontSize(this.config.theme?.defaultFont?.fontSize)
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
              }
            })

          TableDivider(true, index != this.tokens.length - 1, this.config.theme?.blockQuote?.backgroundColor)
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
  @Consume config: IMarkConfig

  build() {
    Column() {
      ForEach(this.tokens, (row: Tokens.TableCell[], index: number) => {
        Scroll() {
          Row() {
            ForEach(row, (item: Tokens.TableCell, index: number) => {
              Text() {
                SpanText(item.tokens, this)
              }
              .textAlign(textAlign(item.align))
              .fontColor(this.config.theme?.defaultFont?.fontColor)
              .padding({ top: 10, bottom: 10 })
              .maxLines(1)
              .fontSize(this.config.theme?.defaultFont?.fontSize)
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
                }
              })

              TableDivider(true, index != row.length - 1, this.config.theme?.blockQuote?.backgroundColor)
            })
          }
        }.scrollBar(BarState.Off)
        .scrollable(ScrollDirection.Horizontal)
        .height(itemLineHeight)

        TableDivider(false, index != this.tokens.length - 1, this.config.theme?.blockQuote?.backgroundColor)
      })
    }
  }
}

@Builder
function TableDivider(vertical: boolean, isShow: boolean, color?: ResourceColor) {
  if (isShow) {
    Divider().color(color)
      .strokeWidth(1.5)
      .vertical(vertical)
  }
}