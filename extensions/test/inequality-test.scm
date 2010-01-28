(define (test-try-ineq ineq)
  (try-inequality ineq (lambda (x) x) (lambda () 'failed)))

(in-test-group
 inequalities

 (define-each-test
   (assert-true (tautological-ineq? (make-tautological-ineq)))
   (assert-true (contradictory-ineq? (make-contradictory-ineq)))

   (assert-true (tautological-ineq?
		 (test-try-ineq (make-inequality '> '(expt x 2)))))
   (assert-true (contradictory-ineq?
		 (test-try-ineq (make-inequality '< '(expt x 2)))))

   (assert-equal
    (make-solved-inequality '< 'y -3)
    (test-try-ineq (make-inequality '< '(+ y 3))))
   (assert-equal
    (make-solved-inequality '< 'y -3/2)
    (test-try-ineq (make-inequality '< '(+ (* 2 y) 3))))
   (assert-equal
    (make-solved-inequality '<= 'x 0)
    (test-try-ineq (make-inequality '<= '(* 23 x))))
   (assert-equal
    (make-solved-inequality '>= 'x 0)
    (test-try-ineq (make-inequality '<= '(* -23 x))))
   (assert-equal
    (make-solved-inequality '< 'x 4/23)
    (test-try-ineq (make-inequality '> '(+ 4 (* -23 x)))))

   (assert-equal
    'failed
    (test-try-ineq (make-inequality '> '(+ x y))))
   (assert-equal
    'failed
    (test-try-ineq (make-inequality '> '(+ 5 (exp y) 8))))
   (assert-equal
    'failed
    (test-try-ineq (make-inequality '> '(+ (expt z 2) z 3))))
   
   (assert-equal '() (simplify-inequalities '()))
   (assert-equal
    (list (make-inequality '> 'x))
    (simplify-inequalities
     (list (make-inequality '> 'x))))
   (assert-equal
    (list (make-solved-inequality '< 'x 5/2))
    (simplify-inequalities
     (list (make-inequality '< '(- x 4))
	   (make-inequality '< '(- (* 2 x) 5)))))
   (assert-equal
    (list (make-solved-inequality '< 'y 4)
	  (make-solved-inequality '< 'x 5/2))
    (simplify-inequalities
     (list (make-inequality '< '(- y 4))
	   (make-inequality '< '(- (* 2 x) 5)))))

   (assert-equal
    (list (make-solved-inequality '< 'x 4))
    (simplify-inequalities
     (list (make-inequality '< '(- x 4))
	   (make-inequality '<= '(- (* 2 x) 8)))))
   (assert-equal
    (list (make-solved-inequality '< 'x 4)
	  (make-inequality '>= '(+ (expt z 2) z 2)))
    (simplify-inequalities
     (list (make-inequality '< '(- x 4))
	   (make-inequality '>= '(+ z 2 (* z z)))
	   (make-inequality '<= '(- (* 2 x) 8)))))

   (assert-equal
    (list (make-solved-inequality '>= 'y 4)
	  (make-solved-inequality '< 'x 5/2))
    (simplify-inequalities
     (list (make-inequality '>= '(- y 4))
	   (make-inequality '< '(- (* 2 x) 5)))))
   (assert-equal
    #f
    (simplify-inequalities
     (list (make-inequality '>= '(- x 4))
	   (make-inequality '< '(- (* 2 x) 5)))))
   (assert-equal
    #f
    (simplify-inequalities
     (list (make-inequality '>= '(- x 4))
	   (make-inequality '>= '(+ z 2 (* z z)))
	   (make-inequality '< '(- (* 2 x) 5)))))
   (assert-equal
    '()
    (simplify-inequalities
     (list (make-inequality '>= '(+ (* 3 x) (* -2 x) (* -1 x) 4)))))
   (assert-equal
    #f
    (simplify-inequalities
     (list (make-inequality '>= '(+ (* 3 x) (* -2 x) (* -1 x) 4))
	   (make-inequality '>= '(+ (* 3 y) (* -2 y) (* -1 y) -4)))))
   
   (assert-equal
    (make-inequality '< -1)
    (transitive-ineq (make-solved-inequality '> 'x 4)
		     (make-solved-inequality '< 'x 5)))

   ))
 

