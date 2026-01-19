import { AbilityConstant, Configuration, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { AppUtils } from "@tangs/apputils"

// @Builder
// function BlockBuilder(type: string, token: Tokens.Generic, that: ESObject) {
//   if (type === 'blockKatex') {
//     // 可以将token.text交给后台生成svg处理
//     Row() {
//       Image($r('app.media.latex_test'))
//         .fillColor(that.fontStyle?.fontColor)
//         .height(40)
//     }.width('100%')
//     .justifyContent(FlexAlign.Center)
//   }
// }
//
// @Builder
// function InlineBuilder(type: string, token: Tokens.Generic, that: ESObject) {
//   if (type === 'inlineKatex') {
//     // 可以将token.text交给后台生成svg处理
//     ImageSpan(that.fontStyle?.fontColor === '#ffffffff' ? $r('app.media.latex_test2') : $r('app.media.latex_test1'))
//       .height(40)
//       .verticalAlign(ImageSpanAlignment.CENTER)
//   }
// }

export default class EntryAbility extends UIAbility {
  static install: EntryAbility

  configurationUpdateListener: ((config: Configuration) => void) | undefined = undefined;

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    EntryAbility.install = this;
    // markdown.init({
    //   // theme: {
    //   //   themeColor: Color.Red,
    //   //   link: {
    //   //     fontColor: Color.Red
    //   //   }
    //   // },
    //   options: {
    //     gfm: true
    //   },
    //   extensions: [latexBlock(), latexInline()],
    //   enableLatex: true,
    //   imageClick: (url?: string) => {
    //     promptAction.showToast({
    //       message: `图片被点击:${url}`,
    //       duration: 1500,
    //       bottom: "center",
    //     })
    //   },
    //   linkClick: (url?: string) => {
    //     promptAction.showToast({
    //       message: `超链接被点击----url:${url}`,
    //       duration: 1500,
    //       bottom: "center",
    //     })
    //   }
    // })


    // markConfig.customBlockBuilder = wrapBuilder(BlockBuilder)
    // markConfig.customInlineBuilder = wrapBuilder(InlineBuilder)
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    AppUtils.WindowUtil.getInstance().init(windowStage);
    // 开启沉浸式
    AppUtils.WindowUtil.getInstance().setImmerseBar({
      statusBarContentColor: this.context.config.colorMode == 0 ? "#FFFFFFFF" : "#FF000000",
    });

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }

  onConfigurationUpdate(newConfig: Configuration): void {
    AppUtils.WindowUtil.setStatusBarBgColor({
      statusBarContentColor: newConfig.colorMode == 0 ? "#FFFFFFFF" : "#FF000000",
    })

    if (this.configurationUpdateListener != undefined) {
      this.configurationUpdateListener(newConfig)
    }
  }
}
