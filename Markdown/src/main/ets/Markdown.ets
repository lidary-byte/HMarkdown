import { Token } from './core'
import { MarkdownComponent } from './component/MarkdownComponent'
import { parseMarkdown } from './utils'
import { markdown, MarkdownOptions, MarkdownOptionsClass } from './Index'
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
  @Param options?: MarkdownOptions = undefined
  @Local tokenList: Token[] = []
  @Local optionsClass: MarkdownOptionsClass = new MarkdownOptionsClass()
  @Event onLoading?: () => void
  @Event onSuccess?: () => void
  @Event onError?: (e: BusinessError) => void

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
      this.optionsClass.theme = this.options.darkMode ? deepMerge(defaultDarkTheme, this.options.darkTheme) :
        deepMerge(defaultTheme, this.options.theme)
      this.optionsClass.lineSpacing = this.options.lineSpace ?? 12
      this.optionsClass.inlineLineSpacing = this.options.inlineLineSpace ?? LengthMetrics.vp(12)
      this.optionsClass.maxLines = this.options.maxLines
      markdown.registerLinkClick = this.options.linkClick
      markdown.registerImageClick = this.options.imageClick
      markdown.customInlineBuilder = this.options.customInlineBuilder
      markdown.customBlockBuilder = this.options.customBlockBuilder
    }
  }

  build() {
    if (this.tokenList.length != 0) {
      MarkdownComponent({ tokenList: this.tokenList, options: this.optionsClass })
    }
  }
}
