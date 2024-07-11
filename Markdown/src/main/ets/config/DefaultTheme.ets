/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description: 默认主题
 */
import { MarkdownTheme } from './MarkdownTheme'


/**
 * 合并theme 将外部传入的theme内的空字段用defaultTheme()的值覆盖
 * @returns
 */
export function mergeTheme(oldTheme: MarkdownTheme, theme?: MarkdownTheme): MarkdownTheme {
  if (!theme) {
    return defaultTheme
  }
  return {
    themeColor: theme.themeColor ?? oldTheme.themeColor,
    defaultFont: {
      fontColor: theme.defaultFont?.fontColor ?? oldTheme.defaultFont?.fontColor,
      fontSize: theme.defaultFont?.fontSize ?? oldTheme.defaultFont?.fontSize,
      fontWeight: theme.defaultFont?.fontWeight ?? oldTheme.defaultFont?.fontWeight
    },
    blockQuote: {
      borderRadius: theme.blockQuote?.borderRadius ?? oldTheme.blockQuote?.borderRadius,
      driveWidth: theme.blockQuote?.driveWidth ?? oldTheme.blockQuote?.driveWidth,
      backgroundColor: theme.blockQuote?.backgroundColor ?? oldTheme.blockQuote?.backgroundColor
    },
    h1: {
      fontColor: theme.h1?.fontColor ?? oldTheme.h1?.fontColor,
      fontWeight: theme.h1?.fontWeight ?? oldTheme.h1?.fontWeight,
      fontSize: theme.h1?.fontSize ?? oldTheme.h1?.fontSize,
    },
    h2: {
      fontColor: theme.h2?.fontColor ?? oldTheme.h2?.fontColor,
      fontWeight: theme.h2?.fontWeight ?? oldTheme.h2?.fontWeight,
      fontSize: theme.h2?.fontSize ?? oldTheme.h2?.fontSize,
    },
    h3: {
      fontColor: theme.h3?.fontColor ?? oldTheme.h3?.fontColor,
      fontWeight: theme.h3?.fontWeight ?? oldTheme.h3?.fontWeight,
      fontSize: theme.h3?.fontSize ?? oldTheme.h3?.fontSize,

    },
    h4: {
      fontColor: theme.h4?.fontColor ?? oldTheme.h4?.fontColor,
      fontWeight: theme.h4?.fontWeight ?? oldTheme.h4?.fontWeight,
      fontSize: theme.h4?.fontSize ?? oldTheme.h4?.fontSize,
    },
    h5: {

      fontColor: theme.h5?.fontColor ?? oldTheme.h5?.fontColor,
      fontWeight: theme.h5?.fontWeight ?? oldTheme.h5?.fontWeight,
      fontSize: theme.h5?.fontSize ?? oldTheme.h5?.fontSize,
    },
    h6: {
      fontColor: theme.h6?.fontColor ?? oldTheme.h6?.fontColor,
      fontWeight: theme.h6?.fontWeight ?? oldTheme.h6?.fontWeight,
      fontSize: theme.h6?.fontSize ?? oldTheme.h6?.fontSize,
    },
    image: {
      width: theme.image?.width ?? oldTheme.image?.width,
      height: theme.image?.height ?? oldTheme.image?.height,
      objectFit: theme.image?.objectFit ?? oldTheme.image?.objectFit,
    },
    link: {
      fontColor: theme.link?.fontColor ?? oldTheme.link?.fontColor,
    },
    codeSpan: {
      backgroundColor: theme.codeSpan?.backgroundColor ?? oldTheme.codeSpan?.backgroundColor,
      borderRadius: theme.codeSpan?.borderRadius ?? oldTheme.codeSpan?.borderRadius,
    },
    codeHighlight: {
      'string': theme.codeHighlight?.string ?? oldTheme.codeHighlight?.string,
      'text': theme.codeHighlight?.text ?? oldTheme.codeHighlight?.text,
      'keyword': theme.codeHighlight?.keyword ?? oldTheme.codeHighlight?.keyword,
      'type': theme.codeHighlight?.type ?? oldTheme.codeHighlight?.type,
      'symbol': theme.codeHighlight?.symbol ?? oldTheme.codeHighlight?.symbol,
      'number': theme.codeHighlight?.number ?? oldTheme.codeHighlight?.number,
      'boolean': theme.codeHighlight?.boolean ?? oldTheme.codeHighlight?.boolean,
    }
  }
}


export const defaultTheme: MarkdownTheme = {
  themeColor: '#0A69DA',
  defaultFont: {
    fontColor: Color.Black,
    fontSize: 16,
    fontWeight: FontWeight.Normal
  },
  blockQuote: {
    borderRadius: 4,
    driveWidth: 4,
    backgroundColor: '#10808080'
  },
  h1: {
    fontColor: Color.Black,
    fontWeight: FontWeight.Bolder,
    fontSize: 30
  },
  h2: {
    fontColor: Color.Black,
    fontWeight: FontWeight.Bold,
    fontSize: 28
  },
  h3: {
    fontColor: Color.Black,
    fontWeight: FontWeight.Medium,
    fontSize: 26
  },
  h4: {
    fontColor: Color.Black,
    fontWeight: FontWeight.Regular,
    fontSize: 24
  },
  h5: {
    fontColor: Color.Black,
    fontWeight: FontWeight.Normal,
    fontSize: 22
  },
  h6: {
    fontColor: Color.Black,
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


