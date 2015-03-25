;; 括号匹配时显示另外一边的括号，而不是烦人的跳到另一个括号
(show-paren-mode t)
(setq show-paren-style 'parentheses)
(setq inhibit-startup-message t)
(setq-default cursor-type 'bar)

;; 不要总是没完没了的问yes or no, 为什么不能用 y/n 
(fset 'yes-or-no-p 'y-or-n-p) 

;; Time settings
;; Display time in mode line
(display-time-mode 1)
(setq display-time-24hr-format t)
;; 时间显示包括日期和具体时间
(setq display-time-day-and-date t)
;; 时间栏旁边启用邮件设置
(setq display-time-use-mail-icon t)
;; 时间的变化频率
(setq display-time-interval 10)



;; 不备份文件，不推荐
(setq make-backup-files nil)

(provide 'init-ui)

