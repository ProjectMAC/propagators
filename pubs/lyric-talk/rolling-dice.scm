
(define (roll-die)
  (discrete-select (1 1/6) (2 1/6) (3 1/6)
		   (4 1/6) (5 1/6) (6 1/6)))

(define (roll-two-dice)
  (+ (roll-die) (roll-die)))
roll-two-dice
(stochastic-thunk->distribution roll-two-dice)
(sample (stochastic-thunk->distribution roll-two-dice))

(pp
 (sort-alist
  (distribution->alist
   (stochastic-thunk->distribution roll-two-dice))))

(pp
 (sort-alist
  (distribution->alist
   (stochastic-thunk->distribution
    (lambda ()
      (let ((face (roll-die)))
	(+ face face)))))))
