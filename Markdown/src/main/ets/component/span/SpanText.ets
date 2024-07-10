/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { Token } from '../../core'
import { SpanImage } from './SpanImage'
import promptAction from '@ohos.promptAction'
import { markConfig } from '../../Index'


@Builder
export function SpanText(tokens?: Token[], fontColor?: ResourceColor, onClick?: () => void) {
  ForEach(tokens, (tokenItem: Token) => {
    if (tokenItem.type === 'image') {
      SpanImage({ href: tokenItem.href })
    } else if (tokenItem.type === 'br') {
      Span('\n')
    } else if (tokenItem.type === 'strong') {
      Span(tokenItem.text)
        .fontWeight(FontWeight.Bold)
        .fontColor(fontColor)
        .onClick(() => {
          onClick?.()
        })
    } else if (tokenItem.type === 'text') {
      Span(tokenItem.text)
        .fontColor(fontColor)
        .onClick(() => {
          onClick?.()
        })
    } else if (tokenItem.type === 'em') {
      Span(tokenItem.text)
        .fontColor(fontColor)
        .fontStyle(FontStyle.Italic)
        .onClick(() => {
          onClick?.()
        })
    } else if (tokenItem.type === 'codespan') {
      ContainerSpan() {
        Span(` ${tokenItem.text} `)
      }.textBackgroundStyle({
        color: markConfig.theme.codeSpan?.backgroundColor,
        radius: markConfig.theme.codeSpan?.borderRadius
      })
    } else if (tokenItem.type === 'link') {
      SpanText(tokenItem.tokens, markConfig.theme.link?.fontColor, () => {
        promptAction.showToast({
          message: 'link 点击事件 ---- ' + tokenItem.href
        })
      })
    }
  })
}
