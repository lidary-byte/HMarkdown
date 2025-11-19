# Markdown 完整格式与数学公式示例

## 1. 文本样式与强调

这是**粗体文本**，这是*斜体文本*，这是~~删除线~~，这是`行内代码`。

> 引用文本示例：Markdown 中使用 `>` 表示引用块[1](@ref)。

## 2. 列表

### 无序列表
- 列表项一
- 列表项二
    - 嵌套列表项 A
    - 嵌套列表项 B

### 有序列表
1. 第一项
2. 第二项
    1. 嵌套有序项 a
    2. 嵌套有序项 b

### 任务列表
- [x] 已完成任务
- [ ] 待办任务一
- [ ] 待办任务二

## 3. 代码块

### Json 示例
```json
{
  "name": "小张",
  "age": 43
}
```

### JavaScript 示例
```javascript
// 阶乘函数
function factorial(n) {
    var a = false
    if (n === 0) {
        return 1;
    }
    return n * factorial(n - 1);
}
```

## 4. 表格

| 算法 | 时间复杂度 | 空间复杂度 | 适用场景 |
|------|------------|------------|----------|
| 快速排序 | $O(n \log n)$ | $O(\log n)$ | 大规模数据排序 |
| 冒泡排序 | $O(n^2)$ | $O(1)$ | 教学示例[3](@ref) |
| 二分查找 | $O(\log n)$ | $O(1)$ | 有序数组查询 |

## 5. 数学公式

### 5.1 行内公式
质能方程 $E = mc^2$ 是物理学的基本公式。圆的面积公式为 $A = \pi r^2$，其中 $r$ 是半径[1](@ref)。

### 5.2 独立公式

**二次方程求根公式：**
$$ x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a} $$

**微积分基本定理：**
$$ \int_a^b f'(x) \,dx = f(b) - f(a) $$

**求和公式：**
$$ \sum_{i=1}^n i = \frac{n(n+1)}{2} $$
 

**极限运算：**
$$ \lim_{n \to \infty} \frac{1}{n(n+1)} $$

**积分运算[6](@ref)：**
$$ \int_0^1 {x^2} \,{\rm d}x $$

**希腊字母示例：**
$$ \alpha + \beta = \gamma,\quad \Delta = \delta \cdot \epsilon $$

 

## 6. 链接与图片

[Markdown 官方指南](https://www.markdownguide.org)

![替代文本](https://img1.baidu.com/it/u=2172818577,3783888802&fm=253&app=138&f=JPEG?w=800&h=1422)

## 7. 高级数学符号

### 集合运算
$$ A \cup B,\quad A \cap B,\quad A \setminus B $$

### 导数与偏导
$$ \frac{dy}{dx},\quad \frac{\partial f}{\partial t} $$

### 数学运算符
$$ \pm \times \div \cdot \ast \star \circ \bullet $$

### 逻辑符号
$$ \forall \exists \in \notin \subset \subseteq \supset \supseteq $$

### 关系运算符
$$ = \neq \equiv \approx \leq \geq < > $$

## 8. 公式编号

使用 `\begin{equation}` 环境可以为公式自动编号[2](@ref)：

$$
\begin{equation}
e^{i\pi} + 1 = 0
\end{equation}
$$

引用公式时使用 `\eqref{}` 命令。

## 9. 注意事项

1. 数学公式以 `$` 开头和结尾表示行内公式，以 `$$
` 开头和结尾表示独立公式[1](@ref)
2. 上下标用 `^` 和 `_` 表示，多字符内容需要用 `{}` 包裹[6](@ref)
3. 分数使用 `\frac{分子}{分母}`，根号使用 `\sqrt{}`[6](@ref)
4. 特殊字符如 `{ } \ ` 等需要转义
5. 矩阵使用 `\begin{matrix}` 环境，用 `\\` 换行，`&` 对齐[1](@ref)

## 10. 完整示例

**算法复杂度分析模板[3](@ref)：**

### 时间复杂度分析
$$
\begin{aligned}
T(n) &= \underbrace{O(n)}_{\text{预处理}} + \underbrace{O(k \log n)}_{\text{查询}} \\
&= O(n + k \log n)
\end{aligned}
$$

 
---

### 📘 Markdown 常用样式速查表

| 元素/功能 | Markdown 语法 | 效果示例 / 说明 |
| :--- | :--- | :--- |
| **标题 (Heading)** | `# H1`<br>`## H2`<br>`### H3` | 共支持六级标题，`#` 后需加空格 。 |
| **粗体 (Bold)** | `**粗体文本**` 或 `__粗体文本__` | **粗体文本**  |
| **斜体 (Italic)** | `*斜体文本*` 或 `_斜体文本_` | *斜体文本*  |
| **删除线 (Strikethrough)** | `~~删除线文本~~` | ~~删除线文本~~  |
| **行内代码 (Inline Code)** | `` `代码` `` | `print("Hello")`  |
| **链接 (Link)** | `https://example.com "可选标题"` | https://example.com  |
| **图片 (Image)** | `!图片URL或路径` | 替代文本在图片无法加载时显示 。 |
| **引用块 (Blockquote)** | `> 引用内容`<br>`>> 嵌套引用` | > 引用内容  |
| **有序列表 (Ordered List)** | `1. 第一项`<br>`2. 第二项` | 1. 第一项<br>2. 第二项  |
| **无序列表 (Unordered List)** | `- 项目`<br>`* 项目`<br>`+ 项目` | - 项目  |
| **任务列表 (Task List)** | `- [x] 已完成`<br>`- [ ] 未完成` | - [x] 已完成<br>- [ ] 未完成  |
| **分割线 (Horizontal Rule)** | `---` 或 `***` 或 `___` | 一条水平线 。 |
| **表格 (Table)** | <code>&#124; 左对齐 &#124; 居中对齐 &#124; 右对齐 &#124;</code><br><code>&#124; :--- &#124; :---: &#124; ---: &#124;</code><br><code>&#124; 单元格 &#124; 单元格 &#124; 单元格 &#124;</code> | 对齐方式由第二行的冒号控制 。 |
| **代码块 (Fenced Code Block)** | ```` ```语言名称`<br>`代码内容`<br>```` ``` ```` | 支持语法高亮，如 `python`, `java`, `javascript` 等 。 |
| **脚注 (Footnote)** | `正文`<br>`: 脚注内容。` | 正文  |
| **上标 (Superscript)** | `X^2^` | X^2^  |
| **下标 (Subscript)** | `H~2~O` | H~2~O  |
| **高亮 (Highlight)** | `==高亮文本==` | ==高亮文本==（部分编辑器支持）  |
| **Emoji** | `:smile:` 或 `:rocket:` | 😄 或 🚀（部分平台直接支持）  |
| **数学公式 (Math)** | 行内: `$E = mc^2$`<br>块级: `$$x = \frac{-b \pm \sqrt{b^2-4ac}}{2a}$$` | 需要编辑器支持 MathJax 或 KaTeX 。 |
| **转义字符 (Escape)** | 在特殊字符前加 `\`，如 `\*` 显示 * | 用于显示原本用于格式化的字符本身，如 `#`, `-` 等 。 |
| **HTML** | 可直接在 Markdown 中使用 HTML 标签，如 `<u>下划线</u>` | <u>下划线</u>  |

### 💡 使用要点提示

1.  **空格很重要**：在写标题（`#` 后）、列表符号（`-` 或 `1.` 后）时，记得加上一个空格，这是 Markdown 语法的一部分 。
2.  **扩展语法兼容性**：请注意，标记有“部分编辑器支持”的语法属于扩展语法（如任务列表、表格、脚注、数学公式等）。在使用前，最好先在你目标平台（如 GitHub、博客园、CSDN 等）测试一下是否支持 。
3.  **代码块语言指定**：在代码块开头的三个反引号后指定语言名称，可以帮助许多编辑器和平台进行准确的语法高亮，提升代码可读性 。

H<sub>2</sub>O、注册商标<sup>&reg;</sup>、(x<sub>1</sub>+x<sub>2</sub>)<sup>2</sup> = x<sub>1</sub><sup>2</sup>+x<sub>2</sub><sup>2</sup>+2x<sub>1</sub>x<sub>2</sub>