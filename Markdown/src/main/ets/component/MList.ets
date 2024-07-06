/**
 * @Author : lcc
 * @CreateData : 2024/7/6
 * @Description:
 */
import { Token, Tokens } from '../core'
import { markConfig } from '../Index'
import { Inline } from './Inline'
import { SpanText } from './span/SpanText'

@Component
export struct MList {
  tokens?: Tokens.List

  build() {

    Column({ space: markConfig().lineSpace }) {
      ForEach(this.tokens?.items, (item: Tokens.ListItem) => {
        ForEach(item.tokens, (itemChild: Token) => {
          if (itemChild.type === 'list') {
            MList({ tokens: itemChild as Tokens.List })
              .margin({ left: 32 })
          } else {
            Row({ space: 8 }) {
              Circle({ width: 6, height: 6 })
              Inline({ token: item.tokens[0]['tokens'] })
            }
          }
        })
      })
    }.alignItems(HorizontalAlign.Start)
  }
}