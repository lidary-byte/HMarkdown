/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description:
 */
import { defaultDarkTheme, defaultLightTheme } from './config/DefaultLightTheme'
import { MarkdownTheme } from './config/MarkdownTheme'
import { LengthMetrics } from '@ohos.arkui.node'

export const markTheme = (): MarkdownTheme => {
  return MarkConfig.getMarkTheme()
}

export const markConfig = (): IMarkConfig => {
  return MarkConfig.getMarkConfig()
}

export class MarkConfig {
  private static markTheme: MarkdownTheme
  private static markConfig: IMarkConfig

  static addPlugin() {
    return MarkConfig
  }

  static setConfig(markConfig?: IMarkConfig) {
    MarkConfig.markConfig = {
      isDark: markConfig?.isDark ?? false,
      lineSpace: markConfig?.lineSpace ?? 10,
      textLineSpace: markConfig?.textLineSpace ?? new LengthMetrics(0),
      darkTheme: markConfig?.darkTheme ?? defaultDarkTheme(),
      lightTheme: markConfig?.lightTheme ?? defaultLightTheme()
    }
    return MarkConfig
  }

  static init() {
    if (!MarkConfig.markConfig) {
      MarkConfig.markConfig = {
        isDark: false,
        lineSpace: 10,
        textLineSpace: new LengthMetrics(0),
        darkTheme: defaultDarkTheme(),
        lightTheme: defaultLightTheme()
      }
    }
    MarkConfig.markTheme =
      MarkConfig.markConfig.isDark ? MarkConfig.markConfig.darkTheme! : MarkConfig.markConfig.lightTheme!
  }

  static getMarkTheme() {
    return MarkConfig.markTheme
  }

  static getMarkConfig() {
    return MarkConfig.markConfig
  }
}


export interface IMarkConfig {
  isDark?: boolean
  lineSpace?: string | number
  textLineSpace?: LengthMetrics
  darkTheme?: MarkdownTheme
  lightTheme?: MarkdownTheme
}