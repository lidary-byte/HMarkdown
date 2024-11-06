import { BlockQuote } from './component/BlockQuote'
import { Code } from './component/Code'
import { Heading } from './component/Heading'
import { Hr } from './component/Hr'
import { Html } from './component/Html'
import { Inline } from './component/Inline'
import { MList } from './component/MList'
import { Paragraph } from './component/Paragraph'
import { Table } from './component/Table'
import { KEY_FONT_STYLE, KEY_LINE_SPACE, KEY_THEME } from './config/Constant'
import { MarkdownFontStyle, MarkdownTheme } from './config/MarkdownTheme'
import { Token, Tokens } from './core'
import { markConfig } from './Index'

@Component
export struct MarkdownComponent {
  @Prop tokenList: Token[]
  @Consume(KEY_THEME) theme: MarkdownTheme
  @Consume(KEY_LINE_SPACE) lineSpace: number
  @Consume(KEY_FONT_STYLE) fontStyle: MarkdownFontStyle

  build() {
    Column({ space: this.lineSpace }) {
      ForEach(this.tokenList, (token: Token) => {
        if (token.type === 'hr') {
          Hr()
        } else if (token.type === 'heading') {
          Heading({ token: token as Tokens.Heading })
        } else if (token.type === 'space') {
          Stack()
        } else if (token.type === 'code') {
          Code({ token: token as Tokens.Code })
        } else if (token.type === 'blockquote') {
          BlockQuote({
            token: token as Tokens.Blockquote
          })
        } else if (token.type === 'paragraph') {
          Paragraph({
            token: token as Tokens.Paragraph
          })
        } else if (token.type === 'list') {
          MList({
            tokens: token as Tokens.List
          })
        } else if (token.type === 'text') {
          Inline({
            token: (this.tokenList[0] as Tokens.Text).tokens
          })
        } else if (token.type === 'table') {
          Table({
            token: token as Tokens.Table
          })
        } else if (token.type === 'html') {
          Html({ html: token.text })
        } else {
          markConfig.customBlockBuilder?.builder(token.type, token, this)
        }
      }
      )
    }
    .alignItems(HorizontalAlign.Start)
  }
}
