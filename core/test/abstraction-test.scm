(in-test-group
 abstraction

 
 (define-test ()

  (interaction
   (initialize-scheduler)
   (define x (make-cell))
   (define guess (make-cell))
   (define better-guess (make-cell))

   (heron-step x guess better-guess)

   (add-content x 2)
   (add-content guess 1.4)
   (run)
   (content better-guess)
   (produces 1.4142857142857141)
   ))

 
 (define-test ()

  (interaction
   (initialize-scheduler)
   (define x (make-cell))
   (define answer (make-cell))

   (sqrt-network x answer)

   (add-content x 2)
   (run)
   (content answer)
   (produces 1.4142135623746899)
   )))
