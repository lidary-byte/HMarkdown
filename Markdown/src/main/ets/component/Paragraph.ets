/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { Tokens } from '../core'
import { Inline } from './Inline'

@Component
export struct Paragraph {
  @Prop token: Tokens.Paragraph

  build() {
    Inline({ token: this.token?.tokens })
  }
}