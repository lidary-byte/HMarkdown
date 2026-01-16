import { Markdown } from '@lidary/markdown';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { util } from '@kit.ArkTS';
import { promptAction } from '@kit.ArkUI';
import { AppUtils } from "@tangs/apputils"
import EntryAbility from '../entryability/EntryAbility';

@Entry
@Component
struct Index {
  @State text: string = ''
  @State isDark: boolean = false
  @State isLoading: boolean = true

  aboutToAppear(): void {
    this.readFile(getContext(this) as common.UIAbilityContext)

    EntryAbility.install.configurationUpdateListener = (config) => {
      this.isDark = config.colorMode == 0
    }
  }

  readFile(context: common.UIAbilityContext) {
    try {
      context.resourceManager.getRawFileContent("mark_test.md", (error: BusinessError, value: Uint8Array) => {
        if (error != null) {
          console.error("error is " + error);
        } else {
          this.text = util.TextDecoder.create().decodeWithStream(value)
        }
      });
    } catch (_) {
    }
  }

  build() {
    Stack() {
      Scroll() {
        Column() {
          Row() {
            Button(this.isDark ? '亮色主题' : '暗色主题').onClick(() => {
              this.isDark = !this.isDark
            })
            Button('文本内容切换').onClick(() => {
              this.isLoading = true
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
          .margin({top: AppUtils.WindowUtil.getTopHeight()})

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
            },
            onLoading: () => {
              this.isLoading = true
            },
            onError: () => {
              this.isLoading = false
            },
            onSuccess: () => {
              this.isLoading = false
            },
            contentStartOffset: AppUtils.WindowUtil.getBottomHeight(),
            contentEndOffset: AppUtils.WindowUtil.getBottomHeight(),
            paddings: {left: 16, right: 16},
            scrollBar: BarState.Off,
            nestedScroll: {
              scrollForward: NestedScrollMode.PARENT_FIRST,
              scrollBackward: NestedScrollMode.SELF_FIRST
            },
            cachedCount: 3,
            cachedShow: true
          }).height("100%")
        }.backgroundColor(this.isDark ? Color.Black : Color.White)
        .width('100%')
      }.width('100%')
      .height("100%")
      .scrollBar(BarState.Off)
      if (this.isLoading) {
        LoadingProgress()
          .size({ width: 40, height: 40 })
      }
    }.width('100%')
  }
}

class TextAttr implements AttributeModifier<TextAttribute> {
  applyNormalAttribute(instance: TextAttribute): void {
    instance.copyOption(CopyOptions.InApp)
  }
}