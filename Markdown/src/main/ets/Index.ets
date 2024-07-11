/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description:
 */
import { defaultTheme, mergeTheme } from './config/DefaultTheme'
import { LengthMetrics } from '@ohos.arkui.node'
import { IMarkConfig } from './config/MarkConfig'


export namespace markConfig {


  export let globalConfig: IMarkConfig = {
    lineSpace: 4,
    textLineSpace: new LengthMetrics(4),
    theme: defaultTheme
  }

  export function initConfig(config: IMarkConfig) {
    globalConfig = {
      lineSpace: config.lineSpace ?? 4,
      textLineSpace: config.textLineSpace ?? new LengthMetrics(4),
      theme: mergeTheme(defaultTheme, config.theme)
    }
  }


  export let registerImageClick: ImageClick

  export let registerLinkClick: LinkClick
}


type ImageClick = (imageUrl: string) => void

export type LinkClick = (url: string, text: string) => void