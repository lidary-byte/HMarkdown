/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description:
 */
import { MarkdownTheme } from './MarkdownTheme'


export interface IMarkConfig {
  lineSpace?: string | number
  textLineSpace?: LengthMetrics
  theme?: MarkdownTheme
}