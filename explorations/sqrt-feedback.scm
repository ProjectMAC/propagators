(define (add-interval x y)
  (make-interval (+ (interval-low x) (interval-low y))
		 (+ (interval-high x) (interval-high y))))
(defhandler generic-+ add-interval interval? interval?)
(defhandler generic-+ (coercing ->interval add-interval) number? interval?)
(defhandler generic-+ (coercing ->interval add-interval) interval? number?)

(define interval-maker
  (function->propagator-constructor (nary-unpacking make-interval)))

;; This assumes that the input is more than 1
(define (sqrt-network input-cell answer-cell)
  (let ((one (make-cell)))
    ((constant 1) one)
    (interval-maker one input-cell answer-cell)
    (heron-step input-cell answer-cell answer-cell)))

(define x (make-cell))
(add-content x 2)
(define sqrt-x (make-cell))
(sqrt-network x sqrt-x)
(run)
;; Oops: raw interval arithmetic loses here:
(content sqrt-x)
; Value: (interval 1. 2.)
