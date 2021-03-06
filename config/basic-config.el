;;;;;;;;;;;;;;;;;;;;; 基本配置 ;;;;;;;;;;;;;;;;;;;;

(require 'init-ui)

;; 不备份文件，不推荐
(setq make-backup-files nil)

(defun my-buffer-face-mode-varible ()
  (interactive)
					;(setq buffer-face-mode-face '(:family "DejaVu Serif"))
  (buffer-face-mode))
;; Set default font faces for Info-mode
(add-hook 'Info-mode-hook 'my-buffer-face-mode-varible)



;; 最大化窗口
;; 仅在linux下使用X桌面才有用
(defun toggle-full-screen (&optional f)
  "Maxsize the frame when launch emacs."
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
			 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
			 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
(when (eq window-system 'x)
  (toggle-full-screen))

;; 全屏设置
(defun switch-fullscreen nil
  (interactive)
  (let* ((modes '(nil fullboth))
	 (cm (cdr (assoc 'fullscreen (frame-parameters) ) ) )
	 (next (cadr (member cm modes))))
    (modify-frame-parameters
     (selected-frame)
     (list (cons 'fullscreen next)))))

(define-key global-map [f11] 'switch-fullscreen)

;; 设置默认字体，使得字体更好看
					;(when window-system
					;  (let ((myfont "DejaVu Sans Mono-12"))
					;	(set-frame-font myfont)
					;	(add-to-list 'default-frame-alist (cons 'font myfont))))

;; 中文字体
;;(set-fontset-font "fontset-default" 'han '("Microsoft YaHei" . "unicode-bmp"))
					;(set-fontset-font "fontset-default" 'han '("WenQuanYi Micro Hei"))
;; 窗口显示设置，0表示隐藏，t表示显示

 
;; 
;; (require 'tabbar-config)

;;;;;;;;;;;;;;;;;;;; yasnippet设置 ;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path	"~/.emacs.d/vendor/yasnippet")
(require 'yasnippet)
(setq yas-snippet-dirs
      '(
		"~/.emacs.d/snippets"		;; my personal snippets
	"~/.emacs.d/vendor/yasnippet/snippets"         ;; the default collection
	))
(yas-global-mode 1)


					;(add-to-list 'load-path "~/.emacs.d/vendor/yasnippet-bundle")
					;(require 'yasnippet-bundle)
					;(setq yas/root-directory "~/.emacs.d/plugins")
;;--加入下面一段话会使加载时候很慢,可以Emacs启动后手动加载  M -x yas/load-director
;;自己新建模板的话用yas/new-snippet
					;(yas/load-directory yas/root-directory)


;;;;;;;;;;;;;;;;;;;; auto-complete 设置 ;;;;;;;;;;;;;;;;;;;;
;; auto-complete setting
(add-to-list 'load-path "~/.emacs.d/vendor/popup")
(require 'popup)
(add-to-list 'load-path "~/.emacs.d/vendor/fuzzy")
(require 'fuzzy)
(add-to-list 'load-path "~/.emacs.d/vendor/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/vendor/auto-complete/dict")
(ac-config-default)

;; gccsence
(add-to-list 'load-path "~/.emacs.d/vendor/gccsense")
(require 'gccsense)
(global-set-key "\257" (quote ac-complete-gccsense))
(global-set-key (kbd "<C-i>") (quote ac-complete-gccsense))


;; configuration for latex
(add-hook 'LaTeX-mode-hook (lambda()
			     (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
			     (setq TeX-command-default "XeLaTeX")
			     (setq TeX-save-query  nil )
			     (setq TeX-show-compilation t)
			     ))
(setq TeX-output-view-style
      (quote
       (("^pdf$" "." "zathura  %o")
	("^html?$" "." "iceweasel %o"))))
;; Use zathura as the pdf viewer.
(setq TeX-view-program-selection
      '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
      '(("PDF Viewer" "zathura %o")))

					;To highlight (or font-lock) the “\section{title}” lines:

;; (font-lock-add-keywords
;;    'latex-mode
;;    `((,(concat "^\\s-*\\\\\\("
;;                "\\(documentclass\\|\\(sub\\)?section[*]?\\)"
;;                "\\(\\[[^]% \t\n]*\\]\\)?{[-[:alnum:]_ ]+"
;;                "\\|"
;;                "\\(begin\\|end\\){document"
;;                "\\)}.*\n?")
;;       (0 'your-face append))))

;; session setting 
(add-to-list 'load-path "~/.emacs.d/vendor/session")
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;; restore session
					;(desktop-save-mode 1)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;; popup kill ring 
(require 'popup)
(add-to-list 'load-path "~/.emacs.d/vendor/pos-tip")
(require 'pos-tip)
(add-to-list 'load-path "~/.emacs.d/vendor/popup-kill-ring")
(require 'popup-kill-ring)
(global-set-key "\M-y" 'popup-kill-ring)

;; recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;;hide region
(add-to-list 'load-path "~/.emacs.d/vendor/hide-region")
(require 'hide-region)
(global-set-key (kbd "C-c r") 'hide-region-hide)
(global-set-key (kbd "C-c R") 'hide-region-unhide)


;; hide lines
(add-to-list 'load-path "~/.emacs.d/vendor/hide-lines")
(require 'hide-lines)
(global-set-key (kbd "C-c l") 'hide-lines)
(global-set-key (kbd "C-c L") 'show-all-invisible)


;; smex
(add-to-list 'load-path "~/.emacs.d/vendor/smex")
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; ido-ubiquitous, show anything in ido
(add-to-list 'load-path "~/.emacs.d/vendor/ido-ubiquitous")
(require 'ido-ubiquitous)
(setq ido-everywhere t)

(ido-mode t)
(ido-ubiquitous-mode)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-auto-merge-work-directories-length nil
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-use-virtual-buffers t
      ido-handle-duplicate-virtual-buffers 2
      ido-max-prospects 10)

;; idle-highlight-mode
(add-to-list 'load-path "~/.emacs.d/vendor/idle-highlight-mode")
(require 'idle-highlight-mode)
(add-hook 'prog-mode-hook 'idle-highlight-mode)

;; paredit
(add-to-list 'load-path "~/.emacs.d/vendor/paredit")
(require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
					;(add-hook 'prog-mode-hook 'paredit-mode)
					;(paredit-mode t)

;; find file in project
(add-to-list 'load-path "~/.emacs.d/vendor/find-file-in-project")
(require 'find-file-in-project)
(global-set-key (kbd "C-x f") 'find-file-in-project)

;; magit
(add-to-list 'load-path "~/.emacs.d/vendor/git-modes")
(add-to-list 'load-path "~/.emacs.d/vendor/magit")
(eval-after-load 'info
  '(progn (info-initialize)
	  (add-to-list 'Info-directory-list "/path/to/magit/")))
(require 'magit)

;; copy
;; (require 'copy-enhanced)
(add-to-list 'load-path "~/.emacs.d/vendor/copy-enhanced")
(require 'copy-enhanced)

;;;;;;;;;;;;;;;;;;;;;;;;;;cscope;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/vendor/cscope")
(require 'xcscope+)
(cscope-setup)


;; powerline
(add-to-list 'load-path "~/.emacs.d/vendor/emacs-powerline")
(require 'powerline)

;; (custom-set-faces
;;  '(mode-line ((t (:foreground "#00ffff" :background "#ee00ee" :box nil))))
;;  '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))

(add-to-list 'load-path "/home/zyqhi/.emacs.d/vendor/yascroll-el")
					;(require 'yascroll)
					;(global-yascroll-bar-mode 1)

;; markdown-mode
(add-to-list 'load-path "~/.emacs.d/vendor/markdown-mode")
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))



(add-to-list 'load-path "~/.emacs.d/vendor/multiple-cursors")
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(add-to-list 'load-path "~/.emacs.d/vendor/magic-latex-buffer")
(require 'magic-latex-buffer)
(add-hook 'latex-mode-hook 'magic-latex-buffer)


(setq default-terminal-coding-system 'utf-8) 

(add-to-list 'load-path "~/.emacs.d/vendor/multi-term")
(require 'multi-term)
(setq multi-term-program "/bin/zsh")

(global-set-key (kbd "<f12>") 'multi-term)

(add-hook 'term-mode-hook
	  (lambda ()
	    (yas-minor-mode -1)
	    (define-key term-raw-map (kbd "C-y") 'term-paste)
	    (setq term-buffer-maximum-size 0)
	    (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
	    (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))))

;; add follow code in ~/.zshrc
;; export LC_ALL="en_US.UTF-8"
;; export LANG="en_US.UTF-8"

(add-to-list 'load-path "~/.emacs.d/vendor/haskell-mode/")
(require 'haskell-mode-autoloads)
(add-to-list 'Info-default-directory-list "~/.emacs.d/vendor/haskell-mode/")
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
;;(setq haskell-indentation-where-pre-offset 4)
;;(setq haskell-indentation-left-offset 4)
	  
(provide 'basic-config)
