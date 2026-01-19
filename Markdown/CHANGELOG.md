# 更新日志

## v3.0.5 [#38](https://github.com/lidary-byte/HMarkdown/issues/38)
1. 沉浸式案例、组件增加contentStartOffset、contentEndOffset、paddings、scrollBar、nestedScroll、cachedCount、cachedShow等属性
2. 优化代码块copy图标显示,增加自定义copy图标、copy图标颜色

## v3.0.4 [#34](https://github.com/lidary-byte/HMarkdown/issues/34)
对外暴露[latexResPath](https://ohpm.openharmony.cn/#/cn/detail/@cangjie-tpc%2Fformula_hybrid:~:text=resPath%E9%BB%98%E8%AE%A4%E5%8F%82%E6%95%B0%22/data/storage/el1/bundle/entry/resources/resfile/res%22%EF%BC%8C%E5%A6%82%E6%9E%9C%E4%BF%AE%E6%94%B9entry%E5%91%BD%E5%90%8D%EF%BC%8C%E9%9C%80%E8%A6%81%E6%94%B9%E6%88%90%E5%AF%B9%E5%BA%94%E7%9A%84%22/data/storage/el1/bundle/xxxx/resources/resfile/res%22%E3%80%82) 

## v3.0.3
1.修复options参数为空时程序崩溃bug [#32](https://github.com/lidary-byte/HMarkdown/issues/32#issuecomment-3620309424)

## v3.0.2
1. 修复数据首次传入未加载bug  [#32](https://github.com/lidary-byte/HMarkdown/issues/32)

## v3.0.1
1. 优化公式解析规则
2. 新增行间html解析，渲染

## v3.0.0
1. tokens解析放入子线程,性能更佳
2. 支持公式本地解析

## v2.0.8
优化 [#31](https://github.com/lidary-byte/HMarkdown/issues/31):  
1. 数据解析改为子线程实现
2. UI渲染改为List + Repeat实现

## v2.0.7
fix: 修复 Heading 组件 fontWeight 属性无效问题 

## v2.0.6
fix: 修复列表样式同一标题可能会出现多次的bug [#24](https://github.com/lidary-byte/HMarkdown/issues/24)

## v2.0.5
1. 对外暴露```markConfig.apply(options: MarkedOptions)``` 方法自定义options
2. 对外暴露```/core/marked.ts```文件以支持完全自定义

## v2.0.4

fix: 修复v1版本内容为超链接且样式为加粗时渲染异常bug [#19](https://github.com/lidary-byte/HMarkdown/issues/19)

fix: 修复有序列表超过10个，序号显示异常bug [#20](https://github.com/lidary-byte/HMarkdown/issues/20)

## v2.0.3

fix: 修复内容为超链接且样式为加粗时渲染异常bug [#19](https://github.com/lidary-byte/HMarkdown/issues/19)

## v2.0.2

fix: 修复v2版本内容可能无法正常显示bug [#16](https://github.com/lidary-byte/HMarkdown/issues/16)

## v2.0.1

fix: 修复主题无法合并的bug

## v2.0.0

适配v2状态管理

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

