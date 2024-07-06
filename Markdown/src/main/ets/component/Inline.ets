/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { Token } from '../core'
import { markTheme } from '../Index'
import { SpanText } from './span/SpanText'


@Component
export struct Inline {
  token?: Token[]

  build() {
    Row() {
      Text() {
        SpanText(this.token,markTheme().defaultFont?.fontColor)
      }.fontColor(markTheme().defaultFont?.fontColor)
      .fontSize(markTheme().defaultFont?.fontSize)
      .fontWeight(markTheme().defaultFont?.fontWeight)
    }
  }
}
