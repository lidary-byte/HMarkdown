import { marked, Token } from './core'
import { MarkdownComponent } from './MarkdownComponent'
import { mergeTheme } from './config/DefaultTheme'
import { MarkdownFontStyle, MarkdownTheme } from './config/MarkdownTheme'
import { KEY_DEFAULT_FONT, KEY_LINE_SPACE, KEY_THEME } from './config/Constant'
import { markConfig } from './Index'


@Component
export struct Markdown {
  @Prop @Watch('watchContent') content: string = ''
  @State tokenList: Token[] = []
  @Prop @Watch('watchTheme') theme: MarkdownTheme = mergeTheme(markConfig.theme)
  @Prop @Watch('watchLineSpace') lineSpace: number = 0
  @Prop @Watch('watchDefaultFont') fontStyle: MarkdownFontStyle = {
    fontColor: Color.Black,
    fontSize: 16,
    fontWeight: FontWeight.Normal
  }

  aboutToAppear(): void {
    this.watchContent()
    this.watchTheme()
    this.watchLineSpace()
    this.watchDefaultFont()
  }

  watchTheme() {
    AppStorage.setOrCreate(KEY_THEME, mergeTheme(this.theme))
  }

  watchLineSpace() {
    AppStorage.setOrCreate(KEY_LINE_SPACE, this.lineSpace)
  }

  watchDefaultFont() {
    AppStorage.setOrCreate(KEY_DEFAULT_FONT, {
      fontColor: this.fontStyle.fontColor ?? Color.Black,
      fontSize: this.fontStyle.fontSize ?? 16,
      fontWeight: this.fontStyle.fontWeight ?? FontWeight.Normal
    } as MarkdownFontStyle)
  }

  watchContent() {
    this.tokenList = marked.lexer(this.content)
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      if (this.tokenList.length !== 0) {
        MarkdownComponent({ tokenList: this.tokenList })
      }
    }
  }
}
