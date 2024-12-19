/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { Tokens } from '../../core'
import { Inline } from './Inline'

@ComponentV2
export struct Paragraph {
  @Param token?: Tokens.Paragraph = undefined

  build() {
    Inline({ token: this.token?.tokens })
  }
}