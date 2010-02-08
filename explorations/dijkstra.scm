(defhandler generic-unpack
  (lambda (upper-bound function)
    (make-upper-bound (generic-bind (upper-bound-content upper-bound) function)))
  upper-bound?)

(defhandler generic-flatten
  (lambda (upper-bound) nothing)
  (lambda (thing)
    (and (upper-bound? thing) (nothing? (upper-bound-content thing)))))

(defhandler generic-flatten
  (lambda (upper-bound)
    (generic-flatten
     (make-upper-bound (upper-bound-content (upper-bound-content thing)))))
  (lambda (thing)
    (and (upper-bound? thing) (upper-bound? (upper-bound-content thing)))))

(define (merge-upper-bounds upper-bound1 upper-bound2)
  (if (<= (upper-bound-content upper-bound1)
	  (upper-bound-content upper-bound2))
      upper-bound1
      upper-bound2))

(defhandler merge merge-upper-bound upper-bound? upper-bound?)

(define (edge-propagator-1 length)
  (function->propagator-constructor
   (nary-unpacking
    (lambda (tail-distance)
      (generic-+ tail-distance length)))))

(define (edge-propagator-2 length tail-cell head-cell)
  (let-cell length-cell
    ((constant length) length-cell)
    (adder length-cell tail-cell head-cell)))
