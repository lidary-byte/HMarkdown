/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { IMarkConfig } from '../config/MarkConfig'
import { Tokens } from '../core'
import { Inline } from './Inline'

@Component
export struct Paragraph {
  token?: Tokens.Paragraph
  @Link markConfig: IMarkConfig

  build() {
    Inline({ token: this.token?.tokens, markConfig: this.markConfig })
  }
}