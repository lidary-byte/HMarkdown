import { MarkdownOptions } from '../Index'
import { getTheme } from '../utils'

@ComponentV2
export struct Hr {
  @Param @Require options: MarkdownOptions
  build() {
    Divider()
      .strokeWidth(getTheme(this.options).hrStyle?.driveWidth)
      .height(getTheme(this.options).hrStyle?.driveWidth)
  }
}