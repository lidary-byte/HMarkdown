import { MarkdownTheme } from '../config/MarkdownTheme'

@ComponentV2
export struct Hr {
  @Param @Require theme: MarkdownTheme
  build() {
    Divider()
      .strokeWidth(this.theme.hr?.strokeWidth)
  }
}