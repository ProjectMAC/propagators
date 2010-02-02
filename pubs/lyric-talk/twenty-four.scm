(define (number)
  (uniform-select '(1 2 3 4 5 6 7 8 9)))

(define (operator)
  (uniform-select '(+ - *)))

(define (expression)
  (discrete-select
   ((number)
    3/4)
   ((list (operator) (expression) (expression))
    1/4)))

(define (expression-24)
  (let ((expression (expression)))
#;
    (pp expression)
    (observe! (equal? 24 (eval expression (nearest-repl/environment))))
    (pp expression)
    expression))

(define (find-new-possibility! distribution)
  (let ((starting-determined-density
	 (distribution/determined-density distribution)))
    (distribution/refine-until!
     distribution
     (lambda (distribution)
       (> (distribution/determined-density distribution)
	  starting-determined-density)))))

(define the-distribution
  (stochastic-thunk->distribution expression-24 make-breadth-first-schedule))

(define (poke!)
  (find-new-possibility! the-distribution)
  (pp (map (lambda (pair)
	     (cons (car pair)
		   (map exact->inexact (cdr pair))))
	   (distribution->current-bounds-alist the-distribution))))
