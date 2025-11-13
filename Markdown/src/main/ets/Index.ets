/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description:
 */
import { defaultDarkTheme, defaultTheme } from './config/DefaultTheme';
import { MarkdownTheme } from './config/MarkdownTheme';
import { marked, MarkedOptions, TokenizerExtension, Tokens } from './core';
import { latexBlock, latexInline } from './core/plugins/latex';



interface Config {
  theme?: MarkdownTheme,
  darkTheme?: MarkdownTheme,
  enableLatex?: boolean,
  options?: MarkedOptions,
  extensions?: TokenizerExtension[]
  imageClick?: OnClick,
  linkClick?: OnClick,
  customBlockBuilder?: WrappedBuilder<[string, Tokens.Generic, ESObject]>
}

export const markdownConfig: Config = {
  theme: defaultTheme,
  darkTheme: defaultDarkTheme,
  enableLatex: false,
  options: undefined,
  extensions: undefined,
  imageClick: undefined,
  linkClick: undefined,
  customBlockBuilder: undefined
}



export namespace markdown {

  // export let registerImageClick: OnClick | undefined
  //
  // export let registerLinkClick: OnClick | undefined
  //
  //
  // export let theme: MarkdownTheme
  //
  // // 自定义的block渲染
  // export let customBlockBuilder: WrappedBuilder<[string, Tokens.Generic, ESObject]> | undefined
  //
  // export let enableLatex: boolean = false
  /**
   * @param theme 主题
   * @param darkTheme 暗色主题
   * @param enableLatex 是否开启公式解析
   * @param imageClick 图片点击事件
   * @param linkClick 超链接点击事件
   */
  export function init(config: Config) {
    markdownConfig.theme = config.theme ?? defaultTheme
    markdownConfig.darkTheme = config.darkTheme ?? defaultDarkTheme
    markdownConfig.imageClick = config.imageClick
    markdownConfig.linkClick = config.linkClick
    markdownConfig.customBlockBuilder = config.customBlockBuilder
    markdownConfig.enableLatex = config.enableLatex ?? false
    marked.setOptions(config.options)
    let extensions = config.extensions ?? []
    if (config.enableLatex) {
      extensions.push(latexBlock(), latexInline())
    }
    marked.use({ extensions: extensions })
  }

  // 自定义的inline渲染
  // export let customInlineBuilder: WrappedBuilder<[string, Tokens.Generic, ESObject]>

}


type OnClick = (url?: string) => void