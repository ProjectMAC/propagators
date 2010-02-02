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

(define (coin-weight type)
  (case type
    ((fair) 1/2)
    ((heads-biased) 9/10)
    ((tails-biased) 1/10)
    (else
     (error "Bogus coin type" type))))

(define (coin weight)
  (lambda ()
    (discrete-select ('heads weight) ('tails (- 1 weight)))))

(define (draw-coin bag-type)
  (let ((coin-type (coin-in-bag-prior bag-type)))
    (coin (coin-weight coin-type))))

(define (experiment data)
  (let ((bag-type (bag-prior)))
    (for-each (lambda (coin-data)
		(let ((flip-this-coin (draw-coin bag-type)))
		  (for-each (lambda (coin-datum)
			      (observe! (equal? (flip-this-coin) coin-datum)))
			    coin-data)))
	      data)
    bag-type))

(define (experiment-result data)
  (map (lambda (pair)
	 (cons (car pair)
	       (exact->inexact (cdr pair))))
       (distribution->alist
	(stochastic-thunk->distribution
	 (lambda ()
	   (experiment data))))))

(define (integrate-out thunk)
  (distribution-splice
   (let ((thunk-distribution (stochastic-thunk->distribution thunk)))
     (distribution/determine! thunk-distribution)
     thunk-distribution)))

(define (for-each-integrating-out proc lst)
  (integrate-out
   (lambda ()
     (if (null? lst)
	 'done
	 (begin
	   (for-each-integrating-out proc (cdr lst))
	   (proc (car lst)))))))

(define (experiment data)
  (let ((bag-type (bag-prior)))
    (for-each-integrating-out
     (lambda (coin-data)
       (let ((flip-this-coin (draw-coin bag-type)))
	 (for-each (lambda (coin-datum)
		     (observe! (equal? (flip-this-coin) coin-datum)))
		   coin-data)))
     data)
    bag-type))
