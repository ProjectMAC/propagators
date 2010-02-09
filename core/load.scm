(define (self-relatively thunk)
  (if (current-eval-unit #f)
      (with-working-directory-pathname
       (directory-namestring (current-load-pathname))
       thunk)
      (thunk)))

(define (load-relative filename)
  (self-relatively (lambda () (load filename))))

(load-relative "../support/load")

(load-relative-compiled "scheduler")
(load-relative-compiled "core")
(load-relative-compiled "generic-definitions")
(load-relative-compiled "intervals")
(load-relative-compiled "premises")
(load-relative-compiled "supported-values")
(load-relative-compiled "truth-maintenance")
(load-relative-compiled "contradictions")
(load-relative-compiled "search")
(load-relative-compiled "amb-utils")
(load-relative-compiled "compound-data")
(load-relative-compiled "example-networks")
