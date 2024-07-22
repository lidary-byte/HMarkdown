/**
 * @Author : lcc
 * @CreateData : 2024/7/22
 * @Description:
 */
import { HmdConv } from '@rv/hmd-conv'
import { marked, Token } from '../core'
import { MarkdownComponent } from '../MarkdownComponent'

@Component
export struct Html {
  html: string = ''
  @State tokenList: Token[] = []

  aboutToAppear(): void {
    const md = new HmdConv().html2md(this.html)
    this.tokenList = marked.lexer(md)
  }

  build() {
    MarkdownComponent({ tokenList: this.tokenList })
  }
}