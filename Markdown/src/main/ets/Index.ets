/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description:
 */
import { defaultTheme } from './config/DefaultTheme'
import { MarkdownTheme } from './config/MarkdownTheme'
import { marked, Token, TokenizerExtension } from './core'


export namespace markConfig {


  // export let globalConfig: IMarkConfig = {
  //   lineSpace: 4,
  //   textLineSpace: new LengthMetrics(4),
  //   theme: defaultTheme
  // }
  export let theme: MarkdownTheme = defaultTheme

  // 自定义的block渲染
  export let customBlockBuilder: WrappedBuilder<[string, Token]>

  // 自定义的inline渲染
  export let customInlineBuilder: WrappedBuilder<[string, Token]>


  export function addPlugin(plugins: TokenizerExtension[]) {
    marked.use({ extensions: plugins })
  }


  export let registerImageClick: ImageClick

  export let registerLinkClick: LinkClick
}


type ImageClick = (url?: string) => void

type LinkClick = (url?: string) => void