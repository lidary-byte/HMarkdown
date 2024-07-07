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

export  const codeHighlight: Record<string, ResourceColor | undefined> = {
  'string': undefined,
  'text': undefined,
  'keyword': undefined,
  'type': undefined,
  'symbol': undefined,

  'number': '#ffecd9ac',
  'boolean': '#ff3c1dc3',
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
    if (!codeHighlight['text']) {
      codeHighlight['text'] = MarkConfig.markTheme.defaultFont?.fontColor
    }
    if (!codeHighlight['string']) {
      codeHighlight['string'] = '#653170'
    }
    if (!codeHighlight['symbol']) {
      codeHighlight['symbol'] = MarkConfig.markTheme.defaultFont?.fontColor
    }

    if (!codeHighlight['keyword']) {
      codeHighlight['keyword'] = MarkConfig.markTheme.themeColor
    }
    if (!codeHighlight['type']) {
      codeHighlight['type'] = MarkConfig.markTheme.themeColor
    }
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