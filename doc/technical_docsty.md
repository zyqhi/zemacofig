#一篇技术文章该有的格式
____
[TOC]

## 前言
一篇技术文档应该有以下内容：
华丽的分割线

##  基本标记
- 列表
	- 列表条目1
	- 列表条目2
- 加粗强调
	- 这是**粗体**，注意不要有空格，不如效果消失
- 参考
____
## 引用代码
代码的功能在文档中给出。
### 代码块
代码块指的是一个描述了某种功能的代码片段，比如：
``` elisp
; emacs lisp code
(message "Hello Emacs")
```
上述代码的功能：

### 命令行
命令行是一条可以在shell里面执行的完整命令，比如：
``` shell
git status
```
上述命令完成的功能：
参数可以从man获取，因此一般不需要说明参数的意义。

### 接口说明
接口是指编程接口，可以是一个函数或者一个宏，比如：
``` c
int max(int a, int b)
```
接口的参数说明，以列表给出：
- `a`		:	参数1	
- `b`		:	参数2

### 键盘输入
比如输入Command键盘 <kbd>Command</kbd>
____

## 参考引用
### 链接
- 直接链接
链接指明出处，比如下面这个链接，表明链接为维基百科。—— [维基百科](https://zh.wikipedia.org/wiki/Markdown)
- 附后链接
链接指明出处，比如下面这个链接，表明链接为维基百科。—— [维基百科](1)

### 引文
> 这一部分是引文，饮用别人的文字，或者说强调某个观点

### 引文和链接
> Some kinds of display specifications specify something to display instead of the text that has the property. These are called replacing display specifications. Emacs does not allow the user to interactively move point into the middle of buffer text that is replaced in this way. ——[Emacs Manual](http://www.gnu.org/software/emacs/manual/html_node/elisp/Replacing-Specs.html#Replacing-Specs)

[1]:https://zh.wikipedia.org/wiki/Markdown
[2]:http://www.gnu.org/software/emacs/manual/html_node/elisp/Replacing-Specs.html#Replacing-Specs
