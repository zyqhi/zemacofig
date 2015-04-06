;; package-install
; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;                         ("marmalade" . "http://marmalade-repo.org/packages/")
;                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; basic configuration
(add-to-list 'load-path "~/.emacs.d/config")
(require 'basic-config)
;(require 'xcscope-config)
(require 'graphviz-dot-config)
(require 'cc-mode-config)

;; load-path
;(add-to-list 'load-path "~/.emacs.d/myconfig/")

;;;一些有用的设置
(require 'skills)
;---------------------------------------------------


;; man page 
(global-set-key [(f1)] (lambda ()  (interactive)  (manual-entry  (current-word))))

;; latex-mode
; (add-to-list 'ac-modes 'latex-mode)
; (defun ac-latex-mode-setup()
;   (setq ac-sources (append '(ac-source-yasnippet) ac-sources)))
; (add-hook 'latex-mode-hook 'ac-latex-mode-setup)
                                        
;(require 'auto-complete-setting)
;;load theme
;;(require 'color-theme)
;;(load-theme 'zen-and-art t)

(when (string= (getenv "USER") "mutsu")
  (add-to-list 'load-path "~/.emacs.d/vendor/includeme")
  (require 'includeme)
  (define-key c-mode-base-map (kbd "C-c C-h") 'includeme)

  (add-to-list 'load-path "~/.emacs.d/vendor/disaster")
  (require 'disaster)
  (define-key c-mode-base-map (kbd "C-c C-d") 'disaster))



;; key bindings
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'control)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char)
  (define-key global-map [?¥] [?\\])
  ) ;; sets fn-delete to be right-delete

;;;;;;;;;;;;;;;;;;;;;;;;;;end init.el;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(add-to-list load-path "~/.emacs.d/")
;(require 'cyberpunk)


