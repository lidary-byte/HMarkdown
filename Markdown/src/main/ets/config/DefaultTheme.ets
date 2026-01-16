/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description: 默认主题
 */
import { MarkdownFontStyle, MarkdownTheme } from './MarkdownTheme'

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
  backgroundColor: '#1E1F22',
  themeColor: '#6B9BFA',
  fontStyle: defaultDarkFontStyle,
  headingStyle: [
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
  blockQuoteStyle: {
    borderRadius: 4,
    driveWidth: 2,
    driveColor: '#485C84',
    backgroundColor: '#303236',
  },

  tableStyle: {
    driveWidth: 0.5,
    driveColor: Color.White
  },
  listStyle: {
    marginLeft: 8
  },
  paragraphStyle: defaultDarkFontStyle,
  latexStyle: {
    fontSize: 22,
    fontColor: 0xffffffff,
    backgroundColor: 0x00000000
  },
  code: {
    fontColor: {
      'text': Color.White,
      'string': Color.White,
      'keyword': '#0A69DA',
      'type': '#0A69DA',
      'symbol': '#E3DA90',
      'number': '#B3E54C',
      'boolean': Color.White,
    },
    backgroundColor: '#303236',
    borderRadius: 4,
    codeSpanBorderRadius: 8,
    copyIcon: $r('app.media.ic_copy'),
    copyIconColor: Color.White,
  },
  codeSpan: {
    backgroundColor: '#303236',
    borderRadius: 4
  },
  hrStyle: {
    driveColor: '#393B41',
    driveWidth: 1
  },

  linkColor: '#6A9BFA',
  imageObjectFit: ImageFit.Contain,
  // html?: MarkdownFontStyle
}


export const defaultTheme: MarkdownTheme = {
  backgroundColor: '#FFFFFF',
  themeColor: '#6B9BFA',
  fontStyle: defaultFontStyle,
  headingStyle: [
    {
      fontWeight: FontWeight.Bolder,
      fontColor: Color.Black,
      fontSize: 30,
    },
    {
      fontWeight: FontWeight.Bold,
      fontColor: Color.Black,
      fontSize: 28
    },
    {
      fontWeight: FontWeight.Medium,
      fontColor: Color.Black,
      fontSize: 26
    },
    {
      fontWeight: FontWeight.Regular,
      fontColor: Color.Black,
      fontSize: 24
    },
    {
      fontWeight: FontWeight.Normal,
      fontColor: Color.Black,
      fontSize: 22
    },
    {
      fontWeight: FontWeight.Lighter,
      fontColor: Color.Black,
      fontSize: 20
    },
  ],
  blockQuoteStyle: {
    borderRadius: 4,
    driveWidth: 2,
    driveColor: '#A6BAE1',
    backgroundColor: '#F5F7F9',
  },
  tableStyle: {
    driveWidth: 0.5,
    driveColor: '#EBECF0'
  },
  listStyle: {
    marginLeft: 8
  },
  paragraphStyle: defaultDarkFontStyle,
  latexStyle: {
    fontSize: 22,
    fontColor: 0xff000000,
    backgroundColor: 0x00000000
  },
  code: {
    fontColor: {
      'text': Color.White,
      'string': Color.White,
      'keyword': '#0A69DA',
      'type': '#0A69DA',
      'symbol': '#E3DA90',
      'number': '#B3E54C',
      'boolean': Color.White,
    },
    backgroundColor: '#303236',
    borderRadius: 4,
    copyIcon: $r('app.media.ic_copy'),
    copyIconColor: Color.White,
  },
  codeSpan: {
    backgroundColor: '#F5F7F9',
    borderRadius: 4
  },
  hrStyle: {
    driveColor: '#393B41',
    driveWidth: 1
  },
  linkColor: '#6A9BFA',
  imageObjectFit: ImageFit.Contain,
  // html?: MarkdownFontStyle
}