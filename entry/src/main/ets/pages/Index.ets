import { IMarkConfig, Markdown } from '@lidary/markdown';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { util } from '@kit.ArkTS';

@Entry
@Component
struct Index {
  @State text: string = ''
  @State @Watch('changeTheme') isDark: boolean = false
  @State markConfig?: IMarkConfig = undefined

  aboutToAppear(): void {
    this.changeTheme()
    this.readFile(getContext(this) as common.UIAbilityContext)
  }

  changeTheme() {
    this.markConfig = this.isDark ? {
      theme: {
        themeColor: Color.Orange,
        defaultFont: {
          fontColor: Color.White
        },
        link: {
          fontColor: Color.Orange
        },
        h1: {
          fontColor: Color.White
        },
        h2: {
          fontColor: Color.White
        },
        h3: {
          fontColor: Color.White
        },
        h4: {
          fontColor: Color.White
        }
      }
    } : {
      theme: {
        themeColor: Color.Green,
        defaultFont: {
          fontColor: Color.Black
        },
        link: {
          fontColor: Color.Green
        },
        h1: {
          fontColor: Color.Black
        },
        h2: {
          fontColor: Color.Black
        },
        h3: {
          fontColor: Color.Black
        },
        h4: {
          fontColor: Color.Black
        }
      }
    }
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
      Button(this.isDark ? '亮色主题' : '暗色主题').onClick(() => {
        this.isDark = !this.isDark
      })
      Scroll() {
        Markdown({
          content: this.text,
          markConfig: this.markConfig
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