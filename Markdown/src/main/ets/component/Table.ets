/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { KEY_DEFAULT_FONT, KEY_THEME } from '../config/Constant'
import { MarkdownFontStyle, MarkdownTheme } from '../config/MarkdownTheme'
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
  @StorageLink(KEY_THEME) theme?: MarkdownTheme = undefined

  build() {
    Column() {
      TableHeader({ tokens: this.token?.header, itemMaxWidth: this.itemMaxWidth })
      TableDivider(false, true, this.theme?.blockQuote?.backgroundColor)
      TableBody({ tokens: this.token?.rows, itemMaxWidth: this.itemMaxWidth })
    }.alignItems(HorizontalAlign.Start)
    .borderWidth(1.5)
    .borderColor(this.theme?.blockQuote?.backgroundColor)
  }
}


@Component
export struct TableHeader {
  tokens: Tokens.TableCell[] = []
  @Link itemMaxWidth: Map<number, number>
  @StorageLink(KEY_DEFAULT_FONT) fontStyle?: MarkdownFontStyle = undefined
  @StorageLink(KEY_THEME) theme?: MarkdownTheme = undefined
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
            .fontColor(this.fontStyle?.fontColor)
            .fontSize(this.fontStyle?.fontSize)
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

          TableDivider(true, index != this.tokens.length - 1, this.theme?.blockQuote?.backgroundColor)
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
  @StorageLink(KEY_THEME) theme?: MarkdownTheme = undefined
  @StorageLink(KEY_DEFAULT_FONT) fontStyle?: MarkdownFontStyle = undefined
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
              .fontColor(this.fontStyle?.fontColor)
              .padding({ top: 10, bottom: 10 })
              .maxLines(1)
              .fontSize(this.fontStyle?.fontSize)
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

              TableDivider(true, index != row.length - 1, this.theme?.blockQuote?.backgroundColor)
            })
          }
        }.scrollBar(BarState.Off)
        .scrollable(ScrollDirection.Horizontal)
        .height(itemLineHeight)

        TableDivider(false, index != this.tokens.length - 1, this.theme?.blockQuote?.backgroundColor)
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