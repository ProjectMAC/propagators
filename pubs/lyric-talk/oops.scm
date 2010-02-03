
(define (oops)
  (let ((x (roll-die)))
    (let ((y (roll-die)))
      (pp (list x y))
      (observe! (= x 3))
      (list x y))))

(pp
 (sort-alist
  (distribution->alist
   (stochastic-thunk->distribution oops))))
