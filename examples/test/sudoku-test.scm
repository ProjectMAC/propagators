(in-test-group
 sudoku

 (define-test (parse-smoke)
   (initialize-scheduler)
   (check
    (equal?
     "????\n????\n????\n?3??\n"
     (with-output-to-string
       (lambda ()
	 (print-sudoku-board
	  (parse-sudoku
	   '((0 0 0 0) (0 0 0 0) (0 0 0 0) (0 3 0 0)))))))))

 (define-test (solve-smoke)
   (initialize-scheduler)
   (check
    (equal?
     "3124\n2431\n1243\n4312\n"
     (with-output-to-string
       (lambda ()
	 (do-sudoku '((0 1 2 0)
		      (0 0 0 0)
		      (0 0 4 0)
		      (0 3 0 0)))))))
   (check (= 37 *number-of-calls-to-fail*)))

 )
