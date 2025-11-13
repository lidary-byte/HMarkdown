/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */

import { MarkdownFontStyle, MarkdownTheme } from '../config/MarkdownTheme'
import { Tokens } from '../core'
import { TableInline, textAlign } from './TableInline'

export const defaultHorPadding: number = 20

export const itemLineHeight: number = 44


@ComponentV2
export struct Table {
  @Param @Require token: Tokens.Table
  @Param @Require theme: MarkdownTheme
  // 每一列最大宽度
  @Local itemMaxWidth: Map<number, number> = new Map()

  build() {

    Scroll() {
      Column() {
        TableHeader({ tokens: this.token?.header, itemMaxWidth: this.itemMaxWidth })
        TableBody({ tokens: this.token?.rows, itemMaxWidth: this.itemMaxWidth })
      }.alignItems(HorizontalAlign.Start)
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .borderWidth(1.5)
    .borderColor(this.theme?.blockQuote?.backgroundColor)

  }
}


@ComponentV2
export struct TableHeader {
  @Param @Require tokens: Tokens.TableCell[]
  @Param @Require itemMaxWidth: Map<number, number>
  @Consumer(KEY_FONT_STYLE) fontStyle?: MarkdownFontStyle
  @Consumer(KEY_THEME) theme?: MarkdownTheme

  build() {

    Row() {
      ForEach(this.tokens, (item: Tokens.TableCell, index: number) => {
        Text(item.text)
          .fontWeight(FontWeight.Bold)
          .textAlign(textAlign(item.align))
          .padding({
            top: 10,
            bottom: 10,
            left: 8,
            right: 8
          })
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


        if (index != this.tokens.length - 1) {
          Divider().color(this.theme?.blockQuote?.backgroundColor)
            .strokeWidth(1.5)
            .vertical(true)
        }
      })
    }.border({
      width: {
        bottom: 1.5
      },
      color: this.theme?.blockQuote?.backgroundColor
    })
    .height(itemLineHeight)
  }
}


@ComponentV2
struct TableBody {
  @Param @Require tokens: Tokens.TableCell[][]
  @Param @Require itemMaxWidth: Map<number, number>
  @Consumer(KEY_THEME) theme?: MarkdownTheme
  @Consumer(KEY_FONT_STYLE) fontStyle?: MarkdownFontStyle

  build() {
    Column() {
      ForEach(this.tokens, (row: Tokens.TableCell[], index: number) => {
        Row() {
          ForEach(row, (item: Tokens.TableCell, index: number) => {
            TableInline({ tableCell: item, itemMaxWidth: this.itemMaxWidth, index: index })
            // Text(undefined, { controller: this.inlineTextController }) {
            //   SpanText(item.tokens, this)
            // }
            // .textAlign(textAlign(item.align))
            // .fontColor(this.fontStyle?.fontColor)
            // .padding({
            //   top: 10,
            //   bottom: 10,
            //   left: 8,
            //   right: 8
            // })
            // .maxLines(1)
            // .fontSize(this.fontStyle?.fontSize)
            // .width(this.itemMaxWidth[index])
            // .onSizeChange((_: SizeOptions, newValue: SizeOptions) => {
            //   const width: number = this.itemMaxWidth[index]
            //   if (typeof newValue.width === 'number') {
            //     if (!width) {
            //       this.itemMaxWidth[index] = newValue.width + defaultHorPadding
            //     } else {
            //       if (newValue.width > width) {
            //         this.itemMaxWidth[index] = newValue.width + defaultHorPadding
            //       }
            //     }
            //   }
            // })

            if (index != row.length - 1) {
              Divider().color(this.theme?.blockQuote?.backgroundColor)
                .strokeWidth(1.5)
                .vertical(true)
            }

          })
        }

        .height(itemLineHeight)
        .border({
          width: {
            bottom: 1.5
          },
          color: this.theme?.blockQuote?.backgroundColor
        })
      })
    }
  }
}
