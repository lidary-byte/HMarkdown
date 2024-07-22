# HMarkdown

基于鸿蒙的markdown渲染库

# 公式测试

这是行间公式:

$$
\frac{2}{5}\frac{2}{5}
$$

这是行内公式: $\frac{2}{5}$

## 主要内容

> #### Markdown*是什么*？
> #### *谁*创造了它？
> #### *为什么*要使用它？
> #### *怎么*使用？
> #### *谁*在用？
> #### 尝试一下

## 正文

### 1. Markdown*是什么*？

**Markdown**是一种轻量级**标记语言**，它以纯文本形式(*易读、易写、易更改*)编写文档，并最终以HTML格式发布。    
**Markdown**也可以理解为将以MARKDOWN语法编写的语言转换成HTML内容的工具。

### 2. *谁*创造了它？

它由[**Aaron Swartz**](http://www.aaronsw.com/)和**John Gruber**共同设计，**Aaron Swartz**就是那位于去年（*2013年1月11日*
）自杀,有着**开挂**
一般人生经历的程序员。维基百科对他的[介绍](http://zh.wikipedia.org/wiki/%E4%BA%9A%E4%BC%A6%C2%B7%E6%96%AF%E6%B2%83%E8%8C%A8)
是：**软件工程师、作家、政治组织者、互联网活动家、维基百科人**。

他有着足以让你跪拜的人生经历：

+ **14岁**参与RSS 1.0规格标准的制订。
+ **2004**年入读**斯坦福**，之后退学。
+ **2005**年创建[Infogami](http://infogami.org/)，之后与[Reddit](http://www.reddit.com/)合并成为其合伙人。
+ **2010**年创立求进会（Demand Progress），积极参与禁止网络盗版法案（SOPA）活动，最终该提案被撤回。
+ **2011**年7月19日，因被控从MIT和JSTOR下载480万篇学术论文并以免费形式上传于网络被捕。
+ **2013**年1月自杀身亡。

![Aaron Swartz](https://img1.baidu.com/it/u=687905698,132062380&fm=253&app=120&size=w931&n=0&f=JPEG&fmt=auto?sec=1720890000&t=6b1c14b6a1896a3570ce4ac007d9ce17)

天才都有早逝的归途。

### 3. *为什么*要使用它？

+ 它是易读（看起来舒服）、易写（语法简单）、易更改**纯文本**。处处体现着**极简主义**的影子。
+ 兼容HTML，可以转换为HTML格式发布。
+ 跨平台使用。
+ 越来越多的网站支持Markdown。
+ 更方便清晰地组织你的电子邮件。（Markdown-here, Airmail）
+ 摆脱Word（我不是认真的）。

### 4. *怎么*使用？

如果不算**扩展**，Markdown的语法绝对**简单**到让你爱不释手。

Markdown语法主要分为如下几大部分：
**标题**，**段落**，**区块引用**，**代码区块**，**强调**，**列表**，**分割线**，**链接**，**图片**，**反斜杠 `\`**，**符号'`'**。

#### 4.1 标题

两种形式：  
1）使用`=`和`-`标记一级和二级标题。
> 一级标题   
> `=========`   
> 二级标题    
> `---------`

效果：
> 一级标题
> =========   
> 二级标题
> ---------  

2）使用`#`，可表示1-6级标题。
> \# 一级标题   
> \## 二级标题   
> \### 三级标题   
> \#### 四级标题   
> \##### 五级标题   
> \###### 六级标题

效果：
> # 一级标题
> ## 二级标题
> ### 三级标题
> #### 四级标题
> ##### 五级标题
> ###### 六级标题

#### 4.2 段落

段落的前后要有空行，所谓的空行是指没有文字内容。若想在段内强制换行的方式是使用**两个以上**空格加上回车（引用中换行省略回车）。

#### 4.3 区块引用

在段落的每行或者只在第一行使用符号`>`,还可使用多个嵌套引用，如：
> \> 区块引用  
> \>> 嵌套引用

效果：
> 区块引用
>> 嵌套引用

#### 4.4 代码区块

代码区块的建立是在每行加上4个空格或者一个制表符（如同写代码一样）。如    
普通段落：

public static void main(){
System.out.println("hello world");
}

代码区块：

```java
 public static boolean main() {
    System.out.println("hello world");
}
```

```typescript
function main(): number {
  const a : boolean = false;
  const b : number = 1;
  println('hello wolrd')
}
```

**注意**:需要和普通段落之间存在空行。

#### 4.5 强调

在强调内容两侧分别加上`*`或者`_`，如：
> \*斜体\*，\_斜体\_    
> \*\*粗体\*\*，\_\_粗体\_\_

效果：
> *斜体*，_斜体_    
> **粗体**，__粗体__

#### 4.6 列表

使用`·`、`+`、或`-`标记无序列表，如：
> \-（+\*） 第一项
> \-（+\*） 第二项
> \- （+\*）第三项

**注意**：标记后面最少有一个_空格_或_制表符_。若不在引用区块中，必须和前方段落之间存在空行。

效果：
> + 第一项
> + 第二项
> + 第三项

有序列表的标记方式是将上述的符号换成数字,并辅以`.`，如：
> 1 . 第一项   
> 2 . 第二项    
> 3 . 第三项

效果：
> 1. 第一项
> 2. 第二项
> 3. 第三项

#### 4.7 分割线

分割线最常使用就是三个或以上`*`，还可以使用`-`和`_`。

#### 4.8 链接

链接可以由两种形式生成：**行内式**和**参考式**。    
**行内式**：
> \[younghz的Markdown库\]\(https:://github.com/younghz/Markdown "Markdown"\)。

效果：
> [younghz的Markdown库](https:://github.com/younghz/Markdown "Markdown")。

**参考式**：
> \[younghz的Markdown库1\]\[1\]    
> \[younghz的Markdown库2\]\[2\]    
> \[1\]:https:://github.com/younghz/Markdown "Markdown"    
> \[2\]:https:://github.com/younghz/Markdown "Markdown"

效果：
> [younghz的Markdown库1][1]    
> [younghz的Markdown库2][2]

[1]: https:://github.com/younghz/Markdown "Markdown"

[2]: https:://github.com/younghz/Markdown "Markdown"

**注意**：上述的`[1]:https:://github.com/younghz/Markdown "Markdown"`不出现在区块中。

#### 4.9 图片

添加图片的形式和链接相似，只需在链接的基础上前方加一个`！`。

#### 4.10 反斜杠`\`

相当于**反转义**作用。使符号成为普通符号。

#### 4.11 符号'`'

起到标记作用。如：
> \`ctrl+a\`

效果：
> `ctrl+a`

#### 5. *谁*在用？

Markdown的使用者：

+ GitHub
+ 简书
+ Stack Overflow
+ Apollo
+ Moodle
+ Reddit
+ 等等

#### 6. 尝试一下

+ **Chrome**下的插件诸如`stackedit`与`markdown-here`等非常方便，也不用担心平台受限。
+ **在线**的dillinger.io评价也不错
+ **Windowns**下的MarkdownPad也用过，不过免费版的体验不是很好。
+ **Mac**下的Mou是国人贡献的，口碑很好。
+ **Linux**下的ReText不错。

**当然，最终境界永远都是笔下是语法，心中格式化 :)。**

****
**注意**：不同的Markdown解释器或工具对相应语法（扩展语法）的解释效果不尽相同，具体可参见工具的使用说明。
虽然有人想出面搞一个所谓的标准化的Markdown，[没想到还惹怒了健在的创始人John Gruber](http://blog.codinghorror.com/standard-markdown-is-now-common-markdown/ )。
****
以上基本是所有traditonal markdown的语法。

### 其它：

列表的使用(非traditonal markdown)：

用`|`表示表格纵向边界，表头和表内容用`-`隔开，并可用`:`进行对齐设置，两边都有`:`则表示居中，若不加`:`则默认左对齐。

|     代码库      |                                          链接                                           |                   链接 |           链接           
|:------------:|:-------------------------------------------------------------------------------------:|---------------------:|:----------------------:|
|   MarkDown   | [https://github.com/younghz/Markdown](https://github.com/younghz/Markdown "Markdown") | baidu.com,baidu.com,baidu.com | https://www.google.com 
| MarkDownCopy | [https://github.com/younghz/Markdown](https://github.com/younghz/Markdown "Markdown") |           google.com 

关于其它扩展语法可参见具体工具的使用说明。

## HTML内容
<blockquote><p>微信公众号排版工具。问题或建议，请公众号留言。<strong><a href='#jump_8'>程序员翻身</a></strong></p>
</blockquote>
<p>建议使用 <strong>Chrome</strong> 浏览器，体验最佳效果。</p>
<p>使用微信公众号编辑器有一个十分头疼的问题：粘贴出来的代码，格式错乱，空间小还带行号，而且特别丑。Markdown.com.cn编辑器能够解决这个问题。</p>
<p>Markdown是一种轻量级的「标记语言」。</p>
<p>请阅读下方文本熟悉工具使用方法，本文可直接拷贝到微信中预览。</p>
<h2 id='1-markdowncomcn-简介'>1 Markdown.com.cn 简介</h2>
<ul>
<li>支持自定义样式的 Markdown 编辑器</li>
<li>支持微信公众号、知乎和稀土掘金</li>
<li>点击右上方对应图标，一键复制到各平台</li>

</ul>
<h2 id='2-markdown语法教程'>2 Markdown语法教程</h2>
<h3 id='21-标题'>2.1 标题</h3>
<p>不同数量的<code>#</code>可以完成不同的标题，如下：</p>
<h1 id='一级标题'>一级标题</h1>
<h2 id='二级标题'>二级标题</h2>
<h3 id='三级标题'>三级标题</h3>
<h3 id='22-字体'>2.2 字体</h3>
<p>粗体、斜体、粗体和斜体，删除线，需要在文字前后加不同的标记符号。如下：</p>
<p><strong>这个是粗体</strong></p>
<p><em>这个是斜体</em></p>
<p><em><strong>这个是粗体加斜体</strong></em></p>
<p>~这里想用删除线~~</p>
<p>注：如果想给字体换颜色、字体或者居中显示，需要使用内嵌HTML来实现。</p>
<h3 id='23-无序列表'>2.3 无序列表</h3>
<p>无序列表的使用，在符号<code>-</code>后加空格使用。如下：</p>
<ul>
<li>无序列表 1</li>
<li>无序列表 2</li>
<li>无序列表 3</li>

</ul>
<p>如果要控制列表的层级，则需要在符号<code>-</code>前使用空格。如下：</p>
<ul>
<li><p>无序列表 1</p>
</li>
<li><p>无序列表 2</p>
<ul>
<li>无序列表 2.1</li>
<li>无序列表 2.2</li>

</ul>
</li>

</ul>
<p><strong>由于微信原因，最多支持到二级列表</strong>。</p>
<h3 id='24-有序列表'>2.4 有序列表</h3>
<p>有序列表的使用，在数字及符号<code>.</code>后加空格后输入内容，如下：</p>
<ol start='' >
<li>有序列表 1</li>
<li>有序列表 2</li>
<li>有序列表 3</li>

</ol>
<h3 id='25-引用'>2.5 引用</h3>
<p>引用的格式是在符号<code>&gt;</code>后面书写文字。如下：</p>
<blockquote><p>读一本好书，就是在和高尚的人谈话。 ——歌德</p>
</blockquote>
<blockquote><p>雇用制度对工人不利，但工人根本无力摆脱这个制度。 ——阮一峰</p>
</blockquote>
<h3 id='27-链接'>2.7 链接</h3>
<p>微信公众号仅支持公众号文章链接，即域名为<code>https://mp.weixin.qq.com/</code>的合法链接。使用方法如下所示：</p>
<p>对于该论述，欢迎读者查阅之前发过的文章，<a href='https://mp.weixin.qq.com/s/s5IhxV2ooX3JN_X416nidA'>你是《未来世界的幸存者》么？</a>
<a id="jump_8"></a></p>
<h3 id='28-图片'>2.8 图片</h3>
<p>插入图片，格式如下：</p>
<p><img src="https://www.nginx.cn/wp-content/uploads/2020/03/qrcode_for_gh_82cf87d482f0_258.jpg" referrerpolicy="no-referrer" alt="这里写图片描述"></p>
<p>支持 jpg、png、gif、svg 等图片格式，<strong>其中 svg 文件仅可在微信公众平台中使用</strong>，svg 文件示例如下：</p>
<p><img src="https://markdown.com.cn/images/i-am-svg.svg" referrerpolicy="no-referrer"></p>
<p>支持图片<strong>拖拽和截图粘贴</strong>到编辑器中。</p>
<p>注：支持图片 <em><strong>拖拽和截图粘贴</strong></em> 到编辑器中，仅支持 https 的图片，图片粘贴到微信时会自动上传微信服务器。</p>
<h3 id='29-分割线'>2.9 分割线</h3>
<p>可以在一行中用三个以上的减号来建立一个分隔线，同时需要在分隔线的上面空一行。如下：</p>
<hr />
<h3 id='210-表格'>2.10 表格</h3>
<p>可以使用冒号来定义表格的对齐方式，如下：</p>
<figure class='table-figure'><table>
<thead>
<tr><th style='text-align:left;' >姓名</th><th style='text-align:center;' >年龄</th><th style='text-align:right;' >工作</th></tr></thead>
<tbody><tr><td style='text-align:left;' >小可爱</td><td style='text-align:center;' >18</td><td style='text-align:right;' >吃可爱多</td></tr><tr><td style='text-align:left;' >小小勇敢</td><td style='text-align:center;' >20</td><td style='text-align:right;' >爬棵勇敢树</td></tr><tr><td style='text-align:left;' >小小小机智</td><td style='text-align:center;' >22</td><td style='text-align:right;' >看一本机智书</td></tr></tbody>
</table></figure>
<p>&nbsp;</p>
<h2 id='3-特殊语法'>3. 特殊语法</h2>
<h3 id='31-脚注'>3.1 脚注</h3>
<blockquote><p>支持平台：微信公众号、知乎。</p>
</blockquote>
<p>脚注与链接的区别如下所示：</p>
<pre><code class='language-markdown' lang='markdown'>链接：[文字](链接)
脚注：[文字](脚注解释 &quot;脚注名字&quot;)
</code></pre>
<p>有人认为在<a href='https://en.wikipedia.org/wiki/Front-end_web_development' title='Front-end web development'>大前端时代</a>的背景下，移动端开发（Android、IOS）将逐步退出历史舞台。</p>
<p><a href='是指掌握多种技能，并能利用多种技能独立完成产品的人。' title='什么是全栈工程师'>全栈工程师</a>在业务开发流程中起到了至关重要的作用。</p>
<p>脚注内容请拉到最下面观看。</p>
<h3 id='32-代码块'>3.2 代码块</h3>
<blockquote><p>支持平台：微信代码主题仅支持微信公众号！其他主题无限制。</p>
</blockquote>
<p>如果在一个行内需要引用代码，只要用反引号引起来就好，如下：</p>
<p>Use the <code>printf()</code> function.</p>
<p>在需要高亮的代码块的前一行及后一行使用三个反引号，同时<strong>第一行反引号后面表示代码块所使用的语言</strong>，如下：</p>
<pre><code class='language-java' lang='java'>// FileName: HelloWorld.java