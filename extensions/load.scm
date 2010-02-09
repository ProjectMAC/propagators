(define (self-relatively thunk)
  (if (current-eval-unit #f)
      (with-working-directory-pathname
       (directory-namestring (current-load-pathname))
       thunk)
      (thunk)))

(define (load-relative filename)
  (self-relatively (lambda () (load filename))))

(load-relative "../core/load.scm")

(for-each load-relative-compiled
 '("expression-language"
   "electric-parts"
   "solve"
   "inequalities"
   "symbolics"
   "symbolics-ineq"
   "functional-reactivity"
   "test-utils"))

(for-each load-relative
 '("environments"
   "graph-drawing"
   "prop-dot"))

