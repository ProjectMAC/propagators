(in-test-group
 symbolics-ineq

 (define-each-test
   (assert-matches
    (vector 'symb-ineq nothing '((< me 5 (me)) (> me 4 (me))) '())
    (real-symb-ineq-merge
     (make-symb-ineq
      nothing
      (list (%make-inequality '< 'me 5))
      '())
     (make-symb-ineq
      nothing
      (list (%make-inequality '> 'me 4))
      '())
     ))

   (assert-matches
    (vector 'symb-ineq nothing '((< me 5 (me)) (> me 4 (me))) '())
    (merge
     (make-symb-ineq
      nothing
      (list (%make-inequality '< 'me 5))
      '())
     (make-symb-ineq
      nothing
      (list (%make-inequality '> 'me 4))
      '())
     ))

   (assert-matches
    the-contradiction
    (merge
     (make-symb-ineq
      nothing
      (list (%make-inequality '< 'me 5))
      '())
     (make-symb-ineq
      nothing
      (list (%make-inequality '> 'me 6))
      '())
     ))

   (assert-matches
    #(symb-ineq #(symbolic 4 #(metadata () () ())) () ())
    (merge
     (make-symb-ineq
      nothing
      (list (%make-inequality '< 'me 5))
      '())
     (make-symb-ineq
      (make-symbolic 4 (empty-metadata))
      '()
      '())
     ))

   (assert-matches
    the-contradiction
    (merge
     (make-symb-ineq
      nothing
      '()
      (list (%make-inequality '< 'x 5)))
     (make-symb-ineq
      nothing
      '()
      (list (%make-inequality '> 'x 6)))
     ))

   (assert-matches
    the-contradiction
    (merge
     (make-symb-ineq
      (make-symbolic 4 (empty-metadata))
      '()
      (list (%make-inequality '< 'x 5)))
     (make-symb-ineq
      (make-symbolic 4 (empty-metadata))
      '()
      (list (%make-inequality '> 'x 6)))
     ))

   (assert-matches
    #(symb-ineq #(symbolic 4 #(metadata () () ()))
		()
		((< x 5 (x))))
    (merge
     (make-symb-ineq
      (make-symbolic 4 (empty-metadata))
      '()
      (list (%make-inequality '< 'x 5)))
     (make-symb-ineq
      (make-symbolic 4 (empty-metadata))
      '()
      '())
     ))
   
   (assert-matches
    the-contradiction
    (merge
     (make-symb-ineq
      (make-symbolic 4 (empty-metadata)) '() '())
     (make-symb-ineq
      (make-symbolic 5 (empty-metadata)) '() '())
     ))

   (assert-matches
    #(symb-ineq #(symbolic v #(metadata (v) () ()))
		()
		((< v 5 (v))))
    (merge
     (make-symb-ineq
      nothing
      (list (%make-inequality '< 'me 5))
      '())
     (make-symb-ineq
      (variable->symbolic 'v)
      '()
      '())
     ))

   (assert-matches
    #(symb-ineq #(symbolic v #(metadata (v) () ()))
		()
		((> v 0 (v))))
    (merge
     (make-symb-ineq
      nothing
      (list (%make-inequality '< 'me '(* 2 v)))
      '())
     (make-symb-ineq
      (variable->symbolic 'v)
      '()
      '())
     ))

   (assert-matches
    the-contradiction
    (merge
     (make-symb-ineq
      (variable->symbolic 'v)
      '()
      (list (%make-inequality '> 'v 6)))
     (make-symb-ineq
      nothing
      (list (%make-inequality '< 'me '2))
      '())
     ))

   (assert-matches
    #(symb-ineq #(*the-nothing*)
		((> me v (me v))
		 (< me 2 (me)))
		((< v 2 (v))))
    (merge
     (make-symb-ineq
      nothing
      (list (%make-inequality '> 'me 'v))
      '())
     (make-symb-ineq
      nothing
      (list (%make-inequality '< 'me '2))
      '())
     ))

   (assert-matches
    #(symb-ineq #(symbolic w #(metadata (v w) (((= v (* 4 w)) ())) ()))
		()
		((> w 0 (w))
		 (< w 1/2 (w))))
    (merge
     (make-symb-ineq
      (make-symbolic
       'w
       (make-symbolic-metadata
	'(v w)
	'(((= v (* 4 w)) ()))
	'()))
      '()
      (list (%make-inequality '> 'w 0)))
     (make-symb-ineq
      nothing
      '()
      (list (%make-inequality '< 'v '2)))
     ))

   (assert-matches
    #(symb-ineq #(symbolic w #(metadata (v w) (((= v (* 4 w)) ())) ()))
		()
		((> w 0 (w))))
    (merge
     (make-symb-ineq
      (make-symbolic
       'w
       (make-symbolic-metadata
	'(v w)
	'(((= v (* 4 w)) ()))
	'()))
      '()
      (list (%make-inequality '> 'w 0)))
     (make-symb-ineq
      nothing
      (list (%make-inequality '< 'me 'v))
      '())
     ))

   (assert-matches
    the-contradiction
    (merge
     (make-symb-ineq
      (make-symbolic
       'w
       (make-symbolic-metadata
	'(v w)
	'(((= v (* 4 w)) ()))
	'()))
      '()
      (list (%make-inequality '> 'w 0)))
     (make-symb-ineq
      nothing
      (list (%make-inequality '> 'me 'v))
      '())
     ))

   (assert-matches
    #(symb-ineq #(symbolic w #(metadata (v w) (((= v (* 4 w)) ())) ()))
		()
		((< w 0 (w))))
    (merge
     (make-symb-ineq
      (make-symbolic
       'w
       (make-symbolic-metadata
	'(v w)
	'(((= v (* 4 w)) ()))
	'()))
      '()
      '())
     (make-symb-ineq
      nothing
      (list (%make-inequality '> 'me 'v))
      '())
     ))

   )

 (define-test (ineq-enforcer-smoke)
   (initialize-scheduler)
   (define-cell five)
   ((constant (make-tms (supported 5 '(joe)))) five)
   (define-cell victim)
   ((ineq-enforcer '<) five victim)
   ((ineq-enforcer '<) victim five)
   ;; Doesn't detect the contradiction without a plunk
   (assert-equal 'done (run))

   (plunker victim)
   (assert-equal '(contradiction (joe)) (run)))

 (define-test (ineq-constraint-smoke)
   (initialize-scheduler)
   (define-cell four)
   ((constant 4) four)
   (define-cell ctl)
   (define-cell victim)
   (>-constraint ctl four victim)
   ((constant #t) ctl)
   (run)
   (assert-matches
    (vector 'symb-ineq nothing '((< me 4 (me))) '())
    (content victim)))

 (define-test (more-ineq-constraint-smoke)
   (initialize-scheduler)
   (define-cell three)
   ((constant (make-tms (supported 3 '(joe)))) three)
   (define-cell victim)
   (define-cell ctl)
   (<-constraint ctl three victim)
   (>=-constraint ctl three victim)
   ;; Doesn't detect the contradiction without a boolean plunk on the
   ;; control
   (assert-equal 'done (run))

   (binary-amb ctl)
   (assert-equal '(contradiction (joe)) (run)))

 (define-test (even-more-ineq-constraint-smoke)
   (initialize-scheduler)
   (define-cell three)
   ((constant (make-tms (supported 3 '(joe)))) three)
   (define-cell victim1)
   (define-cell victim2)
   (define-cell ctl)
   (<-constraint ctl three victim1)
   (>=-constraint ctl three victim2)
   (define-cell zero)
   ((constant 0) zero)
   (sum-constraint zero victim1 victim2)
   ;; Doesn't detect the contradiction without a boolean plunk on the
   ;; control
   (assert-equal 'done (run))

   (binary-amb ctl)
   ;; Doesn't detect the contradiction without a variable plunk, either
   (assert-equal 'done (run))

   (plunker victim1)

   (assert-equal '(contradiction (joe)) (run)))

 (define-test (even-more-more-ineq-constraint-smoke)
   (initialize-scheduler)
   (define-cell three)
   ((constant (make-tms (supported 3 '(joe)))) three)
   (define-cell victim1)
   (define-cell victim2)
   (define-cell ctl)
   (<-constraint ctl three victim1)
   (>=-constraint ctl three victim2)
   (define-cell zero)
   ((constant 0) zero)
   (sum-constraint zero victim1 victim2)
   ;; Doesn't detect the contradiction without a boolean plunk on the
   ;; control.
   (assert-equal 'done (run))

   (binary-amb ctl)
   ;; Doesn't detect the contradiction without a variable plunk, either 
   (assert-equal 'done (run))

   (define-cell four)
   ((constant 4) four)
   (define-cell x)
   (plunker x)
   (multiplier four x victim1)

   (assert-equal '(contradiction (joe)) (run)))
)
