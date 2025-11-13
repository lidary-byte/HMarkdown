/**
 * @Author : lidary
 * @CreateData : 2025/11/13
 * @Description:
 */
import { KEY_FONT_STYLE, KEY_LINE_SPACE, KEY_TEXT_LINE_SPACE, KEY_THEME } from '../config/Constant'
import { MarkdownFontStyle, MarkdownTheme } from '../config/MarkdownTheme'
import { Tokens } from '../core'
import { parseToken } from './span/SpanText'
import { defaultHorPadding } from './Table'

export function textAlign(align?: 'center' | 'left' | 'right' | null) {
  if (align === 'left') {
    return TextAlign.Start
  }
  if (align === 'right') {
    return TextAlign.End
  }
  return TextAlign.Center
}

@ComponentV2
export struct TableInline {
  @Param @Require index: number
  @Param @Require tableCell: Tokens.TableCell
  @Param @Require itemMaxWidth: Map<number, number>
  @Consumer(KEY_LINE_SPACE) lineSpace?: number
  @Consumer(KEY_FONT_STYLE) fontStyle?: MarkdownFontStyle
  @Consumer(KEY_THEME) theme?: MarkdownTheme
  @Consumer(KEY_TEXT_LINE_SPACE) textLineSpace?: number
  @Consumer() _mdInlineModifier?: AttributeModifier<TextAttribute>
  inlineTextController = new TextController()
  inlineTextStyle = new MutableStyledString('')

  aboutToAppear(): void {
    parseToken(this.tableCell.tokens, this)
    this.inlineTextController.setStyledString(this.inlineTextStyle)
  }

  @Monitor('tableCell')
  watchToken() {
    this.inlineTextStyle = new MutableStyledString('')
    parseToken(this.tableCell.tokens, this)
    this.inlineTextController.setStyledString(this.inlineTextStyle)
  }

  build() {
    Text(undefined, { controller: this.inlineTextController })
      .textAlign(textAlign(this.tableCell.align))
      .fontColor(this.fontStyle?.fontColor)
      .padding({
        top: 10,
        bottom: 10,
        left: 8,
        right: 8
      })
      .maxLines(1)
      .fontSize(this.fontStyle?.fontSize)
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
