/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description:
 */
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
  customBlockBuilder?: WrappedBuilder<[Token, MarkdownOptions]>
  customInlineBuilder?: (tokenItem: Token, params: InlineParams) => void
  //inline元素中 需要显示的最大行数
  maxLines?: number
}

