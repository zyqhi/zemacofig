;;;;;;;;;;;;;;;;;;;; Tabbar 设置 ;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/vendor/tabbar/tabbar")
(require 'tabbar)
(tabbar-mode)
(global-set-key [(meta j)] 'tabbar-backward)  
(global-set-key [(meta k)] 'tabbar-forward)
;; 设置tabbar外观 
;; 设置默认主题: 字体, 背景和前景颜色，大小 
(set-face-attribute 'tabbar-default nil
		    :family "Vera Sans YuanTi Mono"
		    :background "gray90"
		    :foreground "gray20"
		    :height 1.0 
		    ) 
;; 设置左边按钮外观：外框框边大小和颜色 
(set-face-attribute 'tabbar-button nil
		    :inherit 'tabbar-default
		    :box '(:line-width 1 :color "gray30") 
		    ) 
;; 设置当前tab外观：颜色，字体，外框大小和颜色 
(set-face-attribute 'tabbar-selected nil
		    :inherit 'tabbar-default
		    :foreground "DarkGreen"
		    :background "LightGoldenrod"
		    :box '(:line-width 2 :color "DarkGoldenrod") 
		    ;; :overline "black" 
		    ;; :underline "black" 
		    :weight 'bold
		    ) 
;; 设置非当前tab外观：外框大小和颜色 
(set-face-attribute 'tabbar-unselected nil
		    :inherit 'tabbar-default
		    :foreground "LightGoldenrod"
		    :background "DarkGreen"
		    :box '(:line-width 2 :color "gray70") 
		    )
(provide 'tabbar-config)
