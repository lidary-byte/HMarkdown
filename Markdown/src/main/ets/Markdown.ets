import { Token } from './core'
import { MarkdownComponent } from './MarkdownComponent'
import parseTask, { init } from './ParseTask'
import { IMarkConfig } from './config/MarkConfig'
import { markConfig } from './Index'
import { LengthMetrics } from '@ohos.arkui.node'
import { defaultTheme } from './config/DefaultTheme'


@Component
export struct Markdown {
  @Prop @Watch('watchConfig') config: IMarkConfig = {
    lineSpace: 4,
    textLineSpace: new LengthMetrics(4)
  }
  @Prop @Watch('watchContent') content: string = ''
  @State tokenList: Token[] = []


  aboutToAppear(): void {
    init()
    this.watchConfig()
    this.watchContent()
  }

  watchConfig() {
    markConfig.initConfig(this.config)
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
        MarkdownComponent({ tokenList: this.tokenList })
      }
    }
  }
}
