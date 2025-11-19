import { Token, Tokens } from '../core'
import { MarkdownOptions } from '../Index'
import { BlockQuote } from './BlockQuote'
import { Code } from './Code'
import { Heading } from './Heading'
import { Hr } from './Hr'
import { Inline } from './Inline'
import { Latex } from './Latex'
import { MList } from './MList'
import { Paragraph } from './Paragraph'
import { Table } from './Table'

@ComponentV2
export struct MarkdownComponent {
  @Param @Require tokenList: Token[] = []
  @Param @Require options: MarkdownOptions

  build() {
    List({ space: this.options.lineSpace }) {
      Repeat(this.tokenList)
        .each((repeatItem) => {
          if (repeatItem.item.type === 'hr') {
            Hr({ options: this.options })
          } else if (repeatItem.item.type === 'heading') {
            Heading({ token: repeatItem.item as Tokens.Heading, options: this.options })
          } else if (repeatItem.item.type === 'space') {
            Stack()
          } else if (repeatItem.item.type === 'code') {
            Code({ token: repeatItem.item as Tokens.Code, options: this.options })
          } else if (repeatItem.item.type === 'blockquote') {
            BlockQuote({
              token: repeatItem.item as Tokens.Blockquote, options: this.options
            })
          } else if (repeatItem.item.type === 'paragraph') {
            Paragraph({
              token: repeatItem.item as Tokens.Paragraph, options: this.options
            })
          } else if (repeatItem.item.type === 'list') {
            MList({
              tokens: repeatItem.item as Tokens.List, options: this.options
            })
          } else if (repeatItem.item.type === 'text') {
            Inline({
              token: (this.tokenList[0] as Tokens.Text).tokens,
              options: this.options
            })
          } else if (repeatItem.item.type === 'table') {
            Table({
              token: repeatItem.item as Tokens.Table, options: this.options
            })
          } else if (repeatItem.item.type === 'html') {
            // Html({ html: repeatItem.item.text, options: this.options })
          } else if (repeatItem.item.type === 'blockLatex') {
            Latex({ token: repeatItem.item, options: this.options })
          } else {
            this.options.customBlockBuilder?.builder(repeatItem.item, this.options)
          }
        })
    }.width('100%')
  }
}
