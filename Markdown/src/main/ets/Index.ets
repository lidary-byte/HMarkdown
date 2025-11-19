/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description:
 */
import { defaultTheme } from './config/DefaultTheme';
import { MarkdownTheme } from './config/MarkdownTheme';
import { MarkedOptions, Token, TokenizerExtension } from './core';
import { LengthMetrics } from '@kit.ArkUI';
import { InlineParams } from './core/parseInlineToken';

export type OnClick = (url?: string) => void

export interface MarkdownOptions {
  theme?: MarkdownTheme
  darkTheme?: MarkdownTheme
  lineSpace?: number | string
  inlineLineSpace?: LengthMetrics
  darkMode?: boolean,
  options?: MarkedOptions,
  extensions?: TokenizerExtension[]
  imageClick?: OnClick,
  linkClick?: OnClick,
  customBlockBuilder?: WrappedBuilder<[Token, MarkdownOptionsClass]>
  customInlineBuilder?: (tokenItem: Token, params: InlineParams) => void
  //inline元素中 需要显示的最大行数
  maxLines?: number
}


@ObservedV2
export class MarkdownOptionsClass {
  @Trace
  theme: MarkdownTheme
  @Trace
  lineSpacing?: number | string
  @Trace
  inlineLineSpacing?: LengthMetrics
  maxLines?: number

  constructor(theme?: MarkdownTheme) {
    this.theme = theme ?? defaultTheme
  }
}




export namespace markdown {

  export let registerImageClick: OnClick | undefined = undefined

  export let registerLinkClick: OnClick | undefined = undefined

  // 自定义的block渲染
  export let customBlockBuilder: WrappedBuilder<[Token, MarkdownOptionsClass]> | undefined = undefined

  // 自定义的inline渲染
  export let customInlineBuilder: ((tokenItem: Token, params: InlineParams) => void) | undefined = undefined


}


