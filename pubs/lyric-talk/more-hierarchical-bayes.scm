
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

(pp (experiment-result (make-list 20 '(heads))))
