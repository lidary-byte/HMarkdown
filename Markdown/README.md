# HMarkdown

基于[**marked**](https://github.com/markedjs/marked)的鸿蒙端markdown渲染库

![截图](https://github.com/lidary-byte/HMarkdown/blob/main/screen/image2.gif)

部分特性:

1. 支持主题的动态修改
2. 支持通过插件自定义解析及渲染(**demo内实现了数学公式的插件逻辑**)
3. ~~依赖[**HmdConv**](https://ohpm.openharmony.cn/#/cn/detail/@rv%2Fhmd-conv)以支持html解析~~
---

## 参数

|      名称       | 是否必传 | 默认值                       |           说明            |
|:-------------:|:----:|---------------------------|:-----------------------:|
|    content    |  是   |                           |      markdown文本内容       |
|     theme     |  否   | defaultTheme(参考github的ui) |       主题，颜色等相关配置        | 
|   fontStyle   |  否   | MarkdownFontStyle         |          字体样式           | 
|   lineSpace   |  否   | 0                         |        item之间的间距        | 
| textLineSpace |  否   | 0                         |      item中text的行间距      |
| mdInlineModifier     |  否   | undefined                       | Inline的样式(比如可以自定义长按事件等) |

### MarkdownFontStyle参数

|      名称       | 是否必传 | 默认值        |  说明  |
|:-------------:|:----:|------------|:----:|
|   fontColor   |  否   | Color.Black | 字体颜色 |
|   fontSize    |  否   | 16         | 字体大小 | 
|   fontWeight   |  否   |    FontWeight.Normal        |  字重  | 


---

## 下载安装

```
ohpm install @lidary/markdown
```

---

## 导包

```typescript
import { Markdown } from '@lidary/markdown';
```

---

## 使用方式

### 全局配置

```typescript
// 设置全局theme 会覆盖掉内部自带的theme
markConfig.setTheme({
  themeColor: Color.Red,
  link: {
    fontColor: Color.Red
  }
})
// 设置image的点击事件
markConfig.registerImageClick = (url?: string) => {
  promptAction.showToast({
    message: `图片被点击:${url}`,
    duration: 1500,
    bottom: "center",
  })
}
// 设置link的点击事件
markConfig.registerLinkClick = (url?: string) => {
  promptAction.showToast({
    message: `超链接被点击----url:${url}`,
    duration: 1500,
    bottom: "center",
  })
}
```

### 组件中

```typescript
Markdown({
  content: this.markdownContent,
  lineSpace: 6,
  // 覆盖掉通过markConfig.setTheme设置的全局theme(优先级最高)
  theme: {
    themeColor: Color.Orange,
    link: {
      fontColor: Color.Orange
    }
  },
  fontStyle: {
    fontColor: this.isDark ? Color.White : Color.Black
  }
}).backgroundColor(this.isDark ? Color.Black : Color.White)
```

> #### 关于配置的优先级又高到低分别是:
>
> 1.通过Markdown组件传入**theme**
>
>  2.调用markConfig.setTheme
>
>  3.HMarkdown内自带的默认theme

---

### 插件相关

1. 添加插件

```typescript
// 添加数学公式解析 (具体的可查看demo)
markConfig.addPlugin([latexBlock(), latexInline()])
```

2. 添加自定义渲染(对自定义解析规则进行渲染)

```typescript
// 可通过that.fontStyle , that.theme ,that.lineSpace获取字体颜色,间距等属性
@Builder
function BlockBuilder(type: string, token: Tokens.Generic, that: ESObject) {
  if (type === 'blockKatex') {
    // 可以将token.text交给后台生成svg处理
    Row()
    {
      Image($r('app.media.latex_test'))
        .fillColor(that.fontStyle?.fontColor)
        .height(40)
    }
    .
    width('100%')
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

markConfig.customBlockBuilder = wrapBuilder(BlockBuilder)
markConfig.customInlineBuilder = wrapBuilder(InlineBuilder)
```

## 开源协议

本项目基于 [MIT License](https://gitee.com/daryl_code/HMarkdown/blob/main/Markdown/LICENSE) ，请自由地享受和参与开源