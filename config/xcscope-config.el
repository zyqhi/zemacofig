;;-------------------------------------------------------------
;;                      Cscope设置
;;-------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/vendor/cscope")
(require 'xcscope)
(require 'xcscope+)
(add-hook 'c-mode-common-hook
	  '(lambda ()
	       (require 'xcscope) )
	  )
(setq cscope-do-not-update-database t)
;(define-key global-map (kbd "C-a")  'cscope-set-initial-directory)
(define-key global-map [(control f4)]  'cscope-unset-initial-directory)
;(define-key global-map (kbd "M-f")  'cscope-find-this-symbol)
(define-key global-map (kbd "M-s")  'cscope-find-global-definition)
(define-key global-map (kbd "M-n")  'cscope-find-global-definition-no-prompting)
(define-key global-map [(control f8)]  'cscope-pop-mark)
(define-key global-map [(control f9)]  'cscope-next-symbol)
(define-key global-map [(control f10)] 'cscope-next-file)
(define-key global-map [(control f11)] 'cscope-prev-symbol)
(define-key global-map [(control f12)] 'cscope-prev-file)
(define-key global-map [(meta f9)]     'cscope-display-buffer)
(define-key global-map [(meta f10)]    'cscope-display-buffer-toggle)
;;-------------------------------------------------------------
;;                            FlyMake
;在Mkaefile中写出语法检查
; CXX=g++
; CHK_SOURCES=test.cpp
; .PHONY: check-syntax 
; check-syntax: 
;      	$(CXX) -Wall -Wextra -pedantic -fsyntax-only $(CHK_SOURCES)
;;-------------------------------------------------------------
;(require 'flymake) 
;(global-set-key [f3] 'flymake-display-err-menu-for-current-line)
;(global-set-key [f4] 'flymake-goto-next-error)
;(add-hook 'find-file-hooks 'flymake-find-file-hook)
;; flymake 
;(defun my-flymake-show-next-error()
;   (interactive) 
;    (flymake-goto-next-error) 
;    (flymake-display-err-menu-for-current-line)
;    )
;(local-set-key (kbd "C-c") 'my-flymake-show-next-error)

;;(add-hook 'c++-mode-hook 
;;	  (lambda ()
;;	    (flymake-mode)
;;	    (gccsense-flymake-setup)))

;;-------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;GDB设置;;;;;;;;;;;;;;;;;;;;;;  
;;命令 功能 
;gdb 启动gdb进行调试 
;gdb-many-windows 切换单窗格/多窗格模式 
;gdb-restore-windows 恢复窗格布局 

;功能 命令 默认快捷键 
;添加断点 gud-break C-x C-a C-b 或 C-x <SPC> 
;删除断点 gud-remove C-x C-a C-d 
;运行/继续程序 gud-go 无 
;单步执行，无视函数 gud-next C-x C-a C-n 
;单步执行，进入函数 gud-step C-x C-a C-s 
;跳出当前函数 gud-finish C-x C-a C-f 
;运行到光标所在语句 gud-until C-x C-a C-u 
;继续运行程序 gud-cont C-x C-a C-r 

;功能 命令 默认快捷键 
;观察变量 gud-watch C-x C-a C-w 
;展开/收缩变量  <SPC> 
;开启/关闭工具提示 gud-tooltip-mode 

(global-set-key [f5] 'make-frame-command);;另外开启一个窗口进行gdb调试  
(setq gdb-many-windows t)  
(require 'gud)   
(global-set-key [f6] 'gdb)  
;;F5设置为在Emacs中调用gdb   
;;;;;;;;;;;;;;;;;;;;;END  GDB设置;;;;;;;;;;;;;;;;;;  

(provide 'xcscope-config)
