(define (self-relatively thunk)
  (if (current-eval-unit #f)
      (with-working-directory-pathname
       (directory-namestring (current-load-pathname))
       thunk)
      (thunk)))

(define (load-relative filename)
  (self-relatively (lambda () (load filename))))

(load-relative "../extensions/load.scm")

(for-each 
 load-relative-compiled
 '("masyu"
   "sudoku"
   "riddle-of-the-knights"
   "albatross-conundrum"
   ))
