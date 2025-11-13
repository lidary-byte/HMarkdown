import { Token } from './core'
import { MarkdownTheme } from './config/MarkdownTheme'
import { markdownConfig } from './Index'
import { MarkdownComponent } from './component/MarkdownComponent'
import { parseMarkdown } from './utils'


@ComponentV2
export struct Markdown {
  @Local tokenList: Token[] = []
  /**
   * 外层传入时仅需传递content或token
   */
  @Param token: Token[] = []
  @Param content: string = ''
  @Param darkMode: boolean = false
  theme: MarkdownTheme = markdownConfig.theme!
  darkTheme: MarkdownTheme = markdownConfig.darkTheme!

  //
  // @Param lineSpace: number = 0
  // @Param textLineSpace: number = 0
  // @Param fontStyle: MarkdownFontStyle = {
  //   fontColor: Color.Black,
  //   fontSize: 16,
  //   fontWeight: FontWeight.Normal
  // }
  // @Param mdInlineModifier?: AttributeModifier<TextAttribute> = undefined
  // // 外部不要传
  // @Provider() _mdInlineModifier?: AttributeModifier<TextAttribute> = undefined
  // @Provider(KEY_THEME) _theme: MarkdownTheme = this.theme
  // @Provider(KEY_LINE_SPACE) _lineSpace: number = this.lineSpace
  // @Provider(KEY_TEXT_LINE_SPACE) _textLineSpace: number = this.textLineSpace
  // @Provider(KEY_FONT_STYLE) _fontStyle: MarkdownFontStyle = this.fontStyle

  aboutToAppear(): void {
    if (this.content && this.content.trim().length !== 0) {
      this.watchContent()
    } else if (this.token.length != 0) {
      this.watchToken()
    }
  }

  @Monitor('token')
  watchToken() {
    this.tokenList = this.token
  }

  @Monitor('content')
  watchContent() {
    if (this.content && this.content.trim().length !== 0) {
      // taskpool.execute(parseMarkdown, this.content).then((data) => {
      //   this.tokenList = data as Token[]
      // })
      this.tokenList = parseMarkdown(this.content)
    }
  }

  // @Monitor('theme','lineSpace','textLineSpace','fontStyle','mdInlineModifier')
  // watchStyle(monitor: IMonitor) {
  //   monitor.dirty.forEach((path) => {
  //     if (path === 'theme') {
  //       this._theme = mergeTheme(monitor.value(path)?.now ?? this._theme)
  //     }
  //     if (path === 'lineSpace') {
  //       this._lineSpace = monitor.value<number>(path)?.now ?? this._lineSpace
  //     }
  //     if (path === 'textLineSpace') {
  //       this._textLineSpace = monitor.value<number>(path)?.now ?? this._textLineSpace
  //     }
  //     if (path === 'fontStyle') {
  //       this._fontStyle = monitor.value(path)?.now ?? this._fontStyle
  //     }
  //     if (path === 'mdInlineModifier') {
  //       this._mdInlineModifier = monitor.value<AttributeModifier<TextAttribute>>(path)?.now
  //     }
  //   })
  // }


  build() {
    // Stack({ alignContent: Alignment.TopStart }) {
    if (this.tokenList.length !== 0) {
      MarkdownComponent({ tokenList: this.tokenList, theme: this.darkMode ? this.darkTheme : this.theme })
    }
    // }
  }
}
