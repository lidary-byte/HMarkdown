import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { promptAction, window } from '@kit.ArkUI';
import { markConfig, Tokens } from '@lidary/markdown';
import { latexBlock, latexInline } from '../Plugin';

@Builder
function BlockBuilder(type: string, token: Tokens.Generic, that: ESObject) {
  if (type === 'blockKatex') {
    // 可以将token.text交给后台生成svg处理
    Row() {
      Image($r('app.media.latex_test'))
        .fillColor(that.fontStyle?.fontColor)
        .height(40)
    }.width('100%')
    .justifyContent(FlexAlign.Center)
  }
}

@Builder
function InlineBuilder(type: string, token: Tokens.Generic, that: ESObject) {
  if (type === 'inlineKatex') {
    // 可以将token.text交给后台生成svg处理
    ImageSpan($r('app.media.latex_test'))
      .height(40)
      .verticalAlign(ImageSpanAlignment.CENTER)
  }
}

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    markConfig.setTheme({
      themeColor: Color.Red,
      link: {
        fontColor: Color.Red
      }
    })
    markConfig.addPlugin([latexBlock(), latexInline()])
    markConfig.registerImageClick = (url?: string) => {
      promptAction.showToast({
        message: `图片被点击:${url}`,
        duration: 1500,
        bottom: "center",
      })
    }

    markConfig.registerLinkClick = (url?: string) => {
      promptAction.showToast({
        message: `超链接被点击----url:${url}`,
        duration: 1500,
        bottom: "center",
      })
    }
    markConfig.customBlockBuilder = wrapBuilder(BlockBuilder)
    markConfig.customInlineBuilder = wrapBuilder(InlineBuilder)
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

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
}
