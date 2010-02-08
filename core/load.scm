(define (compiled-code-type)
  ;; Trying to support the C backend
  (if (lexical-unbound?
       (nearest-repl/environment)
       'compiler:compiled-code-pathname-type)
      "com"
      (compiler:compiled-code-pathname-type)))

(define (cf-conditionally filename)
  (fluid-let ((sf/default-syntax-table (nearest-repl/environment)))
    (sf-conditionally filename))
  (if (not (file-processed? filename "bin" (compiled-code-type)))
      (compile-bin-file filename)))

(define (load-compiled filename)
  (cf-conditionally filename)
  (load filename))

(define (self-relatively thunk)
  (if (current-eval-unit #f)
      (with-working-directory-pathname
       (directory-namestring (current-load-pathname))
       thunk)
      (thunk)))

(define (load-relative-compiled filename)
  (self-relatively (lambda () (load-compiled filename))))

(load-relative-compiled "../support/load")

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
