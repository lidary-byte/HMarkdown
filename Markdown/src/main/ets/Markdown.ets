import { marked, Token } from './core'
import { MarkdownComponent } from './MarkdownComponent'
import { IMarkConfig } from './config/MarkConfig'
import { markConfig } from './Index'
import { mergeTheme } from './config/DefaultTheme'


@Component
export struct Markdown {
  @Prop @Watch('watchConfig') markConfig?: IMarkConfig = undefined
  @Prop @Watch('watchContent') content: string = ''
  @Provide config?: IMarkConfig = undefined
  @State tokenList: Token[] = []

  aboutToAppear(): void {
    this.watchContent()
    this.watchConfig()
  }

  watchConfig() {
    this.config = {
      lineSpace: this.markConfig?.lineSpace ?? markConfig.globalConfig.lineSpace,
      textLineSpace: this.markConfig?.textLineSpace ?? markConfig.globalConfig.textLineSpace,
      theme: mergeTheme(markConfig.globalConfig.theme!, this.markConfig?.theme)
    }
    markConfig.initConfig(this.config)
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
