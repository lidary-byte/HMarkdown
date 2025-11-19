import { Markdown } from '@lidary/markdown';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { util } from '@kit.ArkTS';
import { promptAction } from '@kit.ArkUI';

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
    Stack() {
      Column() {
        Row() {
          Button(this.isDark ? '亮色主题' : '暗色主题').onClick(() => {
            this.isDark = !this.isDark
          })
          Button('文本内容切换').onClick(() => {
            if (this.text === '> 1. 第一项\n' +
              '> 2. 第二项\n' +
              '> 3. 第三项') {
              this.readFile(getContext(this) as common.UIAbilityContext)
            } else {
              this.text =
                '> 1. 第一项\n' +
                  '> 2. 第二项\n' +
                  '> 3. 第三项'
            }
          })
        }

        Markdown({
          content: this.text,
          options: {
            darkMode: this.isDark,
            options: {
              gfm: true
            },
            darkTheme: {
              themeColor: Color.Orange
            },
            imageClick: (url?: string) => {
              promptAction.showToast({
                message: `图片被点击:${url}`,
                duration: 1500,
                bottom: "center",
              })
            },
            linkClick: (url?: string) => {
              promptAction.showToast({
                message: `超链接被点击----url:${url}`,
                duration: 1500,
                bottom: "center",
              })
            }
          }

        }).onClick(() => {
          console.error('---------点击拦截')
        })
        // .padding(16)
          .layoutWeight(1)

      }.backgroundColor(this.isDark ? Color.Black : Color.White)

      // LoadingProgress()
      //   .size({ width: 40, height: 40 })
    }.width('100%')
  }
}

class TextAttr implements AttributeModifier<TextAttribute> {
  applyNormalAttribute(instance: TextAttribute): void {
    instance.copyOption(CopyOptions.InApp)
  }
}