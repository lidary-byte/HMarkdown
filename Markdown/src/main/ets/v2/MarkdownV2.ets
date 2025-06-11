import { Token } from '../core'
import { mergeTheme } from '../config/DefaultTheme'
import { MarkdownFontStyle, MarkdownTheme } from '../config/MarkdownTheme'
import { markConfig } from '../Index'
import { MarkdownComponentV2 } from './component/MarkdownComponentV2'
import { KEY_FONT_STYLE, KEY_LINE_SPACE, KEY_TEXT_LINE_SPACE, KEY_THEME } from '../config/Constant'
import { parseMarkdown } from '../utils'


@ComponentV2
export struct MarkdownV2 {
  @Param @Once tokenList: Token[] = []
  @Param content: string = ''
  @Param theme: MarkdownTheme = mergeTheme(markConfig.theme)
  @Param lineSpace: number = 0
  @Param textLineSpace: number = 0
  @Param fontStyle: MarkdownFontStyle = {
    fontColor: Color.Black,
    fontSize: 16,
    fontWeight: FontWeight.Normal
  }
  @Param mdInlineModifier?: AttributeModifier<TextAttribute> = undefined
  // 外部不要传
  @Provider() _mdInlineModifier?: AttributeModifier<TextAttribute> = undefined
  @Provider(KEY_THEME) _theme: MarkdownTheme = this.theme
  @Provider(KEY_LINE_SPACE) _lineSpace: number = this.lineSpace
  @Provider(KEY_TEXT_LINE_SPACE) _textLineSpace: number = this.textLineSpace
  @Provider(KEY_FONT_STYLE) _fontStyle: MarkdownFontStyle = this.fontStyle

  aboutToAppear(): void {
    this.watchContent()
  }

  @Monitor('theme','lineSpace','textLineSpace','fontStyle','mdInlineModifier')
  watchStyle(monitor: IMonitor) {
    monitor.dirty.forEach((path) => {
      if (path === 'theme') {
        this._theme = mergeTheme(monitor.value(path)?.now ?? this._theme)
      }
      if (path === 'lineSpace') {
        this._lineSpace = monitor.value<number>(path)?.now ?? this._lineSpace
      }
      if (path === 'textLineSpace') {
        this._textLineSpace = monitor.value<number>(path)?.now ?? this._textLineSpace
      }
      if (path === 'fontStyle') {
        this._fontStyle = monitor.value(path)?.now ?? this._fontStyle
      }
      if (path === 'mdInlineModifier') {
        this._mdInlineModifier = monitor.value<AttributeModifier<TextAttribute>>(path)?.now
      }
    })
  }

  @Monitor('content')
  watchContent() {
    if (this.content && this.content.trim().length !== 0) {
      this.tokenList = parseMarkdown(this.content)
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      if (this.tokenList.length !== 0) {
        MarkdownComponentV2({ tokenList: this.tokenList })
      }
    }
  }
}
