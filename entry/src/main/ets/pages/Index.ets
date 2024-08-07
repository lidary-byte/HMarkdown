import { Markdown, MarkdownLite } from '@lidary/markdown';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { util } from '@kit.ArkTS';

@Entry
@Component
struct Index {
  @State text: string = ''
  @State isDark: boolean = false

  aboutToAppear(): void {
    this.readFile(getContext(this) as common.UIAbilityContext)
  }

  readFile(context: common.UIAbilityContext) {
    try {
      context.resourceManager.getRawFileContent("mark_test.md", (error: BusinessError, value: Uint8Array) => {
        if (error != null) {
          console.error("error is " + error);
        } else {
          let rawFile = value;
          this.text = util.TextDecoder.create().decodeWithStream(value)
          console.info('result:' + this.text)
        }
      });
    } catch (error) {
      let code = (error as BusinessError).code;
      let message = (error as BusinessError).message;
      console.error(`callback getRawFileContent failed, error code: ${code}, message: ${message}.`);
    }
  }

  build() {
    Column() {
      Row() {
        Button(this.isDark ? '亮色主题' : '暗色主题').onClick(() => {
          this.isDark = !this.isDark
        })
        Button('文本内容切换').onClick(() => {
          if (this.text === '切换后的文本') {
            this.readFile(getContext(this) as common.UIAbilityContext)
          } else {
            this.text = '切换后的文本'
          }
        })
      }

      Scroll() {
        MarkdownLite({
          content: this.text,
          maxLine: 4,
          lineSpace: 6,
          theme: {
            themeColor: Color.Orange,
            link: {
              fontColor: Color.Orange
            }
          },
          fontStyle: {
            fontColor: this.isDark ? Color.White : Color.Black
          }
        }).onClick(() => {
          console.error('---------点击拦截')
        })
          .padding(16)
      }
      .layoutWeight(1)
      .width('100%')
    }.backgroundColor(this.isDark ? Color.Black : Color.White)
  }
}