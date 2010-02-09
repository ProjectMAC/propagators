(define (self-relatively thunk)
  (if (current-eval-unit #f)
      (with-working-directory-pathname
       (directory-namestring (current-load-pathname))
       thunk)
      (thunk)))

(define (load-relative filename)
  (self-relatively (lambda () (load filename))))

(load-relative "../support/load")

(for-each load-relative-compiled
  '("scheduler"
    "core"
    "generic-definitions"
    "intervals"
    "premises"
    "supported-values"
    "truth-maintenance"
    "contradictions"
    "search"
    "amb-utils"
    "compound-data"
    "example-networks"))
