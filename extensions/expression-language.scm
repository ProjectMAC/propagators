(declare (usual-integrations make-cell cell?))

(define %% (list 'the-implicit-cell))
(define (implicit-cell? thing)
  (eq? thing 'the-implicit-cell))

(define (->cell thing)
  (if (or (implicit-cell? thing) (cell? thing))
      thing
      (p:const thing)))

(define (functionalize propagator #!optional num-outputs)
  (if (default-object? num-outputs)
      (set! num-outputs 1))
  (lambda args
    (define inputs (map ->cell args))
    (define outputs '())
    (define (manufacture-cell)
      (let-cell cell
	(set! outputs (cons cell outputs))
	cell))
    (define implicit-cells-present? (any implicit-cell? inputs))
    (define true-inputs
      (if implicit-cells-present?
	  (map (lambda (cell)
		 (if (implicit-cell? cell)
		     (manufacture-cell)
		     cell))
	       inputs)
	  (append inputs (map (lambda (k) (manufacture-cell))
			      (iota num-outputs)))))
    (apply propagator true-inputs)
    (if (= 1 (length outputs))
	(car outputs)
	;; TODO Maybe (reverse outputs) here?
	(apply values outputs))))

(define (p:const value)
  (let-cell answer
    ((constant value) answer)
    answer))
(define p:+ (functionalize adder))
(define p:- (functionalize subtractor))
(define p:* (functionalize multiplier))
(define p:/ (functionalize divider))
(define p:abs (functionalize absolute-value))
(define p:square (functionalize squarer))
(define p:sqrt (functionalize sqrter))
(define p:= (functionalize =?))
(define p:< (functionalize <?))
(define p:> (functionalize >?))
(define p:<= (functionalize <=?))
(define p:>= (functionalize >=?))
(define p:not (functionalize inverter))
(define p:and (functionalize conjoiner))
(define p:or (functionalize disjoiner))
(define p:switch (functionalize switch))
(define (p:amb)
  (let-cell answer
    (binary-amb answer)
    answer))

(define (flat-function->propagator-expression f)
  (functionalize (function->propagator-constructor (nary-unpacking f))))

(define p:eq? (flat-function->propagator-expression eq?))
(define p:expt (flat-function->propagator-expression expt))

(define c:+ (functionalize sum-constraint))
(define c:* (functionalize product-constraint))
(define c:not (functionalize not-constraint))
(define c:identity (functionalize identity-constraint))
; (define c:and (functionalize and-constraint))
; (define c:or (functionalize or-constraint))

(define (c:== . args)
  (let ((lead (car args)))
    (for-each (lambda (arg)
		(identity-constraint lead arg))
	      (cdr args))
    lead))
