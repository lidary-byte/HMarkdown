/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description:
 */

export interface MarkdownTheme {
  // 每个item之间的间距
  lineSpacing?: number | string
  inlineLineSpacing ?: LengthMetrics
  themeColor?: ResourceColor
  blockQuote?: BlockQuoteTheme
  heading?: MarkdownFontStyle[],
  paragraph?: MarkdownFontStyle,
  defaultFontStyle?: MarkdownFontStyle,
  list?: ListStyle,
  image?: ImageTheme
  link?: LinkTheme,
  hr?: HrStyle,
  codeSpan?: CodeSpan,
  code?: CodeStyle,
  latex?: LatexStyle,
  html?: MarkdownFontStyle
}


export interface CodeSpan {
  backgroundColor?: ResourceColor,
  borderRadius?: Dimension | BorderRadiuses,
}

export interface LinkTheme {
  fontColor?: ResourceColor
}

export interface ImageTheme {
  width?: Length
  height?: Length
  objectFit?: ImageFit
}

export interface MarkdownFontStyle {
  fontColor?: ResourceColor
  fontWeight?: FontWeight
  fontSize?: Length,
  lineSpacing?: LengthMetrics
}

export interface BlockQuoteTheme {
  backgroundColor?: ResourceColor;
  borderRadius?: Length,
  driveColor?: ResourceColor;
  driveWidth?: string | number,
  lineSpacing?: LengthMetrics
}


export interface HrStyle {
  strokeWidth: number | string
}

export interface ListStyle {
  fontStyle?: MarkdownFontStyle,
  marginLeft?: Length
}

export interface CodeStyle {
  fontColor?: Record<CodeHighLight, ResourceColor | undefined>,
  fontWeight?: FontWeight
  fontSize?: Length,
  backgroundColor?: ResourceColor,
  borderRadius: Length | BorderRadiuses | LocalizedBorderRadiuses,
  codeSpanFontSize?: LengthMetrics,
  codeSpanBorderRadius ?: Dimension | BorderRadiuses,
  codeSpanBackgroundColor?: ResourceColor,
}

export interface LatexStyle {
  fontSize?: number,
  fontColor?: number,
  backgroundColor?: number
}

type CodeHighLight = 'string' | 'text' | 'keyword' | 'type' | 'symbol' | 'number' | 'boolean'