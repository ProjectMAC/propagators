(in-test-group
 functional-reactive

 (define-each-check
   (generic-match #(frp seconds 0) (make-frpremise 'seconds 0)))

 (define-test (glitch)
   (interaction
    (initialize-scheduler)
    (define-cell one)
    (define-cell seconds)
    (define-cell seconds+one)
    (adder one seconds seconds+one)
    (add-content one 1)
    (add-content seconds (make-frs 0 (make-frpremise 'seconds 0)))
    (run)
    (content seconds+one)
    (produces #(frs 1 (#(frp seconds 0))))

    (define-cell seconds+one-again)
    (define-cell glitchable)
    (<? seconds seconds+one-again glitchable)
    (add-content seconds+one-again (content seconds+one))
    (run)
    (content glitchable)
    (produces #(frs #t (#(frp seconds 0))))
   
    (add-content seconds (make-frs 1 (make-frpremise 'seconds 1)))
    (content seconds)
    (produces #(frs 1 (#(frp seconds 1))))
    (run)
    (content seconds+one)
    (produces #(frs 2 (#(frp seconds 1))))
    ;; Rather than glitching, it should notice that its input is out of
    ;; date
    (content glitchable)
    (produces #(frs #t (#(frp seconds 0))))

    ;; But when updated, it should propagate
    (add-content seconds+one-again (content seconds+one))
    (run)
    (content glitchable)
    (produces #(frs #t (#(frp seconds 1))))))
 )
