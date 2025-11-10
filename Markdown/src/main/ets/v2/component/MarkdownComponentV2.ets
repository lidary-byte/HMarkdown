import { markConfig } from "../../../../../Index"
import { KEY_FONT_STYLE, KEY_LINE_SPACE, KEY_THEME } from "../../config/Constant"
import { MarkdownFontStyle, MarkdownTheme } from "../../config/MarkdownTheme"
import { Token, Tokens } from "../../core"
import { BlockQuote } from "./BlockQuote"
import { Code } from "./Code"
import { Heading } from "./Heading"
import { Hr } from "./Hr"
import { Html } from "./Html"
import { Inline } from "./Inline"
import { MList } from "./MList"
import { Paragraph } from "./Paragraph"
import { Table } from "./Table"

@ComponentV2
export struct MarkdownComponentV2 {
  @Param tokenList: Token[] = []
  @Consumer(KEY_THEME) theme?: MarkdownTheme
  @Consumer(KEY_LINE_SPACE) lineSpace?: number
  @Consumer(KEY_FONT_STYLE) fontStyle?: MarkdownFontStyle

  build() {
    List({ space: this.lineSpace }) {
      Repeat(this.tokenList)
        .each((repeatItem) => {
          if (repeatItem.item.type === 'hr') {
            Hr()
          } else if (repeatItem.item.type === 'heading') {
            Heading({ token: repeatItem.item as Tokens.Heading })
          } else if (repeatItem.item.type === 'space') {
            Stack()
          } else if (repeatItem.item.type === 'code') {
            Code({ token: repeatItem.item as Tokens.Code })
          } else if (repeatItem.item.type === 'blockquote') {
            BlockQuote({
              token: repeatItem.item as Tokens.Blockquote
            })
          } else if (repeatItem.item.type === 'paragraph') {
            Paragraph({
              token: repeatItem.item as Tokens.Paragraph
            })
          } else if (repeatItem.item.type === 'list') {
            MList({
              tokens: repeatItem.item as Tokens.List
            })
          } else if (repeatItem.item.type === 'text') {
            Inline({
              token: (this.tokenList[0] as Tokens.Text).tokens
            })
          } else if (repeatItem.item.type === 'table') {
            Table({
              token: repeatItem.item as Tokens.Table
            })
          } else if (repeatItem.item.type === 'html') {
            Html({ html: repeatItem.item.text })
          } else {
            markConfig.customBlockBuilder?.builder(repeatItem.item.type, repeatItem.item, this)
          }
        })

    }.width('100%')
  }
}
