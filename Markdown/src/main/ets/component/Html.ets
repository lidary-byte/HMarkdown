/**
 * @Author : lcc
 * @CreateData : 2024/7/22
 * @Description:
 */
import { HmdConv } from '@rv/hmd-conv'
import { Token } from '../core'
import { MarkdownComponent } from '../MarkdownComponent'
import { parseMarkdown } from '../utils'

@Component
export struct Html {
  @Prop html: string
  @State tokenList: Token[] = []

  aboutToAppear(): void {
    const md = new HmdConv().html2md(this.html)
    this.tokenList = parseMarkdown(md)
  }

  build() {
    MarkdownComponent({ tokenList: this.tokenList })
  }
}