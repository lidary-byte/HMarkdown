import { Token } from './core'
import { MarkdownComponent } from './MarkdownComponent'
import parseTask from './ParseTask'
import { IMarkConfig } from './config/MarkConfig'
import { markConfig } from './Index'
import { mergeTheme } from './config/DefaultTheme'


@Component
export struct Markdown {
  @Prop @Watch('watchConfig') markConfig: IMarkConfig = markConfig.globalConfig
  @Prop @Watch('watchContent') content: string = ''
  @State config: IMarkConfig = this.markConfig
  @State tokenList: Token[] = []

  aboutToAppear(): void {
    this.watchConfig()
    this.watchContent()
  }

  watchConfig() {
    console.error('---------------config:')
    this.config = {
      lineSpace: this.markConfig.lineSpace,
      textLineSpace: this.markConfig.textLineSpace,
      theme: mergeTheme(this.markConfig.theme)
    }
    markConfig.initConfig(this.markConfig)
  }

  watchContent() {
    this.tokenList = parseTask(this.content)
    // taskpool.execute(parseTask, this.content)
    //   .then((tokenList: ESObject) => {
    //      this.tokenList = tokenList
    //   })
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      if (this.tokenList.length !== 0) {
        MarkdownComponent({ tokenList: this.tokenList, config: this.config })
      }
    }
  }
}
