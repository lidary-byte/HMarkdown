import { marked, Token } from './core'
import { MarkdownComponent } from './MarkdownComponent'
import { mergeTheme } from './config/DefaultTheme'
import { MarkdownFontStyle, MarkdownTheme } from './config/MarkdownTheme'
import { KEY_FONT_STYLE, KEY_LINE_SPACE, KEY_TEXT_LINE_SPACE, KEY_THEME } from './config/Constant'
import { markConfig } from './Index'


@Component
export struct Markdown {
  @Prop @Watch('watchContent') content: string = ''
  @State tokenList: Token[] = []
  @Prop @Watch('watchTheme') theme: MarkdownTheme
  @Prop @Watch('watchLineSpace') lineSpace: number
  @Prop @Watch('watchTextLineSpace') textLineSpace: number
  @Prop @Watch('watchDefaultFont') fontStyle: MarkdownFontStyle
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
    this.tokenList = marked.lexer(this.content)
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // if (this.tokenList.length !== 0) {
        MarkdownComponent({ tokenList: this.tokenList })
      // }
    }
  }
}
