/**
 * @Author : lcc
 * @CreateData : 2024/7/6
 * @Description:
 */
import { IMarkConfig } from '../config/MarkConfig'
import { Token, Tokens } from '../core'
import { Inline } from './Inline'

@Component
export struct MList {
  tokens?: Tokens.List
  @Link markConfig: IMarkConfig

  build() {

    Column({ space: this.markConfig.lineSpace }) {
      ForEach(this.tokens?.items, (item: Tokens.ListItem) => {
        ForEach(item.tokens, (itemChild: Token) => {
          if (itemChild.type === 'list') {
            MList({ tokens: itemChild as Tokens.List, markConfig: this.markConfig })
              .margin({ left: 32 })
          } else {
            Row({ space: 8 }) {
              Circle({ width: 6, height: 6 })
              Inline({ token: item.tokens[0]['tokens'] ,markConfig:this.markConfig})
            }
          }
        })
      })
    }.alignItems(HorizontalAlign.Start)
  }
}