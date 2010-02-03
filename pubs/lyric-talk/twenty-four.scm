
(define (expression)
  (discrete-select
   ((number)
    .75)
   ((list (operator) (expression) (expression))
    .25)))

(define (number)
  (uniform-select '(1 2 3 4 5 6 7 8 9)))

(define (operator)
  (uniform-select '(+ - *)))

(define (expression-24)
  (let ((expression (expression)))
    (observe! (equal? 24 (eval expression (nearest-repl/environment))))
    expression))

(define the-distribution
  (stochastic-thunk->distribution expression-24 make-breadth-first-schedule))

(define (poke!)
  (find-new-possibility! the-distribution)
  (pp (sort-alist (distribution->current-bounds-alist the-distribution))))
