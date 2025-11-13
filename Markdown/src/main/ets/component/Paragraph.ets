/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { MarkdownTheme } from '../config/MarkdownTheme'
import { Tokens } from '../core'
import { Inline } from './Inline'

@ComponentV2
export struct Paragraph {
  @Param @Require token: Tokens.Paragraph
  @Param @Require theme: MarkdownTheme

  build() {
    Inline({ token: this.token?.tokens, theme: this.theme, fontStyle: this.theme.paragraph })
  }
}