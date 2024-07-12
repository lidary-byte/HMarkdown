/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { Token } from '../../core'
import { markConfig } from '../../Index'
import { SpanImage } from './SpanImage'

@Builder
export function SpanText(tokens: Token[] = [], that: ESObject, isLink?: boolean,
  onSpanClick?: () => void) {
  ForEach(tokens, (tokenItem: Token) => {
    if (tokenItem.type === 'image') {
      SpanImage({ href: tokenItem.href })
    } else if (tokenItem.type === 'br') {
      Span('\n')
    } else if (tokenItem.type === 'strong') {
      Span(tokenItem.text)
        .fontWeight(FontWeight.Bold)
        .fontColor(isLink ? that.config.theme?.link?.fontColor : that.config.theme?.defaultFont?.fontColor)
        .onClick(onSpanClick)
    } else if (tokenItem.type === 'text') {
      Span(tokenItem.text)
        .fontColor(isLink ? that.config.theme?.link?.fontColor : that.config.theme?.defaultFont?.fontColor)
        .onClick(onSpanClick)
    } else if (tokenItem.type === 'em') {
      Span(tokenItem.text)
        .fontColor(isLink ? that.config.theme?.link?.fontColor : that.config.theme?.defaultFont?.fontColor)
        .fontStyle(FontStyle.Italic)
        .onClick(onSpanClick)
    } else if (tokenItem.type === 'codespan') {
      ContainerSpan() {
        Span(` ${tokenItem.text} `)
          .fontColor(isLink ? that.config.theme?.link?.fontColor : that.config.theme?.defaultFont?.fontColor)
          .onClick(onSpanClick)
      }.textBackgroundStyle({
        color: that.config.theme?.theme?.codeSpan?.backgroundColor,
        radius: that.config.theme?.theme?.codeSpan?.borderRadius
      })
    } else if (tokenItem.type === 'link') {
      SpanText(tokenItem.tokens, that, true,
        () => {
          markConfig.registerLinkClick(tokenItem.href)
        }
      )
    } else {
      markConfig.customInlineBuilder.builder(tokenItem.type, tokenItem)
    }
  })
}
