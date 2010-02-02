(define (prior)
  (discrete-select ('fair 98/100)
		   ('heads-only 1/100)
		   ('tails-only 1/100)))

(define (likelihood-model hypothesis datum)
  (likelihood! (case hypothesis
		 ((fair) 0.5)
		 ((heads-only) (if (eq? 'tails datum) 0 1.))
		 ((tails-only) (if (eq? 'heads datum) 0 1.)))))

(define (posterior data)
  (stochastic-thunk->distribution
   (lambda ()
     (let ((hypothesis (prior)))
       (for-each (lambda (datum)
		   (likelihood-model hypothesis datum))
		 data)
       hypothesis))))


(pp (distribution->alist (posterior '(heads))))
(pp (distribution->alist (posterior '(heads heads))))
(pp (distribution->alist (posterior '(heads heads heads))))
(pp (distribution->alist (posterior '(heads heads heads heads))))
(pp (distribution->alist (posterior (make-list 10 'heads))))
(pp (distribution->alist (posterior (make-list 100 'heads))))

