# HMarkdown

基于[**marked**](https://github.com/markedjs/marked)的鸿蒙端markdown渲染库

![截图](https://github.com/lidary-byte/HMarkdown/blob/main/screen/img.png)

部分特性:

1. 支持主题的动态修改
2. 支持通过插件自定义解析及渲染(**demo内实现了数学公式的插件逻辑**)

## 参数

|     名称     | 是否必传 |       说明       |
|:----------:|:----:|:--------------:|
|  content   |  是   |  markdown文本内容  |
| markConfig |  否   | HMarkdown的相关配置 | 

## MarkConfig 属性说明

| 名称            | 是否必传 | 说明              |
|---------------|:----:|-----------------|
| lineSpace     |  否   | 每个item之间的间距     |
| textLineSpace |  否   | Text中每一行的间距     |
| theme         |  否   | 主题，字体颜色，大小等相关配置 |

## 使用方式

```typescript
import { Markdown } from '@lidary/markdown';

Markdown({
  content: this.markdownContent,
  markConfig: this.markConfig
})
```

## 相关配置(具体可参考demo，可在Ability中设置)

1. 主题等相关配置的全局设置

```typescript
 markConfig.initConfig({
  lineSpace: 4,
  textLineSpace: new LengthMetrics(4),
  theme: {
    themeColor: Color.Red,
    link: {
      fontColor: Color.Red
    }
  }
})
```
> ### 关于配置的优先级又高到低分别是: 
> #####  1.通过Markdown组件传入**config**设置 
> #####  2.调用markConfig.initConfig设置
> #####  3.HMarkdown内自带的默认config
 

2. 超链接点击回调:

```typescript
 markConfig.registerLinkClick = (url: string, text: string) => {
  promptAction.showToast({
    message: `[${text}]的超链接被点击----url:${url}`,
    duration: 1500,
    bottom: "center",
  })
}
```

3. Image点击回调:

```typescript
markConfig.registerImageClick = (url: string) => {
  promptAction.showToast({
    message: `图片被点击:${url}`,
    duration: 1500,
    bottom: "center",
  })
}
```

### 插件相关

1. 添加插件
```typescript
// 添加数学公式解析 (具体的可查看demo)
markConfig.addPlugin([latexBlock(), latexInline()])
```
2. 添加自定义渲染(对自定义解析规则进行渲染)
```typescript
// 自定义block的渲染
@Builder
function BlockBuilder(type: string, token: Token) {
  if (type === 'blockKatex') {
    // 可以将token.text交给后台生成svg处理
    Row(){
      Image($r('app.media.latex_test'))
        .height(40)
    }
    .width('100%')
      .justifyContent(FlexAlign.Center)
  }
}
// 自定义inline的渲染 
// inline内部尽可能采用Span实现
@Builder
function InlineBuilder(type: string, token: Token) {
  if (type === 'inlineKatex') {
    // 可以将token.text交给后台生成svg处理
    ImageSpan($r('app.media.latex_test'))
      .height(40)
      .verticalAlign(ImageSpanAlignment.CENTER)
  }
}

markConfig.customBlockBuilder = wrapBuilder(BlockBuilder)
markConfig.customInlineBuilder = wrapBuilder(InlineBuilder)
```
