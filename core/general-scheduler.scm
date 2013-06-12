;;; A more general scheduler that allows multiple agendas which may be
;;; arranged in priority order.  The identity of an agenda is its oset.

(define (make-general-scheduler starting-policy)
  (let* ((starting-oset (make-eq-oset))
	 (agendas (list (cons starting-oset starting-policy))))

    (define (current-agenda)
      (let lp ((agendas agendas))
	(cond ((null? agendas) #f)
	      ((> (oset-count (caar agendas)) 0)
	       (car agendas))
	      (else (lp (cdr agendas))))))

    (define (run-alerted)
      (let ((ca (current-agenda)))
	(if ca
	    (begin
	      ((cdr ca) (car ca))
	      ;; yield
	      (run-alerted))
	    'done)))

    (define (alert-one propagator #!optional agenda)
      (let ((ca
	     (if (default-object? agenda)
		 (current-agenda)
		 agenda)))
	(if ca
	    (oset-insert (car ca) propagator)
	    (oset-insert starting-oset propagator))))


    (define (clear! #!optional agenda)
      (let ((ca
	     (if (default-object? agenda)
		 (current-agenda)
		 agenda)))
	(if ca (oset-clear! (car ca)))))

    (define (any-alerted?)
      (not (current-agenda)))

    (define (create-agenda policy direction base-agenda)
      (let ((split
	     (split-list (lambda (e) (eq? (car e) base-agenda))
			 agendas))
	    (new-agenda (cons (make-eq-oset) policy)))

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
	    ((eq? message 'current-agenda) (current-agenda))
	    (else (error "Bad message -- MAKE-GENERAL-SCHEDULER"))))

    me))