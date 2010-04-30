
;; If this
(define-cell x)
(define-cell y (e:+ x 2))

;; is the same as this
(define-cell x)
(define-cell y (e:+ x (e:constant 2)))

;; Why isn't this
(define-cell x)
(define-cell y)
(p:+ x 2 y)

;; the same as this?
(define-cell x)
(define-cell y)
(p:+ x (e:constant 2) y)

;; Here's the crufty form of the latter
(define-cell x)
(define-cell y)
(define-cell two)
((constant 2) two)
(p:+ x two y)

;; Then we can expand
(define-cell z 2)
;; into
(define-cell z (e:constant 2))
;; and
(let-cells ((z 2))
  ...)
;; into
(let-cells ((z (e:constant 2)))
  ...)

;; and the definitions
(define-macro-propagator (p:double x y)
  (p:+ x x y))

(define-macro-propagator (e:double x)
  (let-cell answer
    (p:+ x x answer)
    answer))

;; should allow this
(p:double 2 y)
;; to mean this
(p:double (e:constant 2) y)

;; and this
(define-cell something (e:double 2))
;; to mean this
(define-cell something (e:double (e:constant 2)))

;;; The example at the beginning can become any of

  (define-cell a 3)
  (define-cell b 2)
  (define-cell answer (e:+ a b))
  (run)
  (content answer) ==> 5

----------------------------------------

  (define-cell a (e:constant 3))
  (define-cell b (e:constant 2))
  (define-cell answer (e:+ a b))
  (run)
  (content answer) ==> 5

----------------------------------------

  (define-cell answer (e:+ 3 2))
  (run)
  (content answer) ==> 5

----------------------------------------

  (define-cell answer (+ 3 2))
  (run)
  (content answer) ==> 5


;;; The questions are: Should I do this, or should I insist on
;;; manually supplied e:constant everywhere?  If the latter, should I
;;; give e:constant a shorter name?  This interacts with the idea of
;;; running propagators when they are created --- should
(define-cell foo 3)
(content foo) ==> #(*the-nothing*)
(run)
(content foo) ==> 3
;;; or
(define-cell foo 3)
(content foo) ==> 3
;;; Also, if I move expression-language into core/, should I rewrite
;;; the examples to use it?  Then core/ will cease to be purely an
;;; implementation of my thesis.
