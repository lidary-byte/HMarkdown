/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description: 默认主题
 */
import { MarkdownFontStyle, MarkdownTheme } from './MarkdownTheme'
import { LengthMetrics } from '@kit.ArkUI'

const defaultFontStyle: MarkdownFontStyle = {
  fontWeight: FontWeight.Normal,
  fontColor: Color.Black,
  fontSize: 16
}
const defaultDarkFontStyle: MarkdownFontStyle = {
  fontWeight: FontWeight.Normal,
  fontColor: Color.White,
  fontSize: 16
}

export const defaultDarkTheme: MarkdownTheme = {
  lineSpacing: 8,
  themeColor: Color.Blue,
  inlineLineSpacing: LengthMetrics.vp(8),
  blockQuote: {
    borderRadius: 4,
    driveWidth: 4,
    backgroundColor: '#1020cb58'
  },
  heading:
  [
    {
      fontWeight: FontWeight.Bolder,
      fontColor: Color.White,
      fontSize: 30,
    },
    {
      fontWeight: FontWeight.Bold,
      fontColor: Color.White,
      fontSize: 28
    },
    {
      fontWeight: FontWeight.Medium,
      fontColor: Color.White,
      fontSize: 26
    },
    {
      fontWeight: FontWeight.Regular,
      fontColor: Color.White,
      fontSize: 24
    },
    {
      fontWeight: FontWeight.Normal,
      fontColor: Color.White,
      fontSize: 22
    },
    {
      fontWeight: FontWeight.Lighter,
      fontColor: Color.White,
      fontSize: 20
    },
  ],

  image: {
    width: 'auto',
    height: 'auto',
    objectFit: ImageFit.Contain
  },
  link: {
    fontColor: Color.Blue,
  },
  codeSpan: {
    backgroundColor: '#ff1e6b91',
    borderRadius: 4
  },
  code: {
    fontColor: {
      'string': '#653170',
      'text': Color.White,
      'keyword': '#0A69DA',
      'type': '#0A69DA',
      'symbol': Color.White,
      'number': '#ffecd9ac',
      'boolean': '#ff3c1dc3',
    },
    fontSize: 16,
    backgroundColor: '#ff041b30',
    borderRadius: 10,
    codeSpanBorderRadius: 10,
    codeSpanBackgroundColor: '#F6F8FA'
  },
  list: {
    fontStyle: defaultDarkFontStyle,
    marginLeft: 12
  },
  paragraph: defaultDarkFontStyle,
  latex: {
    fontSize: 20,
    fontColor: 0xffffffff,
    backgroundColor: 0x00000000
  },
  html: defaultDarkFontStyle
}


export const defaultTheme: MarkdownTheme = {
  lineSpacing: 8,
  inlineLineSpacing: LengthMetrics.vp(8),
  themeColor: Color.Blue,
  blockQuote: {
    borderRadius: 4,
    driveWidth: 4,
    backgroundColor: '#10808080'
  },
  heading: [
    {
      fontWeight: FontWeight.Bolder,
      fontColor: Color.Black,
      fontSize: 30,
    }, {
    fontWeight: FontWeight.Bold,
    fontColor: Color.Black,
    fontSize: 28
  }, {
    fontWeight: FontWeight.Medium,
    fontColor: Color.Black,
    fontSize: 26
  }, {
    fontWeight: FontWeight.Regular,
    fontColor: Color.Black,
    fontSize: 24
  }, {
    fontWeight: FontWeight.Normal,
    fontColor: Color.Black,
    fontSize: 22
  }, {
    fontWeight: FontWeight.Lighter,
    fontColor: Color.Black,
    fontSize: 20
  },
  ],
  image: {
    width: 'auto',
    height: 'auto',
    objectFit: ImageFit.Contain
  },
  link: {
    fontColor: Color.Blue,
  },
  codeSpan: {
    backgroundColor: '#EFF1F2',
    borderRadius: 4
  },
  code: {
    fontColor: {
      'string': '#653170',
      'text': Color.Black,
      'keyword': '#0A69DA',
      'type': '#0A69DA',
      'symbol': Color.Black,
      'number': '#ffecd9ac',
      'boolean': '#ff3c1dc3',
    },
    fontSize: 16,
    backgroundColor: '#F6F8FA',
    borderRadius: 10,
    codeSpanFontSize: LengthMetrics.fp(16),
    codeSpanBorderRadius: 10,
    codeSpanBackgroundColor: '#F6F8FA'
  },
  list: {
    fontStyle: defaultFontStyle,
    marginLeft: 12
  },
  paragraph: defaultFontStyle,
  latex: {
    fontSize: 20,
    fontColor: 0xff000000,
    backgroundColor: 0x00000000
  },
  html: defaultFontStyle
}


