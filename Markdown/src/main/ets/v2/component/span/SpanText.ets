/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { Token } from '../../../core'
import { markConfig } from '../../../Index'
import { clearMarkdown } from '../../../utils'
import { SpanImage } from './SpanImage'



interface InlineStyle {
  isLink?: boolean
  fontWeight?: FontWeight
}

@Builder
export function SpanText(tokens: Token[] = [], that: ESObject, style?: InlineStyle,
  onSpanClick?: () => void) {
  ForEach(tokens, (tokenItem: Token) => {
    if (tokenItem.type === 'image') {
      SpanImage({ href: tokenItem.href })
    } else if (tokenItem.type === 'br') {
      Span('\n')
    } else if (tokenItem.type === 'strong') {
      if (tokenItem.tokens?.length != 0) {
        SpanText(tokenItem.tokens, that, { fontWeight: FontWeight.Bold, isLink: style?.isLink }, onSpanClick)
      } else {
        Span(clearMarkdown(tokenItem.text))
          .fontWeight(FontWeight.Bold)
          .fontColor(style?.isLink ? that.theme?.link?.fontColor : that.fontStyle?.fontColor)
          .onClick(onSpanClick)
      }
    } else if (tokenItem.type === 'del') {
      Span(clearMarkdown(tokenItem.text))
        .fontColor(style?.isLink ? that.theme?.link?.fontColor : that.fontStyle?.fontColor)
        .decoration({
          type: TextDecorationType.LineThrough,
          color: Color.Black,
          style: TextDecorationStyle.SOLID
        })
        .onClick(onSpanClick)
    } else if (tokenItem.type === 'text') {
      Span(clearMarkdown(tokenItem.text))
        .fontColor(style?.isLink ? that.theme?.link?.fontColor : that.fontStyle?.fontColor)
        .onClick(onSpanClick)
        .fontWeight(style?.fontWeight)
    } else if (tokenItem.type === 'em') {
      Span(clearMarkdown(tokenItem.text))
        .fontColor(style?.isLink ? that.theme?.link?.fontColor : that.fontStyle?.fontColor)
        .fontStyle(FontStyle.Italic)
        .onClick(onSpanClick)
    } else if (tokenItem.type === 'codespan') {
      ContainerSpan() {
        Span(` ${clearMarkdown(tokenItem.text)} `)
          .fontColor(style?.isLink ? that.theme?.link?.fontColor : that.fontStyle?.fontColor)
          .onClick(onSpanClick)
      }.textBackgroundStyle({
        color: that.theme?.codeSpan?.backgroundColor,
        radius: that.theme?.codeSpan?.borderRadius
      })
    } else if (tokenItem.type === 'link') {
      SpanText(tokenItem.tokens, that, {
        isLink: true,
        fontWeight: style?.fontWeight
      },
        () => {
          markConfig.registerLinkClick(tokenItem.href)
        }
      )
    } else {
      markConfig.customInlineBuilder?.builder(tokenItem.type, tokenItem, that)
    }
  })
}
