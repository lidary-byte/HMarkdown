import { Token } from './core'
import { IMarkConfig, MarkConfig, markTheme } from './Index'
import { MarkdownComponent } from './MarkdownComponent'
import parseTask from './ParseTask'
import { taskpool } from '@kit.ArkTS'


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
    taskpool.execute(parseTask, this.content)
      .then((tokenList: ESObject) => {
         this.tokenList = tokenList
      })
  }

  build() {
   Stack({alignContent: Alignment.TopStart}){
     if (this.tokenList.length !== 0) {
       MarkdownComponent({ tokenList: this.tokenList })
         .backgroundColor(markTheme().backgroundColor)
     }
   }
  }
}
