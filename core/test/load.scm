(define (self-relatively thunk)
  (if (current-eval-unit #f)
      (with-working-directory-pathname
       (directory-namestring (current-load-pathname))
       thunk)
      (thunk)))

(define (load-relative filename)
  (self-relatively (lambda () (load filename))))

(for-each load-relative
  '("core-test"
    "dependencies-test"
    "profiler-test"
    "partial-compounds-test"
    "switches-test"
    "abstraction-test"
    "compound-merges-test"
    "barometer-test"))
