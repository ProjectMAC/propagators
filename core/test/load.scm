(define (self-relatively thunk)
  (if (current-eval-unit #f)
      (with-working-directory-pathname
       (directory-namestring (current-load-pathname))
       thunk)
      (thunk)))

(define (load-relative filename)
  (self-relatively (lambda () (load filename))))

(define (disbelieving-func premise thunk)
  (let ((old-belief (premise-in? premise)))
    (kick-out! premise)
    (let ((answer (thunk)))
      (if old-belief
	  (bring-in! premise)
	  (kick-out! premise))
      answer)))

(define-syntax disbelieving
  (syntax-rules ()
    ((_ premise body ...)
     (disbelieving-func premise (lambda () body ...)))))

(define caring-function (nary-unpacking car))
(define switching-function
  (nary-unpacking (lambda (predicate consequent)
		    (if predicate consequent nothing))))

(for-each load-relative
  '("core-test"
    "dependencies-test"
    "profiler-test"
    "partial-compounds-test"
    "switches-test"
    "abstraction-test"
    "compound-merges-test"
    "barometer-test"))
