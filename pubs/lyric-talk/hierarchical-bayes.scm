
(define (bag-prior)
  (discrete-select ('fair 1/4)
		   ('heads-biased 1/4)
		   ('tails-biased 1/4)
		   ('chaos 1/4)))

(define (coin-in-bag-prior bag-type)
  (case bag-type
    ((fair)
     (discrete-select
      ('fair 98/100) ('heads-biased 1/100) ('tails-biased 1/100)))
    ((heads-biased)
     (discrete-select
      ('fair 1/100) ('heads-biased 98/100) ('tails-biased 1/100)))
    ((tails-biased)
     (discrete-select
      ('fair 1/100) ('heads-biased 1/100) ('tails-biased 98/100)))
    ((chaos)
     (discrete-select
      ('fair 1/3) ('heads-biased 1/3) ('tails-biased 1/3)))))

(define (draw-coin bag-type)
  (let ((coin-type (coin-in-bag-prior bag-type)))
    (coin (coin-weight coin-type))))

(define (experiment data)
  (let ((bag-type (bag-prior)))
    (for-each
     (lambda (coin-data)
       (let ((flip-this-coin (draw-coin bag-type)))
	 (for-each (lambda (coin-datum)
		     (observe! (equal? (flip-this-coin) coin-datum)))
		   coin-data)))
     data)
    bag-type))
(pp (experiment-result '((heads heads))))
(pp (experiment-result '((heads) (heads))))
(pp (experiment-result '((heads heads heads))))
(pp (experiment-result '((heads heads heads heads))))
(pp (experiment-result (list (make-list 20 'heads))))
(pp (experiment-result '((heads) (heads) (heads))))
(pp (experiment-result '((heads) (heads) (heads) (heads))))
