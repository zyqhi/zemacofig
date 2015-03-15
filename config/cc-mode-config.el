;; configuration for cc-mode, it will make sense in c/c++, java etc.


;; coding style
(setq c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (c-mode . "bsd")
                        (c++-mode . "bsd")
                        (other . "linux")))

;;(setq-default c-electric-flag t)
;; common setting for c-mode
(defun my-cmode-hook ()
  (setq c-basic-offset 4
        indent-tabs-mode nil)
  (electric-indent-mode)
  (define-key c-mode-base-map "\C-m" 'c-context-line-break)
  )

(add-hook 'c-mode-common-hook 'my-cmode-hook)

(provide 'cc-mode-config)

