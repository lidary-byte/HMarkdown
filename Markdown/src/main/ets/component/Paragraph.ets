/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { Tokens } from '../core'
import { Inline } from './Inline'
import { SpanText } from './span/SpanText'

@Component
export struct Paragraph {
  token?: Tokens.Paragraph

  build() {
    // SpanText({ token: this.token?.tokens })
    Inline({ token: this.token?.tokens })
  }
}