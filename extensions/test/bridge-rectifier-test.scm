(in-test-group
 bridge-rectifier

 (define-test (consistent-state-test)
   (initialize-scheduler)
   (define victim (make-cell))
   (binary-amb victim)
   (assert-equal
    '(#t #f)
    (map-consistent-states
     (lambda ()
       (v&s-value (tms-query (content victim))))
     victim)))

 ;; This test takes a very long time to run
 #;
 (define-test (plunking-rectifier)
   (initialize-scheduler)

   (define n1 (node 3))
   (define n1t1 (car n1))
   (define n1t2 (cadr n1))
   (define n1t3 (caddr n1))

   (define n2 (node 3))
   (define n2t1 (car n2))
   (define n2t2 (cadr n2))
   (define n2t3 (caddr n2))

   (define n3 (node 3))
   (define n3t1 (car n3))
   (define n3t2 (cadr n3))
   (define n3t3 (caddr n3))

   (define n4 (node 3))
   (define n4t1 (car n4))
   (define n4t2 (cadr n4))
   (define n4t3 (caddr n4))

   (define strength-Vs (make-cell))
   (define Vs (voltage-source strength-Vs))
   (add-content strength-Vs 6)

   (define resistance-R1 (make-cell))
   (define R1 (linear-resistor resistance-R1))
   ((constant 3) resistance-R1)

   (define D12 (ideal-diode))
   (define D42 (ideal-diode))
   (define D31 (ideal-diode))
   (define D34 (ideal-diode))

   (define P1 (Vs n1t1 n4t1))

   (define P2 (D12 n1t2 n2t1))

   (define P3 (D42 n4t2 n2t3))

   (define P4 (D31 n3t1 n1t3))

   (define P5 (D34 n3t3 n4t3))

   (define P6 (R1 n2t2 n3t2))

   (ground n4)

   (define P (make-cell))
   (define P12 (make-cell))
   (define P34 (make-cell))
   (define P56 (make-cell))
   (define P1234 (make-cell))

   (sum-constraint P1 P2 P12)
   (sum-constraint P3 P4 P34)
   (sum-constraint P5 P6 P56)

   (sum-constraint P12 P34 P1234)
   (sum-constraint P1234 P56 P)

   (define all-cells
     (list (potential n1t1) (current n1t1)
	   (current n1t2) (current n1t3)

	   (potential n2t1) (current n2t1)
	   (current n2t2) (current n2t3)

	   (potential n3t1) (current n3t1)
	   (current n3t2) (current n3t3)

	   (potential n4t1) (current n4t1)
	   (current n4t2) (current n4t3)

	   P P1 P2 P3 P4 P5 P6))

   (plunker (potential n2t2) 'x)
   (assert-matches
    ;; Note: Only one consistent state
    '(#(symb-ineq #(symbolic 2 #(metadata (x) (((= x 6) ())) ())) () ()))
    (map-consistent-states
     (lambda ()
       (v&s-value (tms-query (content (current n2t2)))))
     all-cells)))

 )
