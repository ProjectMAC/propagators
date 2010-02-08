(in-test-group
 partial-compounds

 (define caring-function (nary-unpacking car))

 (define-each-check
   (initialize-scheduler) ;; Why I need this is a mystery to me
   (equal? nothing (caring-function nothing))
   (equal? nothing (caring-function (cons nothing 5)))
   (equal? 3 (caring-function (cons 3 5)))
   (equal? 4 (generic-unpack (cons 4 5) car))

   (generic-match
    #(supported 4 (joe))
    (generic-flatten (supported 4 '(joe))))
   (generic-match
    #(supported 4 (joe))
    (generic-unpack (supported (cons 4 5) '(joe)) car))
   (generic-match
    #(supported 4 (joe))
    (caring-function (supported (cons 4 5) '(joe))))
   (generic-match
    #(supported 4 (harry joe))
    (caring-function (supported (cons (supported 4 '(harry)) 5) '(joe))))
   (generic-match
    #(supported 4 (harry joe))
    (caring-function (supported (cons (supported 4 '(harry))
				      (supported 5 '(george)))
				'(joe))))
   (generic-match
    nothing
    (caring-function (supported (cons nothing 5) '(joe))))

   (generic-match
    #(tms (#(supported 4 (harry joe))))
    (caring-function (make-tms (supported (cons (supported 4 '(harry)) 5) '(joe)))))
   (generic-match
    #(tms (#(supported 4 (harry joe))))
    (caring-function
     (make-tms (supported (cons (make-tms (supported 4 '(harry))) 5) '(joe)))))

   (generic-match
    nothing
    (disbelieving 'joe
     (caring-function
      (make-tms (supported (cons (make-tms (supported 4 '(harry))) 5) '(joe))))))

   (generic-match
    nothing
    (disbelieving 'harry
     (caring-function
      (make-tms (supported (cons (make-tms (supported 4 '(harry))) 5) '(joe))))))

   (generic-match
    #(tms (#(supported 4 (harry joe))))
    (disbelieving 'george
     (caring-function
      (make-tms (supported (cons (make-tms (supported 4 '(harry)))
				 (make-tms (supported 5 '(george))))
			   '(joe))))))

   (generic-match
    nothing
    (caring-function
     (make-tms (supported (cons nothing 4) '(joe)))))

   (generic-match
    #(tms (#(supported #(interval 4 5) (harry joe))))
    (caring-function
     (make-tms
      (supported (cons (make-tms (supported (make-interval 4 5) '(harry))) 5)
		 '(joe)))))
   ))
