/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description: 默认主题
 */
import { markConfig } from '../Index'
import { MarkdownTheme } from './MarkdownTheme'


/**
 * 合并theme 将外部传入的theme内的空字段用defaultTheme()的值覆盖
 * @returns
 */
export function mergeTheme(theme?: MarkdownTheme): MarkdownTheme {
  if (!theme) {
    return markConfig.theme
  }
  return {
    themeColor: theme.themeColor ?? markConfig.theme.themeColor,
    blockQuote: {
      borderRadius: theme.blockQuote?.borderRadius ?? markConfig.theme.blockQuote?.borderRadius,
      driveWidth: theme.blockQuote?.driveWidth ?? markConfig.theme.blockQuote?.driveWidth,
      backgroundColor: theme.blockQuote?.backgroundColor ?? markConfig.theme.blockQuote?.backgroundColor
    },
    h1: {
      fontWeight: theme.h1?.fontWeight ?? markConfig.theme.h1?.fontWeight,
      fontSize: theme.h1?.fontSize ?? markConfig.theme.h1?.fontSize,
    },
    h2: {
      fontWeight: theme.h2?.fontWeight ?? markConfig.theme.h2?.fontWeight,
      fontSize: theme.h2?.fontSize ?? markConfig.theme.h2?.fontSize,
    },
    h3: {
      fontWeight: theme.h3?.fontWeight ?? markConfig.theme.h3?.fontWeight,
      fontSize: theme.h3?.fontSize ?? markConfig.theme.h3?.fontSize,

    },
    h4: {
      fontWeight: theme.h4?.fontWeight ?? markConfig.theme.h4?.fontWeight,
      fontSize: theme.h4?.fontSize ?? markConfig.theme.h4?.fontSize,
    },
    h5: {

      fontWeight: theme.h5?.fontWeight ?? markConfig.theme.h5?.fontWeight,
      fontSize: theme.h5?.fontSize ?? markConfig.theme.h5?.fontSize,
    },
    h6: {
      fontWeight: theme.h6?.fontWeight ?? markConfig.theme.h6?.fontWeight,
      fontSize: theme.h6?.fontSize ?? markConfig.theme.h6?.fontSize,
    },
    image: {
      width: theme.image?.width ?? markConfig.theme.image?.width,
      height: theme.image?.height ?? markConfig.theme.image?.height,
      objectFit: theme.image?.objectFit ?? markConfig.theme.image?.objectFit,
    },
    link: {
      fontColor: theme.link?.fontColor ?? markConfig.theme.link?.fontColor,
    },
    codeSpan: {
      backgroundColor: theme.codeSpan?.backgroundColor ?? markConfig.theme.codeSpan?.backgroundColor,
      borderRadius: theme.codeSpan?.borderRadius ?? markConfig.theme.codeSpan?.borderRadius,
    },
    codeHighlight: {
      'string': theme.codeHighlight?.string ?? markConfig.theme.codeHighlight?.string,
      'text': theme.codeHighlight?.text ?? markConfig.theme.codeHighlight?.text,
      'keyword': theme.codeHighlight?.keyword ?? markConfig.theme.codeHighlight?.keyword,
      'type': theme.codeHighlight?.type ?? markConfig.theme.codeHighlight?.type,
      'symbol': theme.codeHighlight?.symbol ?? markConfig.theme.codeHighlight?.symbol,
      'number': theme.codeHighlight?.number ?? markConfig.theme.codeHighlight?.number,
      'boolean': theme.codeHighlight?.boolean ?? markConfig.theme.codeHighlight?.boolean,
    }
  }
}


export const defaultTheme: MarkdownTheme = {
  themeColor: '#0A69DA',
  blockQuote: {
    borderRadius: 4,
    driveWidth: 4,
    backgroundColor: '#10808080'
  },
  h1: {
    fontWeight: FontWeight.Bolder,
    fontSize: 30
  },
  h2: {
    fontWeight: FontWeight.Bold,
    fontSize: 28
  },
  h3: {
    fontWeight: FontWeight.Medium,
    fontSize: 26
  },
  h4: {
    fontWeight: FontWeight.Regular,
    fontSize: 24
  },
  h5: {
    fontWeight: FontWeight.Normal,
    fontSize: 22
  },
  h6: {
    fontWeight: FontWeight.Lighter,
    fontSize: 20
  },
  image: {
    width: 'auto',
    height: 'auto',
    objectFit: ImageFit.Contain
  },
  link: {
    fontColor: '#0A69DA'
  },
  codeSpan: {
    backgroundColor: '#EFF1F2',
    borderRadius: 4
  },
  codeHighlight: {
    'string': '#653170',
    'text': Color.Black,
    'keyword': '#0A69DA',
    'type': '#0A69DA',
    'symbol': Color.Black,
    'number': '#ffecd9ac',
    'boolean': '#ff3c1dc3',
  }
}


