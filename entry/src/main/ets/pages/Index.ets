import { IMarkConfig, Markdown } from '@lidar/markdown';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { util } from '@kit.ArkTS';

@Entry
@Component
struct Index {
  @State text: string = ''
  @State markConfig: IMarkConfig = {
    theme: {
      themeColor: Color.Green,
      link: {
        fontColor: Color.Green
      }
    }
  }

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
      Button('更改主题').onClick(() => {
        this.markConfig = {
          theme: {
            themeColor: Color.Orange,
            link: {
              fontColor: Color.Orange
            }
          }
        }
      })
      Scroll() {
        Markdown({
          content: this.text,
          markConfig: this.markConfig
        })//.height('100%')
          .padding(16)
      }
      .layoutWeight(1)
      .width('100%')
    }
  }
}