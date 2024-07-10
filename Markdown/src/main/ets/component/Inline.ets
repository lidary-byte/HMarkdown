/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { Token } from '../core'
import { markConfig } from '../Index'
import { SpanText } from './span/SpanText'


@Component
export struct Inline {
  token?: Token[]

  build() {
    Row() {
      Text() {
        SpanText(this.token,markConfig.theme.defaultFont?.fontColor)
      }.fontColor(markConfig.theme.defaultFont?.fontColor)
      .fontSize(markConfig.theme.defaultFont?.fontSize)
      .fontWeight(markConfig.theme.defaultFont?.fontWeight)
    }
  }
}
