(declare (usual-integrations make-cell))

(define (sum-constraint a1 a2 sum)
  (adder a1 a2 sum)
  (subtractor sum a1 a2)
  (subtractor sum a2 a1))

(define (product-constraint m1 m2 product)
  (multiplier m1 m2 product)
  (divider product m1 m2)
  (divider product m2 m1))

(define (quadratic-constraint x x^2)
  (squarer x x^2)
  (sqrter x^2 x))

(define (not-constraint p1 p2)
  (inverter p1 p2)
  (inverter p2 p1))

(define (and-constraint p1 p2 conjunction)
  (conjoiner p1 p2 conjunction)
  (rconjoiner conjunction p1 p2))

(define (or-constraint p1 p2 disjunction)
  (disjoiner p1 p2 disjunction)
  (rdisjoiner disjunction p1 p2))

(define (identity-constraint c1 c2)
  (pass-through c1 c2)
  (pass-through c2 c1))

(define c:+ (functionalize sum-constraint))
(define c:* (functionalize product-constraint))
(define c:not (functionalize not-constraint))
(define c:and (functionalize and-constraint))
(define c:or (functionalize or-constraint))
(define c:identity (functionalize identity-constraint))

(define (c:== . args)
  (let ((lead (car args)))
    (for-each (lambda (arg)
		(identity-constraint lead arg))
	      (cdr args))
    lead))
