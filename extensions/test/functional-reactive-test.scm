(in-test-group
 functional-reactive

 (define-each-check
   (generic-match #(frp seconds 0) (make-frpremise 'seconds 0)))

 (define-test (glitch)
   (initialize-scheduler)
   (define-cell one)
   (define-cell seconds)
   (define-cell seconds+one)
   (adder one seconds seconds+one)
   (add-content one 1)
   (add-content seconds (make-frs 0 (make-frpremise 'seconds 0)))
   (run)
   (assert-matches
    #(frs 1 (#(frp seconds 0)))
    (content seconds+one))

   (define-cell seconds+one-again)
   (define-cell glitchable)
   (<? seconds seconds+one-again glitchable)
   (add-content seconds+one-again (content seconds+one))
   (run)
   (assert-matches
    #(frs #t (#(frp seconds 0)))
    (content glitchable))
   
   (add-content seconds (make-frs 1 (make-frpremise 'seconds 1)))
   (assert-matches #(frs 1 (#(frp seconds 1))) (content seconds))
   (run)
   (assert-matches
    #(frs 2 (#(frp seconds 1)))
    (content seconds+one))
   ;; Rather than glitching, it should notice that its input is out of
   ;; date
   (assert-matches
    #(frs #t (#(frp seconds 0)))
    (content glitchable))

   ;; But when updated, it should propagate
   (add-content seconds+one-again (content seconds+one))
   (run)
   (assert-matches
    #(frs #t (#(frp seconds 1)))
    (content glitchable))
   
   ))
