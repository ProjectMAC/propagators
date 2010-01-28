(in-test-group
 symbolics
 
 (define-each-test
   (assert-matches
    #(symbolic x #(metadata (x) () ()))
    (variable->symbolic 'x))

   (assert-matches
    #(symbolic -1 #(metadata (x) (((= x -1) ())) ()))
    (merge (make-symbolic 'x (make-symbolic-metadata '(x) '() '()))
	   (make-symbolic '(+ (* 2 x) 1) (make-symbolic-metadata '(x) '() '()))))

   (assert-matches
    #(symbolic -11
      #(metadata (x z y) (((= z -12) ()) ((= x -1) ()) ((= y -4) ())) ()))
    (merge (make-symbolic '(+ (* 2 x) 3 z)
	    (make-symbolic-metadata '(x z) '(((= y (* 4 x)) ())) '()))
	   (make-symbolic '(- y 7)
	    (make-symbolic-metadata '(y) '(((= x (+ 3 y)) ())) '()))))

   (assert-matches
    #(symbolic x #(metadata (x) () ()))
    (merge (make-symbolic 'x (make-symbolic-metadata '(x) '() '()))
	   (make-symbolic 'x (make-symbolic-metadata '(x) '() '()))))

   (assert-equal
    nothing
    ((nary-unpacking +) (make-symbolic 'x (empty-metadata)) nothing))))
