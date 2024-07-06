/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description: 默认主题
 */
import { MarkdownTheme } from './MarkdownTheme'


export function defaultLightTheme(): MarkdownTheme {
  return {
    themeColor: '#0A69DA',
    backgroundColor: Color.White,
    defaultFont: {
      fontColor: Color.Black,
      fontSize: 16,
      fontWeight: FontWeight.Normal
    },
    blockQuote: {
      borderRadius: 4,
      driveWidth: 4,
      backgroundColor: '#EFF1F2'
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
    }
  }
}


export function defaultDarkTheme(): MarkdownTheme {
  return {
    h1: {
      fontColor: Color.Black,
      fontWeight: FontWeight.Bold,
      fontSize: 22
    }, link: {
      fontColor: Color.Blue
    }
  }
}
