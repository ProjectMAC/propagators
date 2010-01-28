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

(define-syntax interactive-example
  (syntax-rules ()
    ((_ form ...)
     (begin))))

(define-syntax process-examples
  (syntax-rules ()
    ((_ form ...)
     (begin))))

(load-relative-compiled "../testing/load")
(load-relative-compiled "../profiler")

;; Support structures
(load-relative-compiled "eq-properties")
(load-relative-compiled "utils")
(load-relative-compiled "generic-system")
(load-relative-compiled "scheduler")
(load-relative-compiled "data-structure-definitions")
(load-relative-compiled "test-support")

;; System definition
(load-relative-compiled "core")
(load-relative-compiled "dependencies")
(load-relative-compiled "conditionals")
(load-relative-compiled "abstraction")
(load-relative-compiled "compound-data")

;; Extended example
(load-relative-compiled "masyu")
