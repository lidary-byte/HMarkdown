/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description:
 */
import { defaultTheme, mergeTheme } from './config/DefaultTheme'
import { MarkdownTheme } from './config/MarkdownTheme'
import { marked, TokenizerExtension, Tokens } from './core'


export namespace markConfig {

  export let theme: MarkdownTheme = defaultTheme

  // 自定义的block渲染
  export let customBlockBuilder: WrappedBuilder<[string, Tokens.Generic, ESObject]>

  // 自定义的inline渲染
  export let customInlineBuilder: WrappedBuilder<[string, Tokens.Generic, ESObject]>


  export function setTheme(markTheme: MarkdownTheme) {
    theme = mergeTheme(markTheme)
  }

  export function addPlugin(plugins: TokenizerExtension[]) {
    marked.setOptions({
      async: true,
      gfm: true,
    })
    marked.use({ extensions: plugins })
  }


  export let registerImageClick: ImageClick

  export let registerLinkClick: LinkClick
}


type ImageClick = (url?: string) => void

type LinkClick = (url?: string) => void