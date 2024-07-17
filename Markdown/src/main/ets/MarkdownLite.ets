import { marked, Token, Tokens } from './core'
import { MarkdownComponent } from './MarkdownComponent'
import { defaultTheme, mergeTheme } from './config/DefaultTheme'
import { MarkdownFontStyle, MarkdownTheme } from './config/MarkdownTheme'
import { KEY_FONT_STYLE, KEY_LINE_SPACE, KEY_TEXT_LINE_SPACE, KEY_THEME } from './config/Constant'
import { markConfig } from './Index'
import { Inline } from './component/Inline'


@Component
export struct MarkdownLite {
  @Prop @Watch('watchContent') content: string = ''
  @State textToken: Token[] = []
  @Prop @Watch('watchTheme') theme: MarkdownTheme
  @Prop @Watch('watchLineSpace') lineSpace: number
  @Prop @Watch('watchTextLineSpace') textLineSpace: number
  @Prop @Watch('watchDefaultFont') fontStyle: MarkdownFontStyle
  maxLine?: number = undefined
  // 外部不要传
  @Provide(KEY_THEME) _theme: MarkdownTheme = mergeTheme(markConfig.theme)
  @Provide(KEY_LINE_SPACE) _lineSpace: number = 0
  @Provide(KEY_TEXT_LINE_SPACE) _textLineSpace: number = 0
  @Provide(KEY_FONT_STYLE) _fontStyle: MarkdownFontStyle = {
    fontColor: Color.Black,
    fontSize: 16,
    fontWeight: FontWeight.Normal
  }

  aboutToAppear(): void {
    this.watchContent()
    this.watchTheme()
    this.watchTextLineSpace()
    this.watchLineSpace()
    this.watchDefaultFont()
  }

  watchTheme() {
    this._theme = mergeTheme(this.theme)
  }

  watchTextLineSpace() {
    this._textLineSpace = this.textLineSpace ?? 0
  }

  watchLineSpace() {
    this._lineSpace = this.lineSpace ?? 0
  }

  watchDefaultFont() {
    this._fontStyle = {
      fontColor: this.fontStyle.fontColor ?? Color.Black,
      fontSize: this.fontStyle.fontSize ?? 16,
      fontWeight: this.fontStyle.fontWeight ?? FontWeight.Normal
    }
  }

  watchContent() {
    const tokenList = marked.lexer(this.content)
    tokenList.forEach((item) => {
      if (item.type === 'paragraph') {
        if (item.tokens) {
          this.textToken.push(...item.tokens)
        }
      }
    })
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      if (this.textToken.length !== 0) {
        Inline({ token: this.textToken, maxLine: this.maxLine })
      }
    }
  }
}
