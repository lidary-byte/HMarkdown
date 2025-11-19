/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { MarkdownTheme } from '../config/MarkdownTheme'
import { clearMarkdown, latexToPixelMap } from '../utils'
import { Token } from './Tokens'


interface InlineParams {
  token: Token[],
  theme: MarkdownTheme,
  uiContext: UIContext,
  inlineTextStyle?: MutableStyledString,
  isLink?: boolean
  fontWeight?: FontWeight,
  onSpanClick?: () => void
}

export async function parseInlineToken(params: InlineParams): Promise<MutableStyledString | undefined> {
  if (params.inlineTextStyle == undefined) {
    params.inlineTextStyle = new MutableStyledString('')
  }

  for (let i = 0; i < params.token.length; i++) {
    let tokenItem = params.token[i]

    if (tokenItem.type === 'image') {
      params.inlineTextStyle.appendStyledString(new MutableStyledString(new ImageAttachment({
        resourceValue: tokenItem.href,
        verticalAlign: ImageSpanAlignment.CENTER,
        size: { width: '100%' },
        objectFit: params.theme?.imageObjectFit,
      })))
      try {
        params.inlineTextStyle.setStyle({
          start: params.inlineTextStyle.length - 1,
          length: 1,
          styledKey: StyledStringKey.GESTURE,
          styledValue: new GestureStyle({
            onClick: () => {
              // markdownConfig.imageClick?.(tokenItem['href'])
            }
          })
        })
      } catch (_) {
      }
    } else if (tokenItem.type === 'br') {
      params.inlineTextStyle.appendStyledString(new MutableStyledString('\n'))
    } else if (tokenItem.type === 'strong') {
      if (tokenItem.tokens?.length != 0) {
        await parseInlineToken({
          token: tokenItem.tokens ?? [],
          theme: params.theme,
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
              fontColor: params?.isLink ? params.theme?.linkColor :
                params.theme.fontStyle?.fontColor,
              fontWeight: params?.fontWeight ?? params?.theme?.fontStyle?.fontWeight
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
            color: params?.isLink ? params.theme?.linkColor : params.theme.fontStyle?.fontColor,
            style: TextDecorationStyle.SOLID
          })
        }, {
          start: 0,
          length: text.length,
          styledKey: StyledStringKey.FONT,
          styledValue: new TextStyle({
            fontColor: params?.isLink ? params.theme?.linkColor : params.theme.fontStyle?.fontColor,
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
            fontColor: params?.isLink ? params.theme?.linkColor : params.theme.fontStyle?.fontColor,
            fontWeight: params?.fontWeight ?? params?.theme?.fontStyle?.fontWeight
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
            fontColor: params?.isLink ? params.theme?.linkColor : params.theme.fontStyle?.fontColor,
            fontStyle: FontStyle.Italic
          })
        }, {
          start: 0,
          length: text.length,
          styledKey: StyledStringKey.GESTURE,
          styledValue: new GestureStyle({ onClick: params.onSpanClick })
        }]))
    } else if (tokenItem.type === 'codespan') {
      let codeSpan = `  ${clearMarkdown(tokenItem.text)}  `
      params.inlineTextStyle.appendStyledString(new MutableStyledString(codeSpan,
        [{
          start: 0,
          length: codeSpan.length,
          styledKey: StyledStringKey.FONT,
          styledValue: new TextStyle({
            fontColor: params.theme?.fontStyle?.fontColor,

            // fontSize: params.theme?.fontStyle?.fontSize
          })
        }, {
          start: 0,
          length: codeSpan.length,
          styledKey: StyledStringKey.BACKGROUND_COLOR,
          styledValue: new BackgroundColorStyle({
            color: params.theme?.codeSpan?.backgroundColor,
            radius: params.theme?.codeSpan?.borderRadius
          })
        }]))
    } else if (tokenItem.type === 'link') {
      await parseInlineToken({
        token: tokenItem.tokens ?? [],
        theme: params.theme,
        // fontStyle: params.fontStyle,
        inlineTextStyle: params.inlineTextStyle,
        fontWeight: params.fontWeight,
        uiContext: params.uiContext,
        isLink: true,
        onSpanClick: () => {
          // markdownConfig.linkClick?.(tokenItem['href'])
        }
      })
    } else if (tokenItem.type === 'inlineLatex') {
      let imageInfo = await latexToPixelMap(tokenItem.text, params.uiContext.fp2px(params.theme.latexStyle?.fontSize),
        params.theme.latexStyle?.fontColor ?? 0xffffffff, params.theme.latexStyle?.backgroundColor ?? 0xffffffff)
      params.inlineTextStyle.appendStyledString(new MutableStyledString(new ImageAttachment({
        value: imageInfo.pixelMap,
        verticalAlign: ImageSpanAlignment.CENTER,
        size: {
          width: params.uiContext.px2vp(imageInfo.width),
          height: params.uiContext.px2vp(imageInfo.height)
        },
        objectFit: ImageFit.Contain
      })))
      // }  else if (tokenItem.type === 'html') {
      //   // 从当前i忘下找 找到最近的html
      //   let htmlToken: string = tokenItem.text;
      //   for (let j = i + 1; j < params.token.length; j++) {
      //     let htmlTokenItem = params.token[j]
      //     htmlToken += htmlTokenItem['text']
      //     if (htmlTokenItem.type == 'html') {
      //       break;
      //     }
      //   }
      //   htmlToken
      // params.token.slice()
      // Span(tokenItem.text)
      // let text = await StyledString.fromHtml(tokenItem.text)
      // this.inlineTextStyle.appendStyledString(text)
    } else {
      // markConfig.customInlineBuilder?.builder(tokenItem.type, tokenItem, this)
    }

  }


  return params.inlineTextStyle
  // this.inlineTextController.setStyledString(this.inlineTextStyle)
}
