(in-test-group
 profiler
 
 (define-test (smoke)
   (define root (prof:make-node))
   (define sub (prof:subnode root '(foo bar baz)))
   (assert-equal 0 (prof:node-count sub))
   (assert-equal 0 (prof:node-count root))
   (assert-true (eq? sub (prof:subnode root '(foo bar baz))))
   (assert-equal
    '(0 ((foo 0
	      ((bar 0
		    ((baz 0
			  ()
			  #(#f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f)))
		    #(#f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f)))
	      #(#f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f)))
	#(#f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f))
    root)
   (assert-equal '(0 (foo 0 (bar 0 (baz 0)))) (prof:node-as-alists root))
   (define sub2 (prof:subnode root '(foo quux)))
   (prof:node-increment sub2 7)
   (assert-equal 7 (prof:node-count sub2))
   (assert-equal '(0 (foo 0 (quux 7) (bar 0 (baz 0)))) (prof:node-as-alists root))
   (prof:node-increment (prof:subnode root '(foo quux)) 3)
   (assert-equal 10 (prof:node-count sub2))
   (assert-equal '(0 (foo 0 (quux 10) (bar 0 (baz 0)))) (prof:node-as-alists root))
   )

 (define-test (hairy-macro)
   ;; The structure gets built at macro-expansion time, but the
   ;; asserts happen at runtime!
   (define my-node (prof:subnode *prof:statistics* '(hairy-macro-test)))
   (define (show-my-node) (prof:node-as-alists my-node))
   (prof:count (hairy-macro-test foo) 0)
   (prof:count (hairy-macro-test bar) 0)
   (prof:count (hairy-macro-test data) 0)
   (assert-equal '(0 (data 0) (bar 0) (foo 0)) (show-my-node))

   ;; TODO Is there a way to delay macroexpansion so that I can be
   ;; sure that these prof:count macros are not expanded unless
   ;; (and until) the test is actually run?

   ;; Counting
   (prof:count (hairy-macro-test foo))
   (assert-equal '(0 (data 0) (bar 0) (foo 1)) (show-my-node))

   (prof:count (hairy-macro-test foo))
   (assert-equal '(0 (data 0) (bar 0) (foo 2)) (show-my-node))

   ;; Counting by steps
   (prof:count (hairy-macro-test bar) (/ 4 2))
   (assert-equal '(0 (data 0) (bar 2) (foo 2)) (show-my-node))

   ;; Histograms
   (define datum 5)
   (prof:count (hairy-macro-test data ,datum))
   (assert-equal '(0 (data 0 (5 1)) (bar 2) (foo 2)) (show-my-node))
   (for-each (lambda (item)
	       (set! datum item)
	       (prof:count (hairy-macro-test data ,datum)))
	     '(3 5 2 9 5 2))
   (assert-equal '(0 (data 0 (2 2) (3 1) (5 3) (9 1))
		     (bar 2) (foo 2))
		 (show-my-node))

   ;; Dynamic subnote
   (prof:count (hairy-macro-test data ,datum subnote))
   (assert-equal '(0 (data 0 (2 2 (subnote 1)) (3 1) (5 3) (9 1))
		     (bar 2) (foo 2))
		 (show-my-node))
   
   ;; Runtime access to counts
   (prof:count (hairy-macro-test foo) 1
     (lambda (foo-now)
       (assert-equal 3 foo-now)))

   (prof:count (hairy-macro-test foo) 1
     (lambda (foo-now)
       ;; Checking the closure is made in the right environment
       (assert-equal (* datum datum) foo-now)))
   (assert-equal '(0 (data 0 (2 2 (subnote 1)) (3 1) (5 3) (9 1))
		     (bar 2) (foo 4))
		 (show-my-node))
   (assert-equal '((data (2 2 (subnote 1)) (3 1) (5 3) (9 1))
		   (bar 2) (foo 4))
		 (prof:node-clean-copy my-node))

   (prof:reset-stats! '(hairy-macro-test data))
   (assert-equal '(0 (data 0 (2 0 (subnote 0)) (3 0) (5 0) (9 0))
		     (bar 2) (foo 4))
		 (show-my-node))
   (assert-equal '((bar 2) (foo 4)) (prof:node-clean-copy my-node))

   ;; This is dangerous, because it breaks prof:counts that depend on
   ;; a fixed subitem of (hairy-macro-test data).  But the present
   ;; test doesn't have any of those.
   (prof:clear-stats! '(hairy-macro-test data))
   (assert-equal '(0 (data 0) (bar 2) (foo 4)) (show-my-node))
   (assert-equal '((bar 2) (foo 4)) (prof:node-clean-copy my-node))
   )
 )
