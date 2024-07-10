/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description:
 */
import { mergeTheme } from './config/DefaultTheme'
import { LengthMetrics } from '@ohos.arkui.node'
import { IMarkConfig } from './config/MarkConfig'
import { MarkdownTheme } from './config/MarkdownTheme'


export namespace markConfig {

  export let lineSpace: string | number

  export let textLineSpace: LengthMetrics

  export let theme: MarkdownTheme


  export function initConfig(config: IMarkConfig) {
    lineSpace = config.lineSpace!
    textLineSpace = config.textLineSpace!
    theme = mergeTheme(config.theme)
  }

  export let registerImageClick: ImageClick

  export let registerLinkClick: LinkClick
}


type ImageClick = (imageUrl: string) => void

export type LinkClick = (url: string, text: string) => void