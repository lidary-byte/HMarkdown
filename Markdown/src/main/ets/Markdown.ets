import { marked, Token } from './core'
import { MarkdownComponent } from './component/MarkdownComponent'
import { parseMarkdown } from './utils'
import { MarkdownOptions, MarkdownOptionsClass } from './Index'
import { latexBlock, latexInline } from './core/plugins/latex'
import { defaultDarkTheme, defaultTheme } from './config/DefaultTheme'
import { LengthMetrics } from '@kit.ArkUI'
import deepMerge from './merge'


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

  aboutToAppear(): void {
    marked.setOptions(this.options?.options)
    let extensions = this.options?.extensions ?? []
    // if (this.options?.enableLatex) {
    extensions.push(latexBlock(), latexInline())
    // }
    marked.use({ extensions: extensions })

    this.watchOptions()
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

  @Monitor('options')
  watchOptions() {
    if (this.options) {
      // this.optionsClass.theme = (this.options.darkMode ? (this.options.darkTheme ?? defaultDarkTheme) : (this.options.theme ?? defaultTheme))
      this.optionsClass.theme = this.options.darkMode ? deepMerge(defaultDarkTheme, this.options.darkTheme) :
        deepMerge(defaultTheme, this.options.theme)
      this.optionsClass.lineSpacing = this.options.lineSpacing ?? 12
      this.optionsClass.inlineLineSpacing = this.options.inlineLineSpacing ?? LengthMetrics.vp(12)
      this.optionsClass.imageClick = this.options.imageClick
      this.optionsClass.linkClick = this.options.linkClick
    }
  }

  build() {
    if (this.tokenList.length != 0) {
      MarkdownComponent({ tokenList: this.tokenList, options: this.optionsClass })
    }
  }
}
