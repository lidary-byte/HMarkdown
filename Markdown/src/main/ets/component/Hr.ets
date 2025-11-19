import { MarkdownOptionsClass } from '../Index'

@ComponentV2
export struct Hr {
  @Param @Require options: MarkdownOptionsClass
  build() {
    Divider()
      .strokeWidth(this.options.theme.hrStyle?.driveWidth)
      .height(this.options.theme.hrStyle?.driveWidth)
  }
}