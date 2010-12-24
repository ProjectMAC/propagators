;;; Exploratory thoughts about propagators that make conclusions based
;;; on not knowing something else.

;;; Here is such a propagator:
(define (ignorance-detector input output)
  (let ((unknown-premise (list 'unknown)))
    (define (effective-nothing? thing)
      (cond ((nothing? thing)
	     #t)
	    ((tms? thing)
	     (effective-nothing? (tms-query thing)))
	    ((v&s? thing)
	     (or (not (v&s-believed? thing))
		 (effective-nothing? (v&s-value thing))))
	    (else
	     #f)))
    (define (ignorance-try)
      (if (effective-nothing? (content input))
	  (bring-in! unknown-premise)
	  (kick-out! unknown-premise)))
    (mark-premise-out! unknown-premise)
    ((constant (make-tms (list (supported #t (list unknown-premise)))))
     output)
    (propagator input ignorance-try)))

;;; One might use it for a rule system like this:

(with-pattern-variables (x y z)
  (let-rules
   (
    (ancestor-bc ((req (supported (pattern (show (?x ancestor ?z))))))
       (let-rules
	(
	 (ancestor-bc0
	  (on-trigger ((c (supported (pattern (?x parent ?z)))))
	   (support (pattern (?x ancestor ?z)) (justify ancestor-bc0 c))))

	 (ancestor-bc1
	  (on-trigger ((c (supported (pattern (?y parent ?z))))
		       (u (unknown (pattern (?x ancestor ?y)))))
	   (support (pattern (show (?x ancestor ?y)))
		    (justify ancestor-bc1 req c u))))

	 (ancestor-bc2
	  (on-trigger ((c (supported (pattern (?x parent ?y))))
		       (u (unknown (pattern (?y ancestor ?z)))))
	   (support (pattern (show (?y ancestor ?z)))
		    (justify ancestor-bc2 req c u))))

	 
	 ;; although the following is always true, it is instantiated
	 ;; only for x, z that have the request req.

	 (ancestor-transitive
	  (on-trigger ((f1 (supported (pattern (?x ancestor ?y))))
		       (f2 (supported (pattern (?y ancestor ?z)))))
	   (support (pattern (?x ancestor ?z))
		    (justify ancestor-transitive f1 f2))))
	 )
	;; These rules are dependent on the request
	(support ancestor-bc0 (justify ancestor-bc req))
	(support ancestor-bc1 (justify ancestor-bc req))
	(support ancestor-bc2 (justify ancestor-bc req))
	
	;; This rule is independent of everything
	(support ancestor-transitive)
	))
    )
   ;; This rule is independent of everything too
   (support ancestor-bc)))

;;; While it is running, a rule system like that might produce
;;; a propagator network that looks something like this:

(let-cells* ((adam-parent-cain #t)
	     (cain-parent-enoch #t)
	     (enoch-parent-irad #t)
	     (irad-parent-mehujael #t)
	     (mehujael-parent-methushael #t)
	     (methushael-parent-lamech #t)
	     (lamech-parent-jabal #t)
	     (lamech-parent-jubal #t)

	     (adam-ancestor-cain)
	     (cain-ancestor-enoch)
	     (adam-ancestor-enoch)
	     (cain-ancestor-adam)
	     (enoch-ancestor-cain)
	     (enoch-ancestor-adam)

	     (show-adam-ancestor-enoch)
	     (show-adam-ancestor-cain)
	     (show-cain-ancestor-enoch)
	     )
  (ancestry-transitive adam-parent-cain cain-ancestor-enoch adam-ancestor-enoch)
  (parent-implies-ancestor adam-parent-cain adam-ancestor-cain)
  (parent-implies-ancestor cain-parent-enoch cain-ancestor-enoch)

  (ancestor-bc1 show-adam-ancestor-enoch
		adam-parent-cain 
		(e:ignorance-detector cain-ancestor-enoch)
		show-cain-ancestor-enoch)

  (ancestor-bc2 show-adam-ancestor-enoch
		cain-parent-enoch 
		(e:ignorance-detector adam-ancestor-cain)
		show-adam-ancestor-cain)
  )

(define (ancestor-bc1 req-cell c-cell u-cell answer-cell)
  (p:and req-cell c-cell u-cell answer-cell))
