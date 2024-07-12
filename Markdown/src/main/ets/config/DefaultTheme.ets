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
export function mergeTheme(theme?: MarkdownTheme): MarkdownTheme {
  if (!theme) {
    return defaultTheme
  }
  return {
    themeColor: theme.themeColor ?? defaultTheme.themeColor,
    blockQuote: {
      borderRadius: theme.blockQuote?.borderRadius ?? defaultTheme.blockQuote?.borderRadius,
      driveWidth: theme.blockQuote?.driveWidth ?? defaultTheme.blockQuote?.driveWidth,
      backgroundColor: theme.blockQuote?.backgroundColor ?? defaultTheme.blockQuote?.backgroundColor
    },
    h1: {
      fontWeight: theme.h1?.fontWeight ?? defaultTheme.h1?.fontWeight,
      fontSize: theme.h1?.fontSize ?? defaultTheme.h1?.fontSize,
    },
    h2: {
      fontWeight: theme.h2?.fontWeight ?? defaultTheme.h2?.fontWeight,
      fontSize: theme.h2?.fontSize ?? defaultTheme.h2?.fontSize,
    },
    h3: {
      fontWeight: theme.h3?.fontWeight ?? defaultTheme.h3?.fontWeight,
      fontSize: theme.h3?.fontSize ?? defaultTheme.h3?.fontSize,

    },
    h4: {
      fontWeight: theme.h4?.fontWeight ?? defaultTheme.h4?.fontWeight,
      fontSize: theme.h4?.fontSize ?? defaultTheme.h4?.fontSize,
    },
    h5: {

      fontWeight: theme.h5?.fontWeight ?? defaultTheme.h5?.fontWeight,
      fontSize: theme.h5?.fontSize ?? defaultTheme.h5?.fontSize,
    },
    h6: {
      fontWeight: theme.h6?.fontWeight ?? defaultTheme.h6?.fontWeight,
      fontSize: theme.h6?.fontSize ?? defaultTheme.h6?.fontSize,
    },
    image: {
      width: theme.image?.width ?? defaultTheme.image?.width,
      height: theme.image?.height ?? defaultTheme.image?.height,
      objectFit: theme.image?.objectFit ?? defaultTheme.image?.objectFit,
    },
    link: {
      fontColor: theme.link?.fontColor ?? defaultTheme.link?.fontColor,
    },
    codeSpan: {
      backgroundColor: theme.codeSpan?.backgroundColor ?? defaultTheme.codeSpan?.backgroundColor,
      borderRadius: theme.codeSpan?.borderRadius ?? defaultTheme.codeSpan?.borderRadius,
    },
    codeHighlight: {
      'string': theme.codeHighlight?.string ?? defaultTheme.codeHighlight?.string,
      'text': theme.codeHighlight?.text ?? defaultTheme.codeHighlight?.text,
      'keyword': theme.codeHighlight?.keyword ?? defaultTheme.codeHighlight?.keyword,
      'type': theme.codeHighlight?.type ?? defaultTheme.codeHighlight?.type,
      'symbol': theme.codeHighlight?.symbol ?? defaultTheme.codeHighlight?.symbol,
      'number': theme.codeHighlight?.number ?? defaultTheme.codeHighlight?.number,
      'boolean': theme.codeHighlight?.boolean ?? defaultTheme.codeHighlight?.boolean,
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


