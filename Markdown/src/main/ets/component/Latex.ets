/**
 * @Author : lidary
 * @CreateData : 2025/11/12
 * @Description:
 */
import { image } from '@kit.ImageKit';
import { MarkdownTheme, Tokens } from '../../../../Index';
import { latexToPixelMap } from '../utils';

@ComponentV2
export struct Latex {
  @Param @Require token: Tokens.Generic
  @Param @Require theme: MarkdownTheme
  @Local pixelMap: image.PixelMap = undefined!;
  @Local imageWidth: number = 0;
  @Local imageHeight: number = 0;

  async aboutToAppear(): Promise<void> {
    this.watchToken()
  }

  @Monitor('theme')
  watchTheme(){
    this.watchToken()
  }

  @Monitor('token')
  watchToken() {
    latexToPixelMap(this.token.text, this.getUIContext().fp2px(this.theme.latex?.fontSize),
      this.theme.latex?.fontColor ?? 0xffffffff, this.theme.latex?.backgroundColor ?? 0xffffffff)
      .then((data) => {
        if (data) {
          this.pixelMap = data.pixelMap
          this.imageWidth = this.getUIContext().px2vp(data.width)
          this.imageHeight = this.getUIContext().px2vp(data.height)
        }

      })
  }

  build() {
    Row() {
      Image(this.pixelMap)
        .objectFit(ImageFit.Contain)
        .width(this.imageWidth)
        .height(this.imageHeight)
    }.width('100%')
    .justifyContent(FlexAlign.Center)
  }
}