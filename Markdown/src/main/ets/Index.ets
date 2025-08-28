/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description:
 */
import { defaultTheme, mergeTheme } from './config/DefaultTheme'
import { MarkdownTheme } from './config/MarkdownTheme'
import { marked, MarkedOptions, TokenizerExtension, Tokens } from './core'


export namespace markConfig {

  let tokenPlugins: TokenizerExtension[] = [];

  export let theme: MarkdownTheme = defaultTheme

  // 自定义的block渲染
  export let customBlockBuilder: WrappedBuilder<[string, Tokens.Generic, ESObject]>

  // 自定义的inline渲染
  export let customInlineBuilder: WrappedBuilder<[string, Tokens.Generic, ESObject]>


  export function setTheme(markTheme: MarkdownTheme) {
    theme = mergeTheme(markTheme)
  }

  export function addPlugin(plugins: TokenizerExtension[]) {
    tokenPlugins = plugins
    apply()
  }

  export function apply(options: MarkedOptions = {
    async: true,
    gfm: true,
  }) {
    marked.setOptions(options)
    marked.use({ extensions: tokenPlugins })
  }

  export let registerImageClick: ImageClick

  export let registerLinkClick: LinkClick
}


type ImageClick = (url?: string) => void

type LinkClick = (url?: string) => void