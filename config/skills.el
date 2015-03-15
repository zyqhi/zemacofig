;;-------------------------------------------------------------
;自动添加括号
;;-------------------------------------------------------------
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)
(defun my-c-mode-hook ()
  ;;; .... 其他配置功能
  (local-set-key (kbd "{") 'skeleton-c-mode-left-brace)
  ;;; .... 其他配置功能
  )
(defun skeleton-c-mode-left-brace (arg)
  (interactive "*P")
  (if  (c-in-literal (c-most-enclosing-brace (c-parse-state)))
	(self-insert-command 1)
	;; auto insert complex things.
	(let* ((current-line (delete-and-extract-region (line-beginning-position) (line-end-position)))
		   (lines (and arg (mark t) (delete-and-extract-region (mark t) (point))))
		   (after-point (make-marker)))
	  ;;; delete extra blank begin and after the LINES
	  (setq lines (and lines
					   (with-temp-buffer
						 (insert lines)
						 (beginning-of-buffer)
						 (delete-blank-lines)
						 (delete-blank-lines)
						 (end-of-buffer)
						 (delete-blank-lines)
						 (delete-blank-lines)
						 (buffer-string))))
	  (save-excursion
		(let* ((old-point (point)))
		  (insert (if current-line current-line "")  "{\n")
		  (and lines (insert lines))
		  (move-marker after-point (point))
		  (insert "\n}\n")
		  (indent-region old-point (point) nil)))
	  (goto-char after-point)
	  (c-indent-line)
	  )))



;;;;;;;;;;;;;;;;;;;;;;;;智能跳转;;;;;;;;;;;;;;;;;;;;;  
;;;C-.来在当前位置做个标记  
;;用C-,就回到刚才做标记的地方A，再用C-,又会回到B   
(global-set-key (kbd "M-.") 'ska-point-to-register)   
(global-set-key (kbd "M-;") 'ska-jump-to-register)   
(defun ska-point-to-register()   
  "Store cursorposition _fast_ in a register.   
  Use ska-jump-to-register to jump back to the stored   
  position."   
  (interactive)   
  (setq zmacs-region-stays t)   
  (point-to-register 8))   
(defun ska-jump-to-register()   
  "Switches between current cursorposition and position   
  that was stored with ska-point-to-register."   
  (interactive)   
  (setq zmacs-region-stays t)   
  (let ((tmp (point-marker)))   
	(jump-to-register 8)   
	(set-register 8 tmp)))   
;;;;;;;;;;;;;;;;;;;;;;;;智能跳转;;;;;;;;;;;;;;;;;;;;;  


;;;;;;;;;;;;;;;;;;shell设置;;;;;;;;;;;;;;;;;;  
(global-set-key [f1] 'shell);F1进入Shell  
(defun open-eshell-other-buffer ()  
  "Open eshell in other buffer"  
  (interactive)  
  (split-window-vertically)  
  (eshell))  
(global-set-key [C-f8]  'open-eshell-other-buffer)  
(global-set-key [(f8)] 'eshell)  
;;目的是开一个shell的小buffer，用于更方便地测试程序(也就是运行程序了)，我经常会用到  
;;f8就是另开一个buffer然后打开shell，C-f8则是在当前的buffer打开shell  
;;;;;;;;;;;;;;;;;;shell设置;;;;;;;;;;;;;;;;;;  


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
;; Highlight   
;面我来讲讲highlight-symbol的使用.
;C-c M-H高亮当前光标下的单词,
; C-c M-R取消所有单词的高亮,
; C-c M-N移到下一个高亮,
; C-c M-P则移到上一个高亮(这两个命令和vi中的*和#命令功能一样，当激活了emaci-mode后，按n和p即可，这样用起来更方便了
;具体参见强大的文件阅读器 － Emaci),
; C-c M-n在函数内移到下一个高亮,
; C-c M-p在函数内移到上一个高亮,
; C-c r对当前光标下的单词进行替换. 使用;很简单吧.
;注意：highlight-symbol与color moccur以及w3m冲突，当启用了`highlight-symbol-mode’后，moccur和w3m自己的颜色高亮就没了。
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
;; highlight symbol   
;(require 'highlight-symbol-settings)



(provide 'skills)
