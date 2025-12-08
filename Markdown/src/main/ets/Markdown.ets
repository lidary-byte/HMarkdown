import { Token } from './core'
import { MarkdownComponent } from './component/MarkdownComponent'
import { parseMarkdown } from './utils'
import { MarkdownOptions } from './Index'
import { defaultDarkTheme, defaultTheme } from './config/DefaultTheme'
import { LengthMetrics } from '@kit.ArkUI'
import deepMerge from './merge'
import { taskpool } from '@kit.ArkTS'
import { BusinessError } from '@kit.BasicServicesKit'


@ComponentV2
export struct Markdown {
  /**
   * 外层传入时仅需传递content或token
   */
  @Param token: Token[] = []
  @Param content: string = ''
  @Param options: MarkdownOptions = {
    theme: defaultTheme,
    darkTheme: defaultDarkTheme,
    lineSpace: 12,
    inlineLineSpace: LengthMetrics.vp(12)
  }
  @Event onLoading?: () => void
  @Event onSuccess?: () => void
  @Event onError?: (e: BusinessError) => void
  @Local tokenList: Token[] = []

  aboutToAppear(): void {
    this.watchOptions()
    if (this.token.length != 0) {
      this.watchToken()
    } else {
      this.watchContent()
    }
  }

  @Monitor('token')
  watchToken() {
    this.tokenList = this.token
  }

  @Monitor('content')
  watchContent() {
    if (this.content && this.content.trim().length !== 0) {
      this.onLoading?.()
      taskpool.execute(parseMarkdown, this.content, this.options?.options, this.options?.extensions).then((data) => {
        this.tokenList = data as Token[]
        this.onSuccess?.()
      }).catch((e: BusinessError) => {
        this.onError?.(e)
      })
    }
  }

  @Monitor('options')
  watchOptions() {
    if (this.options) {
      if (!this.options.lineSpace) {
        this.options.lineSpace = 12
      }
      if (!this.options.inlineLineSpace) {
        this.options.inlineLineSpace = LengthMetrics.vp(12)
      }
      this.options.theme = deepMerge(defaultTheme, this.options?.theme)
      this.options.darkTheme = deepMerge(defaultDarkTheme, this.options?.darkTheme)
    }
  }

  build() {
    if (this.tokenList.length != 0) {
      MarkdownComponent({ tokenList: this.tokenList, options: this.options })
    }
  }
}
