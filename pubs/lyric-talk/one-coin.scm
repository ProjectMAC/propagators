(define (coin-prior)
  (discrete-select ('fair 98/100)
		   ('heads-biased 1/100)
		   ('tails-biased 1/100)))

(define (coin-weight type)
  (case type
    ((fair) .5)
    ((heads-biased) .9)
    ((tails-biased) .1)
    (else
     (error "Bogus coin type" type))))

(define (coin weight)
  (lambda ()
    (discrete-select ('heads weight) ('tails (- 1 weight)))))

(define (experiment data)
  (let ((hypothesis (coin-prior)))
    (let ((flip-the-coin (coin (coin-weight hypothesis))))
      (for-each (lambda (datum)
		  (observe! (equal? (flip-the-coin) datum)))
		data)
      hypothesis)))

(define (experiment-result data)
  (sort-alist
   (distribution->alist
    (stochastic-thunk->distribution
     (lambda ()
       (experiment data))))))


(pp (experiment-result '()))
(pp (experiment-result '(heads)))
(pp (experiment-result '(heads heads)))
(pp (experiment-result '(heads heads heads)))
(pp (experiment-result '(heads heads heads heads)))
(pp (experiment-result (make-list 10 'heads)))
(pp (experiment-result (make-list 100 'heads)))

