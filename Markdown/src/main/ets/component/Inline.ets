/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { IMarkConfig } from '../config/MarkConfig'
import { Token } from '../core'
import { SpanText } from './span/SpanText'


@Component
export struct Inline {
  token?: Token[]
  @Link markConfig: IMarkConfig

  build() {
    Row() {
      Text() {
        SpanText(this.token, this.markConfig.theme?.defaultFont?.fontColor)
      }.fontColor(this.markConfig.theme?.defaultFont?.fontColor)
      .fontSize(this.markConfig.theme?.defaultFont?.fontSize)
      .fontWeight(this.markConfig.theme?.defaultFont?.fontWeight)
    }
  }
}
