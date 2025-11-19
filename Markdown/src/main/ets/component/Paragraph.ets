/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { Tokens } from '../core'
import { MarkdownOptions } from '../Index'
import { Inline } from './Inline'

@ComponentV2
export struct Paragraph {
  @Param @Require token: Tokens.Paragraph
  @Param @Require options: MarkdownOptions

  build() {
    Inline({ token: this.token?.tokens, options:this.options })
  }
}