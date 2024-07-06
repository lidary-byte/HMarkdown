/**
 * @Author : lcc
 * @CreateData : 2024/7/5
 * @Description:
 */

export interface MarkdownTheme {
  themeColor?: ResourceColor
  backgroundColor?: ResourceColor
  defaultFont?: MarkdownFontStyle
  blockQuote?: BlockQuoteTheme
  h1?: HeadingTheme
  h2?: HeadingTheme
  h3?: HeadingTheme
  h4?: HeadingTheme
  h5?: HeadingTheme
  h6?: HeadingTheme
  image?: ImageTheme
  link?: LinkTheme
  codeSpan?: CodeSpan
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
  fontSize?: Length
}

export interface BlockQuoteTheme {
  backgroundColor?: ResourceColor;
  borderRadius?: Length,
  driveColor?: ResourceColor;
  driveWidth?: string | number
}

export interface HeadingTheme extends MarkdownFontStyle {}