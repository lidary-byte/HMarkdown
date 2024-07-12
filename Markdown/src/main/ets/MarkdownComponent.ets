import { BlockQuote } from './component/BlockQuote'
import { Code } from './component/Code'
import { Heading } from './component/Heading'
import { Hr } from './component/Hr'
import { MList } from './component/MList'
import { Paragraph } from './component/Paragraph'
import { Table } from './component/Table'
import { KEY_FONT_STYLE, KEY_LINE_SPACE, KEY_THEME } from './config/Constant'
import { MarkdownFontStyle, MarkdownTheme } from './config/MarkdownTheme'
import { Token, Tokens } from './core'
import { markConfig } from './Index'

@Component
export struct MarkdownComponent {
  tokenList: Token[] = []
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
        } else if (token.type === 'table') {
          Table({
            token: token as Tokens.Table
          })
        } else {
          markConfig.customBlockBuilder.builder(token.type, token, this)
        }
        // else if (item.type === 'html') {
        //     //   RichText((item as Tokens.HTML).text)
        //     //     .margin({
        //     //       top: style.base.space,
        //     //       bottom: style.base.space
        //     //     })
        //   } else if (token.type === 'text') {
        //     // Inline({
        //     //   token: token
        //     // })
        //   }
      }
      )
    }
    .alignItems(HorizontalAlign.Start)
  }
}
