(in-test-group
 environments

 (let* ((base (make-frame '()))
	(derived (make-frame (list base)))
	(base-content (make-interval 3 10))
	(derived-content (make-interval 5 15))
	(base-only
	 (alist->virtual-copies `((,base . ,base-content))))
	(derived-only
	 (alist->virtual-copies `((,derived . ,derived-content))))
	(base-and-derived
	 (alist->virtual-copies
	  `((,base . ,base-content)
	    (,derived . ,derived-content)))))
   (define-each-check
     (equal? (list derived base) (frame-ancestors derived))
     (equal?
      base-content (direct-frame-content base-and-derived base))
     (equal?
      derived-content (direct-frame-content base-and-derived derived))
     (equal? base-content (full-frame-content base-and-derived base))
     (equal? (merge base-content derived-content)
		   (full-frame-content base-and-derived derived))
     (equal?
      nothing (direct-frame-content base-and-derived (make-frame '())))
     (equal?
      nothing (full-frame-content base-and-derived (make-frame '())))

     (lexical-invariant? base-only)
     (lexical-invariant? derived-only)
     (not (lexical-invariant? base-and-derived))
     (acceptable-frame? derived (list base-only derived-only))
     (good-frame? derived (list base-only derived-only))

     (v-c-equal? base-and-derived (merge base-only derived-only))
     (eq? base-and-derived (merge base-only base-and-derived))
     (eq? base-and-derived
	  (merge (make-virtual-copies `((,base . ,(make-interval 2 12))))
		 base-and-derived))

     (equal? `((,base . ,(make-interval 9 100)))
      (virtual-copies->alist
       ((v-c-i/o-unpacking generic-square) base-only base-only)))
     (equal? `((,derived . ,(make-interval 9 100)))
      (virtual-copies->alist
       ((v-c-i/o-unpacking generic-square)
	base-only derived-only)))
     (equal? `((,derived . ,(make-interval 25 225)))
      (virtual-copies->alist
       ((v-c-i/o-unpacking generic-square)
	derived-only derived-only)))
     (equal? `((,base . ,(make-interval 25 225)))
      (virtual-copies->alist
       ((v-c-i/o-unpacking generic-square)
	derived-only base-only)))

     (equal? `((,base . ,(make-interval 9 100)))
      (virtual-copies->alist
       ((v-c-i/o-unpacking generic-*)
	base-only base-only base-only)))
     (equal? `((,base . ,(make-interval 15 150)))
      (virtual-copies->alist
       ((v-c-i/o-unpacking generic-*)
	base-only derived-only base-only)))
     (equal? `((,derived . ,(make-interval 15 150)))
      (virtual-copies->alist
       ((v-c-i/o-unpacking generic-*)
	derived-only base-only derived-only)))
     (equal? `((,derived . ,(make-interval 9 100)))
      (virtual-copies->alist
       ((v-c-i/o-unpacking generic-*)
	base-only base-only derived-only)))
     ))

 (define-test (interior-propagator-smoke)
   (initialize-scheduler)
   (define four (make-cell))
   (define zero (make-cell))
   (define same (make-cell))
   (vc:=? four zero same)

   (define repl-frame (make-frame '()))
   (add-content four (alist->virtual-copies `((,repl-frame . 4))))
   (add-content zero (alist->virtual-copies `((,repl-frame . 0))))
   (add-content same (alist->virtual-copies `((,repl-frame . ,nothing))))
   (run)
   (check (equal? `((,repl-frame . #f))
		  (virtual-copies->alist (content same))))
   )

 (define-test (call-site-smoke)
   (initialize-scheduler)
   (define in-squaree  (make-cell))
   (define in-square   (make-cell))
   (vc:squarer in-squaree in-square)

   (define repl-frame  (make-frame '()))
   (define out-squaree (make-cell))
   (define out-square  (make-cell))
   (call-site (list out-squaree out-square)
	      (make-closure (list in-squaree in-square) '() '()))
   (add-content out-squaree
     (alist->virtual-copies `((,repl-frame . 4))))
   (add-content out-square
     (alist->virtual-copies `((,repl-frame . ,nothing))))
   (run)
   (check (equal? `((,repl-frame . 16))
		  (virtual-copies->alist (content out-square)))))

 (define-test (factorial)
   (initialize-scheduler)

   ;; Definition of factorial
   (define in-n (make-cell))
   (define in-n! (make-cell))

   (define zero (make-cell))
   (define control (make-cell))
   (define not-control (make-cell))
   (define one (make-cell))
   (define n-again (make-cell))
   (define n-1 (make-cell))
   (define n-1! (make-cell))
   (define empty (make-cell))

   (define fact
     (make-closure
      (list in-n in-n!)
      (list zero control not-control one n-again n-1 n-1! empty)
      '()))				; No global environment yet

   ((vc:const 0) zero)
   ((vc:const 1) one)
   (vc:=? in-n zero control)
   (vc:inverter control not-control)
   (vc:switch control one in-n!)
   (vc:switch not-control in-n n-again)
   (vc:subtractor n-again one n-1)
   (call-site (list n-1 n-1!) fact)
   (vc:multiplier n-1! in-n in-n!)

   ;; Use
   (define repl-frame  (make-frame '()))
   (define out-n (make-cell))
   (define out-n! (make-cell))
   (call-site (list out-n out-n!) fact)
   (add-content out-n  (alist->virtual-copies `((,repl-frame . 4))))
   (add-content out-n! (alist->virtual-copies `((,repl-frame . ,nothing))))
   (run)
   (check (equal? `((,repl-frame . 24))
		  (virtual-copies->alist (content out-n!))))
   )

 (define-test (iterative-factorial)
   ;; TODO Of course, for this to really be iterative, we need to
   ;; flatten chains of virtual bridges that have no further effect
   ;; (except passing things through switches and such).  An
   ;; approximation of the fully-determined? predicate might be
   ;; helpful.
   (initialize-scheduler)

   ;; Definition of iterative factorial loop
   (define in-accum (make-cell))
   (define in-n (make-cell))
   (define out (make-cell))

   (define one (make-cell))
   (define done (make-cell))
   (define not-done (make-cell))
   (define recur-accum (make-cell))
   (define accum-again (make-cell))
   (define n-again (make-cell))
   (define out-again (make-cell))
   (define n-1 (make-cell))

   (define fact-iter-loop
     (make-closure
      (list in-accum in-n out)
      (list one done not-done recur-accum accum-again n-again out-again n-1)
      '())) 				; No global environment yet

   ((vc:const 1) one)
   (vc:=? in-n one done)
   (vc:inverter done not-done)
   (vc:switch done in-accum out)
   (vc:switch not-done in-accum accum-again)
   (vc:switch not-done in-n n-again)
   (vc:switch not-done out-again out)
   (vc:subtractor n-again one n-1)
   (vc:multiplier accum-again n-again recur-accum)
   (call-site (list recur-accum n-1 out-again) fact-iter-loop)

   ;; Definition of iterative factorial start
   (define n (make-cell))
   (define n! (make-cell))
   (define init-accum (make-cell))
   (define fact-start
     (make-closure (list n n!) (list init-accum) '()))

   ((vc:const 1) init-accum)
   (call-site (list init-accum n n!) fact-iter-loop)

   ;; Use
   (define repl-frame (make-frame '()))
   (define my-n (make-cell))
   (define my-n! (make-cell))
   (call-site (list my-n my-n!) fact-start)
   (add-content my-n  (alist->virtual-copies `((,repl-frame . 5))))
   (add-content my-n! (alist->virtual-copies `((,repl-frame . ,nothing))))
   (run)
   (check (equal? `((,repl-frame . 120))
		  (virtual-copies->alist (content my-n!))))
   )

 (define-test (fibonacci)
   (interaction
    (initialize-scheduler)
    ;; Definition of fibonacci
    (define-cell in-n)
    (define-cell fib-n)
   
    (define-cell one)
    (define-cell two)
    (define-cell recur)
    (define-cell not-recur)
    (define-cell n-again)
    (define-cell n-1)
    (define-cell n-2)
    (define-cell fib-n-1)
    (define-cell fib-n-2)
   
    (define fib
      (make-closure
       (list in-n fib-n)
       (list one two recur not-recur n-again n-1 n-2 fib-n-1 fib-n-2)
       '()))

    ((vc:const 1) one)
    ((vc:const 2) two)
    (vc:<? in-n two not-recur)
    (vc:inverter not-recur recur)
    (vc:switch not-recur one fib-n)
    (vc:switch recur in-n n-again)
    (vc:subtractor n-again one n-1)
    (call-site (list n-1 fib-n-1) fib)
    (vc:subtractor n-again two n-2)
    (call-site (list n-2 fib-n-2) fib)
    (vc:adder fib-n-1 fib-n-2 fib-n)

    ;; Use
    (define repl-frame (make-frame '()))
    (define-cell my-n)
    (define-cell my-fib-n)
    (call-site (list my-n my-fib-n) fib)
    (add-content my-n  (alist->virtual-copies `((,repl-frame . 5))))
    (add-content my-fib-n (alist->virtual-copies `((,repl-frame . ,nothing))))
    (run)
    (virtual-copies->alist (content my-fib-n))
    (produces `((,repl-frame . 8)))
    ))

 (define-test (fibonacci-again)
   (interaction
    (initialize-scheduler)
    (define fib
      (let-cells (in-n fib-n one two recur not-recur
		       n-again n-1 n-2 fib-n-1 fib-n-2)
   	(define fib
	  (make-closure
	   (list in-n fib-n)
	   (list one two recur not-recur n-again n-1 n-2 fib-n-1 fib-n-2)
	   '()))

	((vc:const 1) one)
	((vc:const 2) two)
	(vc:<? in-n two not-recur)
	(vc:inverter not-recur recur)
	(vc:switch not-recur one fib-n)
	(vc:switch recur in-n n-again)
	(vc:subtractor n-again one n-1)
	(call-site (list n-1 fib-n-1) fib)
	(vc:subtractor n-again two n-2)
	(call-site (list n-2 fib-n-2) fib)
	(vc:adder fib-n-1 fib-n-2 fib-n)
	fib))

    (define repl-frame (make-frame '()))
    (define-cell n)
    (define-cell fib-n)
    (call-site (list n fib-n) fib)
    (add-content n  (alist->virtual-copies `((,repl-frame . 4))))
    (add-content fib-n (alist->virtual-copies `((,repl-frame . ,nothing))))
    (run)
    (virtual-copies->alist (content fib-n))
    (produces `((,repl-frame . 5)))
    ))

 (define-test (euclid)
   (interaction
    (initialize-scheduler)
    (define quot-rem
      (let-cells (dividend divisor quot rem)
	(vc:quotient dividend divisor quot)
	(vc:remainder dividend divisor rem)
	(make-closure (list dividend divisor quot rem) '() '())))
    (define euclid
      (let-cells (a b gcd zero recur not-recur
		    a-again b-again a-mod-b a-quot-b gcd-again)
	(define euclid
	  (make-closure 
	   (list a b gcd)
	   (list zero recur not-recur a-again b-again a-mod-b a-quot-b gcd-again)
	   '()))
	((vc:const 0) zero)
	(vc:=? b zero not-recur)
	(vc:inverter not-recur recur)
	(vc:switch not-recur a gcd)
	(vc:switch recur a a-again)
	(vc:switch recur b b-again)
	(call-site (list a-again b-again a-quot-b a-mod-b) quot-rem)
	(call-site (list b-again a-mod-b gcd-again) euclid)
	(vc:switch recur gcd-again gcd)
	euclid))

    (define repl-frame (make-frame '()))
    (define-cell a)
    (define-cell b)
    (define-cell gcd-a-b)
    (call-site (list a b gcd-a-b) euclid)
    (add-content a (alist->virtual-copies `((,repl-frame . ,(* 17 3)))))
    (add-content b (alist->virtual-copies `((,repl-frame . ,(* 17 5)))))
    (add-content gcd-a-b (alist->virtual-copies `((,repl-frame . ,nothing))))
    (run)
    (virtual-copies->alist (content gcd-a-b))
    (produces `((,repl-frame . 17)))
    ))
 ;; TODO (lambda (x) (lambda (y) (+ x y))); compose; (repeat f n)

)
