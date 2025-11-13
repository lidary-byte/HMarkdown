/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { MarkdownFontStyle, MarkdownTheme } from '../../config/MarkdownTheme'
import { Token } from '../../core'
import { markdownConfig } from '../../Index'
import { clearMarkdown, latexToPixelMap } from '../../utils'


export interface InlineStyle {
  isLink?: boolean
  fontWeight?: FontWeight
}


interface InlineParams {
  token: Token[],
  fontStyle: MarkdownFontStyle,
  theme: MarkdownTheme,
  uiContext: UIContext,
  inlineTextStyle?: MutableStyledString,
  isLink?: boolean
  fontWeight?: FontWeight,
  onSpanClick?: () => void
}

export async function inlineToken(params: InlineParams): Promise<MutableStyledString | undefined> {
  if (params.inlineTextStyle == undefined) {
    params.inlineTextStyle = new MutableStyledString('')
  }
  for (let tokenItem of params.token) {
    if (tokenItem.type === 'image') {
      params.inlineTextStyle.appendStyledString(new MutableStyledString(new ImageAttachment({
        resourceValue: tokenItem.href,
        verticalAlign: ImageSpanAlignment.CENTER,
        size: { width: '100%' },
        objectFit: params.theme?.image?.objectFit,
      })))
      try {
        params.inlineTextStyle.setStyle({
          start: params.inlineTextStyle.length - 1,
          length: 1,
          styledKey: StyledStringKey.GESTURE,
          styledValue: new GestureStyle({
            onClick: () => {
              markdownConfig.imageClick?.(tokenItem['href'])
            }
          })
        })
      } catch (_) {
      }
    } else if (tokenItem.type === 'br') {
      params.inlineTextStyle.appendStyledString(new MutableStyledString('\n'))
    } else if (tokenItem.type === 'strong') {
      if (tokenItem.tokens?.length != 0) {
        await inlineToken({
          token: tokenItem.tokens ?? [],
          theme: params.theme,
          fontStyle: params.fontStyle,
          inlineTextStyle: params.inlineTextStyle,
          fontWeight: FontWeight.Bold,
          isLink: params.isLink,
          uiContext: params.uiContext,
          onSpanClick: params.onSpanClick
        })
      } else {
        let text = clearMarkdown(tokenItem.text)
        params.inlineTextStyle.appendStyledString(new MutableStyledString(text,
          [{
            start: 0,
            length: text.length,
            styledKey: StyledStringKey.FONT,
            styledValue: new TextStyle({
              fontColor: params?.isLink ? params.theme?.link?.fontColor : params.fontStyle?.fontColor,
              fontWeight: params?.fontWeight
            })
          }, {
            start: 0,
            length: text.length,
            styledKey: StyledStringKey.GESTURE,
            styledValue: new GestureStyle({ onClick: params.onSpanClick })
          }]))
      }
    } else if (tokenItem.type === 'del') {
      let text = clearMarkdown(tokenItem.text)
      params.inlineTextStyle.appendStyledString(new MutableStyledString(text,
        [{
          start: 0,
          length: text.length,
          styledKey: StyledStringKey.DECORATION,
          styledValue: new DecorationStyle({
            type: TextDecorationType.LineThrough,
            color: Color.Black,
            style: TextDecorationStyle.SOLID
          })
        }, {
          start: 0,
          length: text.length,
          styledKey: StyledStringKey.FONT,
          styledValue: new TextStyle({
            fontColor: params?.isLink ? params.theme?.link?.fontColor : params.fontStyle?.fontColor,
          })
        }, {
          start: 0,
          length: text.length,
          styledKey: StyledStringKey.GESTURE,
          styledValue: new GestureStyle({ onClick: params.onSpanClick })
        }]))
    } else if (tokenItem.type === 'text') {
      let text = clearMarkdown(tokenItem.text)
      params.inlineTextStyle.appendStyledString(new MutableStyledString(text,
        [{
          start: 0,
          length: text.length,
          styledKey: StyledStringKey.FONT,
          styledValue: new TextStyle({
            fontColor: params?.isLink ? params.theme?.link?.fontColor : params.fontStyle.fontColor,
            fontWeight: params?.fontWeight
          })
        }, {
          start: 0,
          length: text.length,
          styledKey: StyledStringKey.GESTURE,
          styledValue: new GestureStyle({ onClick: params.onSpanClick })
        }]))
    } else if (tokenItem.type === 'em') {
      let text = clearMarkdown(tokenItem.text)
      params.inlineTextStyle.appendStyledString(new MutableStyledString(text,
        [{
          start: 0,
          length: text.length,
          styledKey: StyledStringKey.FONT,
          styledValue: new TextStyle({
            fontColor: params?.isLink ? params.theme?.link?.fontColor : params.fontStyle?.fontColor,
            fontStyle: FontStyle.Italic
          })
        }, {
          start: 0,
          length: text.length,
          styledKey: StyledStringKey.GESTURE,
          styledValue: new GestureStyle({ onClick: params.onSpanClick })
        }]))
    } else if (tokenItem.type === 'codespan') {
      let codeSpan = ` ${clearMarkdown(tokenItem.text)} `
      params.inlineTextStyle.appendStyledString(new MutableStyledString(codeSpan,
        [{
          start: 0,
          length: codeSpan.length,
          styledKey: StyledStringKey.FONT,
          styledValue: new TextStyle({
            fontColor: params.theme?.code?.fontColor?.[tokenItem.type],
            fontSize: params.theme?.code?.codeSpanFontSize
          })
        }, {
          start: 0,
          length: codeSpan.length,
          styledKey: StyledStringKey.BACKGROUND_COLOR,
          styledValue: new BackgroundColorStyle({
            color: params.theme?.code?.codeSpanBackgroundColor,
            radius: params.theme?.code?.codeSpanBorderRadius
          })
        }]))
    } else if (tokenItem.type === 'link') {
      await inlineToken({
        token: tokenItem.tokens ?? [],
        theme: params.theme,
        fontStyle: params.fontStyle,
        inlineTextStyle: params.inlineTextStyle,
        fontWeight: params.fontWeight,
        uiContext: params.uiContext,
        isLink: true,
        onSpanClick: () => {
          markdownConfig.linkClick?.(tokenItem['href'])
        }
      })
    } else if (tokenItem.type === 'inlineLatex' && markdownConfig.enableLatex) {
      let imageInfo = await latexToPixelMap(tokenItem.text, params.uiContext.fp2px(params.theme.latex?.fontSize),
        params.theme.latex?.fontColor ?? 0xffffffff, params.theme.latex?.backgroundColor ?? 0xffffffff)
      params.inlineTextStyle.appendStyledString(new MutableStyledString(new ImageAttachment({
        value: imageInfo.pixelMap,
        verticalAlign: ImageSpanAlignment.CENTER,
        size: {
          width: params.uiContext.px2vp(imageInfo.width),
          height: params.uiContext.px2vp(imageInfo.height)
        },
        objectFit: ImageFit.Contain
      })))
    }
    // else if (tokenItem.type === 'html') {
    //   // Span(tokenItem.text)
    //   let text = await StyledString.fromHtml(tokenItem.text)
    //   this.inlineTextStyle.appendStyledString(text)
    // }
    else {
      // markConfig.customInlineBuilder?.builder(tokenItem.type, tokenItem, this)
    }
  }
  return params.inlineTextStyle
  // this.inlineTextController.setStyledString(this.inlineTextStyle)
}

export async function parseToken(token: Token[], that: ESObject, fontStyle?: MarkdownFontStyle,
  style?: InlineStyle,
  onSpanClick?: () => void) {
  for (let tokenItem of token) {
    if (tokenItem.type === 'image') {
      that.inlineTextStyle.appendStyledString(new MutableStyledString(new ImageAttachment({
        resourceValue: tokenItem.href,
        verticalAlign: ImageSpanAlignment.CENTER,
        size: { width: '100%' },
        objectFit: that.theme?.image?.objectFit,
        layoutStyle: { margin: { top: that.lineSpace, bottom: that.lineSpace } }
      })))
      try {
        that.inlineTextStyle.setStyle({
          start: that.inlineTextStyle.length - 1,
          length: 1,
          styledKey: StyledStringKey.GESTURE,
          styledValue: new GestureStyle({
            onClick: () => {
              markdownConfig.imageClick?.(tokenItem['href'])
            }
          })
        })
      } catch (_) {
      }
    } else if (tokenItem.type === 'br') {
      that.inlineTextStyle.appendStyledString(new MutableStyledString('\n'))
    } else if (tokenItem.type === 'strong') {
      if (tokenItem.tokens?.length != 0) {
        await parseToken(tokenItem.tokens ?? [], that, fontStyle,
          { fontWeight: FontWeight.Bold, isLink: style?.isLink },
          onSpanClick)
      } else {
        let text = clearMarkdown(tokenItem.text)
        that.inlineTextStyle.appendStyledString(new MutableStyledString(text,
          [{
            start: 0,
            length: text.length,
            styledKey: StyledStringKey.FONT,
            styledValue: new TextStyle({
              fontColor: style?.isLink ? that.theme?.link?.fontColor : fontStyle?.fontColor,
              fontWeight: style?.fontWeight
            })
          }, {
            start: 0,
            length: text.length,
            styledKey: StyledStringKey.GESTURE,
            styledValue: new GestureStyle({ onClick: onSpanClick })
          }]))
      }
    } else if (tokenItem.type === 'del') {
      let text = clearMarkdown(tokenItem.text)
      that.inlineTextStyle.appendStyledString(new MutableStyledString(text,
        [{
          start: 0,
          length: text.length,
          styledKey: StyledStringKey.DECORATION,
          styledValue: new DecorationStyle({
            type: TextDecorationType.LineThrough,
            color: Color.Black,
            style: TextDecorationStyle.SOLID
          })
        }, {
          start: 0,
          length: text.length,
          styledKey: StyledStringKey.FONT,
          styledValue: new TextStyle({
            fontColor: style?.isLink ? that.theme?.link?.fontColor : fontStyle?.fontColor,
          })
        }, {
          start: 0,
          length: text.length,
          styledKey: StyledStringKey.GESTURE,
          styledValue: new GestureStyle({ onClick: onSpanClick })
        }]))
    } else if (tokenItem.type === 'text') {
      let text = clearMarkdown(tokenItem.text)
      that.inlineTextStyle.appendStyledString(new MutableStyledString(text,
        [{
          start: 0,
          length: text.length,
          styledKey: StyledStringKey.FONT,
          styledValue: new TextStyle({
            fontColor: style?.isLink ? that.theme?.link?.fontColor : fontStyle?.fontColor,
            fontWeight: style?.fontWeight
          })
        }, {
          start: 0,
          length: text.length,
          styledKey: StyledStringKey.GESTURE,
          styledValue: new GestureStyle({ onClick: onSpanClick })
        }]))
    } else if (tokenItem.type === 'em') {
      let text = clearMarkdown(tokenItem.text)
      that.inlineTextStyle.appendStyledString(new MutableStyledString(text,
        [{
          start: 0,
          length: text.length,
          styledKey: StyledStringKey.FONT,
          styledValue: new TextStyle({
            fontColor: style?.isLink ? that.theme?.link?.fontColor : fontStyle?.fontColor,
            fontStyle: FontStyle.Italic
          })
        }, {
          start: 0,
          length: text.length,
          styledKey: StyledStringKey.GESTURE,
          styledValue: new GestureStyle({ onClick: onSpanClick })
        }]))
    } else if (tokenItem.type === 'codespan') {
      let codeSpan = ` ${clearMarkdown(tokenItem.text)} `
      that.inlineTextStyle.appendStyledString(new MutableStyledString(codeSpan,
        [{
          start: 0,
          length: codeSpan.length,
          styledKey: StyledStringKey.FONT,
          styledValue: new TextStyle({
            fontColor: style?.isLink ? that.theme?.link?.fontColor : fontStyle?.fontColor,
          })
        }, {
          start: 0,
          length: codeSpan.length,
          styledKey: StyledStringKey.BACKGROUND_COLOR,
          styledValue: new BackgroundColorStyle({
            color: that.theme?.codeSpan?.backgroundColor,
            radius: that.theme?.codeSpan?.borderRadius
          })
        }]))
    } else if (tokenItem.type === 'link') {
      await that.parseToken(tokenItem.tokens ?? [], { isLink: true, fontWeight: style?.fontWeight }, () => {
        markdownConfig.linkClick?.(tokenItem['href'])
      })
    } else if (tokenItem.type === 'inlineLatex' && markdownConfig.enableLatex) {
      let fontColor = (typeof fontStyle?.fontColor === 'number' ? fontStyle?.fontColor : 0xffffff) as number
      let fontSize =
        (typeof fontStyle?.fontSize === 'number' ? fontStyle?.fontSize :
          that.getUIContext().fp2px(16)) as number
      let imageInfo = await latexToPixelMap(tokenItem.text, fontSize, fontColor, 0xffffff)
      that.inlineTextStyle.appendStyledString(new MutableStyledString(new ImageAttachment({
        value: imageInfo.pixelMap,
        verticalAlign: ImageSpanAlignment.CENTER,
        size: {
          width: that.getUIContext().px2vp(imageInfo.width),
          height: that.getUIContext().px2vp(imageInfo.height)
        },
        objectFit: ImageFit.Contain
      })))
    }
    // else if (tokenItem.type === 'html') {
    //   // Span(tokenItem.text)
    //   let text = await StyledString.fromHtml(tokenItem.text)
    //   this.inlineTextStyle.appendStyledString(text)
    // }
    else {
      // markConfig.customInlineBuilder?.builder(tokenItem.type, tokenItem, this)
    }
  }

  // this.inlineTextController.setStyledString(this.inlineTextStyle)
}