/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { MarkdownOptions } from '../Index'
import { clearMarkdown, getTheme, latexToPixelMap } from '../utils'
import { Token } from './Tokens'


export interface InlineParams {
  token: Token[],
  options: MarkdownOptions,
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
        objectFit: getTheme(params.options).imageObjectFit,
      })))
      try {
        params.inlineTextStyle.setStyle({
          start: params.inlineTextStyle.length - 1,
          length: 1,
          styledKey: StyledStringKey.GESTURE,
          styledValue: new GestureStyle({
            onClick: () => {
              params.options.imageClick?.(tokenItem['href'])
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
          options: params.options,
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
              fontColor: params?.isLink ? getTheme(params.options).linkColor :
                getTheme(params.options).fontStyle?.fontColor,
              fontWeight: params?.fontWeight ?? getTheme(params.options).fontStyle?.fontWeight
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
            color: params?.isLink ? getTheme(params.options).linkColor : getTheme(params.options).fontStyle?.fontColor,
            style: TextDecorationStyle.SOLID
          })
        }, {
          start: 0,
          length: text.length,
          styledKey: StyledStringKey.FONT,
          styledValue: new TextStyle({
            fontColor: params?.isLink ? getTheme(params.options).linkColor :
              getTheme(params.options).fontStyle?.fontColor,
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
            fontColor: params?.isLink ? getTheme(params.options).linkColor :
              getTheme(params.options).fontStyle?.fontColor,
            fontWeight: params?.fontWeight ?? getTheme(params.options).fontStyle?.fontWeight
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
            fontColor: params?.isLink ? getTheme(params.options).linkColor :
              getTheme(params.options).fontStyle?.fontColor,
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
            fontColor: getTheme(params.options).fontStyle?.fontColor
          })
        }, {
          start: 0,
          length: codeSpan.length,
          styledKey: StyledStringKey.BACKGROUND_COLOR,
          styledValue: new BackgroundColorStyle({
            color: getTheme(params.options).codeSpan?.backgroundColor,
            radius: getTheme(params.options).codeSpan?.borderRadius
          })
        }]))
    } else if (tokenItem.type === 'link') {
      await parseInlineToken({
        token: tokenItem.tokens ?? [],
        options: params.options,
        inlineTextStyle: params.inlineTextStyle,
        fontWeight: params.fontWeight,
        uiContext: params.uiContext,
        isLink: true,
        onSpanClick: () => {
          params.options.linkClick?.(tokenItem['href'])
        }
      })
    } else if (tokenItem.type === 'inlineLatex') {
      let imageInfo =
        await latexToPixelMap(tokenItem.text, params.uiContext.fp2px(getTheme(params.options).latexStyle?.fontSize),
          getTheme(params.options).latexStyle?.fontColor ?? 0xffffffff,
          getTheme(params.options).latexStyle?.backgroundColor ?? 0xffffffff, params.options.latexResPath)
      params.inlineTextStyle.appendStyledString(new MutableStyledString(new ImageAttachment({
        value: imageInfo.pixelMap,
        verticalAlign: ImageSpanAlignment.CENTER,
        size: {
          width: params.uiContext.px2vp(imageInfo.width),
          height: params.uiContext.px2vp(imageInfo.height)
        },
        objectFit: ImageFit.Contain,
      })))
    } else if (tokenItem.type === 'html') {
      if (tokenItem.block) {
        try {
          let htmlStyledString = await StyledString.fromHtml(tokenItem.text)
          params.inlineTextStyle.appendStyledString(htmlStyledString)
        } catch (error) {
        }
      } else {
        // 行内
        // const htmlTokens = [tokenItem]
        // for (let j = i + 1; j < params.token.length; j++) {
        //   htmlTokens.push(params.token[j])
        //   if (params.token[j].type === 'html') {
        //     break
        //   }
        // }
        // console.error('')
      }
    } else {
      params.options.customInlineBuilder?.(tokenItem, params)
    }
  }
  return params.inlineTextStyle
}
