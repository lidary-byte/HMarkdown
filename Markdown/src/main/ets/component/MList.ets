/**
 * @Author : lcc
 * @CreateData : 2024/7/6
 * @Description:
 */
import { KEY_LINE_SPACE } from '../config/Constant'
import { Token, Tokens } from '../core'
import { Inline } from './Inline'

@Component
export struct MList {
  @Prop tokens: Tokens.List

  @Consume(KEY_LINE_SPACE) lineSpace: number
  build() {

    Column({ space: this.lineSpace }) {
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