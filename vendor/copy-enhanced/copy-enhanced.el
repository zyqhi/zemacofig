
(defun get-point (symbol &optional arg)
  "get the point"
  (funcall symbol arg)
  (point)
  )

(defun copy-thing (begin-of-thing end-of-thing &optional arg)
  "copy thing between beg & end into kill ring"
  (save-excursion
    (let ((beg (get-point begin-of-thing 1))
	  (end (get-point end-of-thing arg)))
      (copy-region-as-kill beg end)))
  )

(defun paste-to-mark(&optional arg)
  "Paste things to mark, or to the prompt in shell-mode"
  (let ((pasteMe 
     	 (lambda()
     	   (if (string= "shell-mode" major-mode)
	       (progn (comint-next-prompt 25535) (yank))
	     (progn (goto-char (mark)) (yank) )))))
    (if arg
	(if (= arg 1)
	    nil
	  (funcall pasteMe))
      (funcall pasteMe))
    ))

;; copy word
(defun copy-word (&optional arg)
  "Copy words at point into kill-ring"
  (interactive "P")
  (copy-thing 'backward-word 'forward-word arg)
  ;;(paste-to-mark arg)
  )
;; copy line
(defun copy-line (&optional arg)
  "Save current line into Kill-Ring without mark the line "
  (interactive "P")
  (copy-thing 'beginning-of-line 'end-of-line arg)
  (message "line copied")
;;  (paste-to-mark arg)
  )
(defun copy-paragraph (&optional arg)
  "Copy paragraphes at point"
  (interactive "P")
  (copy-thing 'backward-paragraph 'forward-paragraph arg)
;;  (paste-to-mark arg)
  )

;; copy string
;; "[ \t] --> 空格或者TAB键"
(defun beginning-of-string(&optional arg)
  "  "
  (re-search-backward "[ \t\(\)]" (line-beginning-position) 3 1)
  (if (looking-at "[\(\)\t ]")  (goto-char (+ (point) 1)) )
  )
(defun end-of-string(&optional arg)
  " "
  (re-search-forward "[ \t\(\)]" (line-end-position) 3 arg)
  (if (looking-back "[\(\)\t ]") (goto-char (- (point) 1)) )
  )

(defun thing-copy-string-to-mark(&optional arg)
  " Try to copy a string and paste it to the mark
     When used in shell-mode, it will paste string on shell prompt by default "
  (interactive "P")
  (copy-thing 'beginning-of-string 'end-of-string arg)
;;  (paste-to-mark arg)
  )

;;
(defun beginning-of-parenthesis(&optional arg)
  "  "
  (re-search-backward "[[<(?\"]" (line-beginning-position) 3 1)
  (if (looking-at "[[<(?\"]")  (goto-char (+ (point) 1)) )
  )
(defun end-of-parenthesis(&optional arg)
  " "
  (re-search-forward "[]>)?\"]" (line-end-position) 3 arg)
  (if (looking-back "[]>)?\"]") (goto-char (- (point) 1)) )
  )

(defun thing-copy-parenthesis-to-mark(&optional arg)
  " Try to copy a parenthesis and paste it to the mark
     When used in shell-mode, it will paste parenthesis on shell prompt by default "
  (interactive "P")
  (copy-thing 'beginning-of-parenthesis 'end-of-parenthesis arg)
;  (paste-to-mark arg)
  )

;(global-set-key (kbd "C-c a")  'thing-copy-parenthesis-to-mark)
(global-set-key (kbd "C-c w") 'copy-word)
(global-set-key (kbd "C-c l") 'copy-line)
(global-set-key (kbd "C-c p") 'copy-paragraph)
(global-set-key (kbd "C-c c") 'thing-copy-string-to-mark)


;;;###autoload
(define-minor-mode copy-enhanced-mode
  "Emacs copy enhanced."
  :lighter " copy enhanced"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c w") 'copy-word)
	    (define-key map (kbd "C-c l") 'copy-line)
	    (define-key map (kbd "C-c w") 'copy-paragraph)
	    (define-key map (kbd "C-c w") 'thing-copy-string-to-mark)
            map)
  )

;;;###autoload
(add-hook 'text-mode-hook 'copy-enhanced-mode)

(provide 'copy-enhanced)
