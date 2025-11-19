/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */

import { MarkdownTheme } from '../config/MarkdownTheme'
import { Tokens } from '../core'
import { parseInlineToken } from '../core/parseInlineToken'
import { MarkdownOptions } from '../Index'
import { getTheme, textAlign } from '../utils'

export const defaultHorPadding: number = 20

export const itemLineHeight: number = 44


@ComponentV2
export struct Table {
  @Param @Require token: Tokens.Table
  @Param @Require options: MarkdownOptions
  // 每一列最大宽度
  @Local itemMaxWidth: Map<number, number> = new Map()

  build() {

    Scroll() {
      Column() {
        TableHeader({ tokens: this.token?.header, itemMaxWidth: this.itemMaxWidth, theme: getTheme(this.options) })
        TableBody({ tokens: this.token?.rows, itemMaxWidth: this.itemMaxWidth, options: this.options })
      }.alignItems(HorizontalAlign.Start)
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .borderWidth(getTheme(this.options).tableStyle?.driveWidth)
    .borderColor(getTheme(this.options).tableStyle?.driveColor)

  }
}


@ComponentV2
export struct TableHeader {
  @Param @Require tokens: Tokens.TableCell[]
  @Param @Require theme: MarkdownTheme
  @Param @Require itemMaxWidth: Map<number, number>

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
          .fontColor(this.theme.fontStyle?.fontColor)
          .fontSize(this.theme.fontStyle?.fontSize)
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
          Divider().color(this.theme?.tableStyle?.driveColor)
            .strokeWidth(this.theme?.tableStyle?.driveWidth)
            .vertical(true)
        }
      })
    }.border({
      width: {
        bottom: this.theme?.tableStyle?.driveWidth
      },
      color: this.theme?.tableStyle?.driveColor
    })

    .height(itemLineHeight)
  }
}


@ComponentV2
struct TableBody {
  @Param @Require tokens: Tokens.TableCell[][]
  @Param @Require options: MarkdownOptions
  @Param @Require itemMaxWidth: Map<number, number>

  build() {
    Column() {
      ForEach(this.tokens, (row: Tokens.TableCell[], _: number) => {
        Row() {
          ForEach(row, (item: Tokens.TableCell, index: number) => {

            TableInline({
              tableCell: item,
              itemMaxWidth: this.itemMaxWidth,
              index: index,
              options: this.options
            })

            if (index != row.length - 1) {
              Divider().color(getTheme(this.options).tableStyle?.driveColor)
                .strokeWidth(getTheme(this.options).tableStyle?.driveWidth)
                .vertical(true)
            }

          })
        }

        .height(itemLineHeight)
        .border({
          width: {
            bottom: getTheme(this.options).tableStyle?.driveWidth
          },
          color: getTheme(this.options).tableStyle?.driveColor
        })
      })
    }
  }
}


@ComponentV2
export struct TableInline {
  @Param @Require index: number
  @Param @Require tableCell: Tokens.TableCell
  @Param @Require itemMaxWidth: Map<number, number>
  @Param @Require options: MarkdownOptions
  inlineTextController = new TextController()

  aboutToAppear(): void {
    this.watchToken()
  }

  @Monitor('options')
  watchToken() {
    parseInlineToken({
      token: this.tableCell.tokens ?? [],
      options: this.options,
      uiContext: this.getUIContext()
    }).then((data) => {
      this.inlineTextController.setStyledString(data)
    })
  }

  build() {
    Text(undefined, { controller: this.inlineTextController })
      .textAlign(textAlign(this.tableCell.align))
      .fontColor(getTheme(this.options).fontStyle?.fontColor)
      .padding({
        top: 10,
        bottom: 10,
        left: 8,
        right: 8
      })
      .maxLines(1)
      .fontSize(getTheme(this.options).fontStyle?.fontSize)
      .width(this.itemMaxWidth[this.index])
      .onSizeChange((_: SizeOptions, newValue: SizeOptions) => {
        const width: number = this.itemMaxWidth[this.index]
        if (typeof newValue.width === 'number') {
          if (!width) {
            this.itemMaxWidth[this.index] = newValue.width + defaultHorPadding
          } else {
            if (newValue.width > width) {
              this.itemMaxWidth[this.index] = newValue.width + defaultHorPadding
            }
          }
        }
      })
  }
}
