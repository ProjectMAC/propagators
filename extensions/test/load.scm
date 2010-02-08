(define (self-relatively thunk)
  (if (current-eval-unit #f)
      (with-working-directory-pathname
       (directory-namestring (current-load-pathname))
       thunk)
      (thunk)))

(define (load-relative filename)
  (self-relatively (lambda () (load filename))))

(load-relative "test-utils")
(load-relative "inequality-test")
(load-relative "symbolics-test")
(load-relative "symbolics-ineq-test")
(load-relative "voltage-divider-test")
(load-relative "bridge-rectifier-test")
(load-relative "functional-reactive-test")
(load-relative "environments-test")
(load-relative "graph-drawing-test")
