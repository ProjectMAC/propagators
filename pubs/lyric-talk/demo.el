(fset 'grab-next-sexp
   (lambda (&optional arg)
     "Keyboard macro C-x o C-SPC M-C-f M-w <right> C-x o C-y"
     (interactive "p")
     (kmacro-exec-ring-item
      (quote ([24 111 67108896 134217734 134217847 right 24 111 25] 0 "%d"))
      arg)))

(define-key global-map [f1] 'grab-next-sexp)
