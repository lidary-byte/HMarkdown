// import { defaultMarkConfig, MarkConfig } from './config/MarkConfig'
import { Token } from './core'
import { IMarkConfig, MarkConfig, markTheme } from './Index'
import { MarkdownComponent } from './MarkdownComponent'
import parseTask from './ParseTask'


@Component
export struct Markdown {
  @Prop @Watch('watchConfig') config: IMarkConfig
  @Prop @Watch('watchContent') content: string = ''
  @State tokenList: Token[] = []

  // @Provide globalConfig?: GlobalConfig = undefined

  aboutToAppear(): void {
    this.watchConfig()
    this.watchContent()
  }

  watchConfig() {
    MarkConfig.setConfig(this.config)
      .init()
  }

  watchContent() {
    this.tokenList = parseTask(this.content)

    // taskpool.execute(parseTask, this.content)
    //   .then((tokenList: ESObject) => {
    //      this.tokenList = tokenList
    //   })
  }

  build() {
    if (this.tokenList.length !== 0) {
      MarkdownComponent({ tokenList: this.tokenList })
        .backgroundColor(markTheme().backgroundColor)
    }
  }
}
