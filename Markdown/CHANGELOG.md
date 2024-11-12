# 更新日志

## v1.0.16
fix: 修复MarkdownLite崩溃bug

## v1.0.15
对外暴露Inline的AttributeModifier(```mdInlineModifier```)属性来实现自定义样式

## v1.0.14
1. 修复列表解析可能会崩溃的bug
2. 修复未定义customBuilder时崩溃的bug

## v1.0.13
1. enable useNormalizedOHMUrl
2. 移除对html的解析

## v1.0.12
fix: 修复```~~```装饰的文字删除效果未解析bug

## v1.0.11 
1. tokenList支持外部传递  [#6](https://github.com/lidary-byte/HMarkdown/issues/6)

## v1.0.10 [#5](https://github.com/lidary-byte/HMarkdown/issues/5)
1. 无序列表，有序列表优化

## v1.0.9
1. 修复图片可能超过最大宽度bug
2. 图片渲染优化

## v1.0.8
修复插件可能加载失败的bug

## v1.0.7  [#4](https://github.com/lidary-byte/HMarkdown/issues/4)
1. 修复有序列表被渲染成无序列表bug 
2. 修复列表中文字溢出bug

## v1.0.6
1. 更改无序列表对其方式 [#2](https://github.com/lidary-byte/HMarkdown/issues/2)
2. 对实体字符进行清理 [#3](https://github.com/lidary-byte/HMarkdown/issues/3)


## v1.0.5
1. 修复纯文本不显示bug
2. 修复内容无法动态更新bug [#1](https://github.com/lidary-byte/HMarkdown/issues/1)

## v1.0.4
1. 支持html解析
2. 文档优化

## v1.0.3
Image渲染宽高改为图片宽高

## v1.0.2
1.Table滚动优化(现在可以整体横向滚动了)

## v1.0.1
1. 修复theme,fontStyle等属性无法动态更新bug
2. 修复Markdown的点击事件被内部子组件拦截bug
3. 修复标题含有斜体样式时未被正确渲染的bug
4. 自定义组件暴露that参数
5. 优化传参方式

---
## v1.0.0

基本解析，渲染功能实现

