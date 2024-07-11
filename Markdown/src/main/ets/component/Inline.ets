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
  @Consume  config: IMarkConfig

  build() {
    Row() {
      Text() {
        SpanText(this.token, this)
      }
      .fontColor(this.config.theme?.defaultFont?.fontColor)
      .fontSize(this.config.theme?.defaultFont?.fontSize)
      .fontWeight(this.config.theme?.defaultFont?.fontWeight)
      .lineSpacing(this.config.textLineSpace)
    }
  }
}
