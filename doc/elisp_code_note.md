下面这部分代码摘自**starter-kit**，分析这段代码，用于设计实现emacs显示markdown。
``` elisp
(defun esk-pretty-lambdas ()
  (font-lock-add-keywords
   nil `(("(?\\(lambda\\>\\)"
          (0 (progn (compose-region (match-beginning 1) (match-end 1) ,(make-char 'greek-iso8859-7 107)) nil))))))
```
## 函数说明
### 替换函数
> 该函数将缓冲区内指定的内容替换成另一种内容
``` elisp
(compose-region START END &optional COMPONENTS MODIFICATION-FUNC)
```
* `START` 指代替代发生的开始位置
* `END` 指代替代结束的位置
* `COMPONENTS` 是可选参数，表示替换内容，可以为字符，字符串，列表和向量

### 添加字体锁定关键字
> 该函数为指定的主模式添加字体锁定关键字
``` elisp
(font-lock-add-keywords MODE KEYWORDS &optional HOW)
```
* `MODE` 指代目标主模式
* `KEYWORDS` 指代一个关键字列表，列表的内容为关键字，以及对该关键字对处理方式
* `HOW` 现在先忽略，暂时用不到
