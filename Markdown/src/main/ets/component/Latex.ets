/**
 * @Author : lidary
 * @CreateData : 2025/11/12
 * @Description:
 */
import { image } from '@kit.ImageKit';
import { MarkdownTheme, Tokens } from '../../../../Index';
import { MarkdownOptions } from '../Index';
import { getTheme, latexToPixelMap } from '../utils';

@ComponentV2
export struct Latex {
  @Param @Require token: Tokens.Generic
  @Param @Require options: MarkdownOptions
  @Local pixelMap: image.PixelMap = undefined!;
  @Local imageWidth: number = 0;
  @Local imageHeight: number = 0;

  aboutToAppear() {
    this.watchToken()
  }

  @Monitor('options.theme')
  watchTheme() {
    this.watchToken()
  }

  @Monitor('token')
  watchToken() {
    latexToPixelMap(this.token.text, this.getUIContext().fp2px(getTheme(this.options).latexStyle?.fontSize),
      getTheme(this.options).latexStyle?.fontColor ?? 0xffffffff, getTheme(this.options).latexStyle?.backgroundColor ?? 0xffffffff)
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