;;; A more general scheduler that allows multiple agendas which may be
;;; arranged in priority order.  The agenda identity is its oset.

(define (make-general-scheduler starting-policy)

  (define agenda-oset car)
  (define agenda-policy cdr)
  (define make-agenda cons)

  (let* ((starting-oset (make-eq-oset))
         (starting-agenda (make-agenda starting-oset starting-policy))
	 (current-agenda starting-agenda)
         (agendas (list current-agenda)))

    (define (next-agenda)
        (let lp ((agendas agendas))
          (cond ((null? agendas) #f)
                ((> (oset-count (agenda-oset (car agendas))) 0)
                 (car agendas))
                (else (lp (cdr agendas))))))
    
    (define (run-alerted)
      (let ((ca (next-agenda)))
	(if ca
	    (begin
              (set! current-agenda ca)
	      ((agenda-policy ca) (agenda-oset ca))
	      ;; yield
	      (run-alerted))
            (begin
              (set! current-agenda starting-agenda)
              'done))))

    (define (alert-one propagator #!optional agenda)
      (let ((ca
	     (if (default-object? agenda) current-agenda agenda)))
	(if ca
	    (oset-insert (agenda-oset ca) propagator)
	    (oset-insert starting-oset propagator))))


    (define (clear! #!optional agenda)
      (let ((ca (if (default-object? agenda) current-agenda agenda)))
	(if ca (oset-clear! (agenda-oset ca)))))

    (define (any-alerted?)
      (next-agenda))

    (define (create-agenda policy direction base-agenda)
      (let ((split
	     (split-list (lambda (e) (eq? (car e) base-agenda))
			 agendas))
	    (new-agenda (make-agenda (make-eq-oset) policy)))

	(if (not split)
	    (error "Undefined base agenda -- CREATE-AGENDA"))
	(case direction
	  ((before)
	   (set! agendas
		 (append (reverse (cons new-agenda (car split)))
			 (list (cadr split))
			 (cddr split))))
	  ((after)
	   (set! agendas
		 (append (reverse (car split))
			 (list (cadr split))
			 (cons new-agenda (cddr split)))))
	  (else (error "Bad direction -- CREATE-AGENDA")))
	(car new-agenda)))		;return the oset.

    (define (me message)
      (cond ((eq? message 'run) (run-alerted))
	    ((eq? message 'alert-one) alert-one)
	    ((eq? message 'clear!) (clear!))  ; Bug!
	    ((eq? message 'done?) (not (any-alerted?)))
	    ((eq? message 'create-agenda) create-agenda)
	    ((eq? message 'current-agenda) current-agenda)
	    (else
             (error "Bad message -- MAKE-GENERAL-SCHEDULER"))))

    me))

(define (lifo-policy oset)
  (let ((the-propagator (oset-pop! oset)))
    (execute-propagator the-propagator)))

(define (make-fifo-scheduler)
  (make-general-scheduler lifo-policy))



(define (fifo-policy oset)
  (let ((the-propagator (oset-pop-tail! oset)))
    (execute-propagator the-propagator)))

(define (make-fifo-scheduler)
  (make-general-scheduler fifo-policy))






(define (split-list p? lst)
  (let lp ((lst lst) (h '()))
    (cond ((null? lst) #f)
          ((p? (car lst))
           (list h (car lst) (cdr lst)))
          (else
           (lp (cdr lst) (cons (car lst) h))))))


(set! make-scheduler make-fifo-scheduler)