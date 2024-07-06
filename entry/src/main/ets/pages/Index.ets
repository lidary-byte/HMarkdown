import { Markdown } from '@lidar/markdown';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { util } from '@kit.ArkTS';
import { data } from '../content';

@Entry
@Component
struct Index {
  @State text: string = ''

  aboutToAppear(): void {
    this.readFile(getContext(this) as common.UIAbilityContext)
  }

  readFile(context: common.UIAbilityContext) {
    // this.text = data
    try {
      context.resourceManager.getRawFileContent("mark_test_1.md", (error: BusinessError, value: Uint8Array) => {
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

      Scroll() {
        Markdown({
          content: this.text,
        })
      }
      .layoutWeight(1)
      .width('100%')
    }
  }
}