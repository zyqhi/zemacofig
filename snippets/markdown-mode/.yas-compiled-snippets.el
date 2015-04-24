;;; Compiled snippets and support files for `markdown-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'markdown-mode
		     '(("insc" "{% highlight $1 %}\n$0\n{% endhighlight %}\n\n" "Insert code" nil nil nil nil nil nil)
		       ("kw" "\\`$1\\`$0\n" "Key word" nil nil nil nil nil nil)
		       ("note" "**NOTE:**\n> $0\n" "Note" nil nil nil nil "direct-keybinding" nil)))


;;; Do not edit! File generated at Sun Apr 19 12:35:41 2015
