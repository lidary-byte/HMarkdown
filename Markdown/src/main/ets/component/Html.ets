/**
 * @Author : lcc
 * @CreateData : 2024/7/22
 * @Description:
 */
import { Token } from '../core'
import { MarkdownOptions } from '../Index'
import { Inline } from './Inline'

@ComponentV2
export struct Html {
  @Param @Require html: Token
  @Param @Require options: MarkdownOptions

  build() {
    Inline({ options: this.options, token: [this.html] })
  }
}