(define (resistor-circuit)
  (let-cells ((R (resistor))
	      (V (voltage-source)))
    (let-cells ((n1 (node (the t1 V) (the t1 R)))
		(n2 (node (the t2 V) (the t2 R))))
      ((constant 3) (the resistance R))
      ((constant 6) (the strength V))
      ((constant 0) (the potential n2))
      (e:inspectable-object R V n1 n2))))

#|
 (initialize-scheduler)
 ;Value: 0

 (define-cell test (resistor-circuit))
 ;Value: test

 (define-cell answer (the current R test))
 ;Value: answer

 (run)
 ;Value: done

 (content answer)
 ;Value: 2
|#
