(define (roll-die)
  (discrete-select (1 1/6) (2 1/6) (3 1/6)
		   (4 1/6) (5 1/6) (6 1/6)))


(pp
 (distribution->alist
  (stochastic-thunk->distribution
   (lambda ()
     (+ (roll-die) (roll-die))))))

(pp
 (distribution->alist
  (stochastic-thunk->distribution
   (lambda ()
     (let ((face (roll-die)))
       (+ face face))))))
