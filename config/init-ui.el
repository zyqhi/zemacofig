;; 括号匹配时显示另外一边的括号，而不是烦人的跳到另一个括号
(show-paren-mode t)

(setq show-paren-style 'parentheses)
(setq inhibit-startup-message t)
(setq-default cursor-type 'bar)

(fset 'yes-or-no-p 'y-or-n-p) 

;; Time settings
;; Display time in mode line
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-use-mail-icon t)
(setq display-time-interval 10)


;; theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/zenburn")
					;(load-theme 'zenburn t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/solarized")
					;(require 'solarized)
					;(require 'solarized-themes)
					;(load-theme 'solarized-dark)

					;(load-theme 'dichromacy)
					;(load-theme 'adwaita)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-themes/themes")
					;(load-theme 'graham t)
					;(load-theme 'granger t)
(load-theme 'spolsky t)
					;(load-theme 'hickey t)
					;(load-theme 'mccarthy t)

					;(load-theme 'granger t)

                                                                                                                   
(progn
  ;; Turn off mouse interface early in startup to avoid momentary display
  (dolist (mode '(
					;menu-bar-mode 
		  tool-bar-mode 
		  scroll-bar-mode
		  auto-fill-mode ;; 关闭自动换行
		  ))
    (when (fboundp mode) (funcall mode -1))))


;; 显示行号
(require 'linum)
(global-linum-mode t)
;; (setq linum-format "  %d ")


(add-to-list 'load-path "~/.emacs.d/vendor/rainbow-delimiters")
(require 'rainbow-delimiters)
(rainbow-delimiters-mode)

(add-to-list 'load-path "~/.emacs.d/vendor/rainbow-mode")
(require 'rainbow-mode)

(add-to-list 'load-path "~/.emacs.d/vendor/pretty-mode")
(require 'pretty-mode)
(global-pretty-mode 1)

(add-to-list 'load-path "~/.emacs.d/vendor/sr-speedbar")
(require 'sr-speedbar)

;; (set-frame-parameter (selected-frame) 'alpha '(90 90))
;; (add-to-list 'default-frame-alist '(alpha 85 85))

(add-to-list 'load-path "~/.emacs.d/vendor/mic-paren")
(require 'mic-paren)
(paren-activate)

(add-to-list 'load-path "~/.emacs.d/vendor/flx")
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(add-to-list 'load-path "~/.emacs.d/vendor/sublimity")
(require 'sublimity)
(require 'sublimity-scroll)
;(require 'sublimity-map)
;(require 'sublimity-attractive)
(sublimity-mode 1)


(add-to-list 'load-path "~/.emacs.d/vendor/window-margin")
(add-hook 'text-mode 'turn-on-window-margin-mode)


(global-set-key [(f8)] 'loop-alpha)  ;;注意这行中的F8 , 可以改成你想要的按键
    
(setq alpha-list '((90 85) (100 100)))    
    
(defun loop-alpha ()    
  (interactive)    
  (let ((h (car alpha-list)))                    
    ((lambda (a ab)    
       (set-frame-parameter (selected-frame) 'alpha (list a ab))    
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))    
       ) (car h) (car (cdr h)))    
    (setq alpha-list (cdr (append alpha-list (list h))))))

(loop-alpha)

;; TEST CODE ;;

(x-display-pixel-height) ;800
(frame-char-height) ;14
(frame-char-width) ;7
(/ 600 14)

(defun set-frame-size-position-according-to-resolution (fwidth fheight xoffset yoffset)
  "use fwidth char wide windown"
  (interactive)
  (if (display-graphic-p)
  (progn
    ;; use 160 char wide window for largeish displays
    ;; and smaller 120 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    ;; 120 default
    (if (> (x-display-pixel-width) 1280)
           (add-to-list 'default-frame-alist (cons 'width 160))
           (add-to-list 'default-frame-alist (cons 'width fwidth)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    ;; 200 default
    (add-to-list 'default-frame-alist 
         (cons 'height (/ (- (x-display-pixel-height) fheight)
			  (frame-char-height))))
    ;; position
    (set-frame-position (selected-frame) 220 60))))

; (set-frame-size-position-according-to-resolution 120 200 0 0)

(defun best-fit-frame-size-and-position ()
  (set-frame-size-position-according-to-resolution 120 200 0 0))

(add-hook 'after-make-frame-functions 'best-fit-frame-size-and-position)

;(add-hook 'emacs-startup-hook 'best-fit-frame-size-and-position)
(best-fit-frame-size-and-position)



(provide 'init-ui)

