import { MarkdownTheme } from '../config/MarkdownTheme'
import { Token, Tokens } from '../core'
import { markdownConfig } from '../Index'
import { BlockQuote } from './BlockQuote'
import { Code } from './Code'
import { Heading } from './Heading'
import { Hr } from './Hr'
import { Html } from './Html'
import { Inline } from './Inline'
import { Latex } from './Latex'
import { MList } from './MList'
import { Paragraph } from './Paragraph'
import { Table } from './Table'

@ComponentV2
export struct MarkdownComponent {
  @Param @Require tokenList: Token[] = []
  @Param @Require theme: MarkdownTheme

  build() {
    List({ space: this.theme.lineSpacing }) {
      Repeat(this.tokenList)
        .each((repeatItem) => {
          if (repeatItem.item.type === 'hr') {
            Hr({ theme: this.theme })
          } else if (repeatItem.item.type === 'heading') {
            Heading({ token: repeatItem.item as Tokens.Heading, theme: this.theme })
          } else if (repeatItem.item.type === 'space') {
            Stack()
          } else if (repeatItem.item.type === 'code') {
            Code({ token: repeatItem.item as Tokens.Code, theme: this.theme })
          } else if (repeatItem.item.type === 'blockquote') {
            BlockQuote({
              token: repeatItem.item as Tokens.Blockquote, theme: this.theme
            })
          } else if (repeatItem.item.type === 'paragraph') {
            Paragraph({
              token: repeatItem.item as Tokens.Paragraph, theme: this.theme
            })
          } else if (repeatItem.item.type === 'list') {
            MList({
              tokens: repeatItem.item as Tokens.List, theme: this.theme
            })
          } else if (repeatItem.item.type === 'text') {
            Inline({
              token: (this.tokenList[0] as Tokens.Text).tokens, theme: this.theme, fontStyle:this.theme.defaultFontStyle
            })
          } else if (repeatItem.item.type === 'table') {
            Table({
              token: repeatItem.item as Tokens.Table, theme: this.theme
            })
          } else if (repeatItem.item.type === 'html') {
            Html({ html: repeatItem.item.text, theme: this.theme })
          } else if (repeatItem.item.type === 'blockLatex' && markdownConfig.enableLatex) {
            Latex({ token: repeatItem.item, theme: this.theme })
          } else {
            // markConfig.customBlockBuilder?.builder(repeatItem.item.type, repeatItem.item, this)
          }
        })

    }.width('100%')
  }
}
