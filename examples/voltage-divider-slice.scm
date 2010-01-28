(initialize-scheduler)

(define n0 (node 2))
(define n0t1 (car n0))
(define n0t2 (cadr n0))

(define n1 (node 2))
(define n1t1 (car n1))
(define n1t2 (cadr n1))

(define n2 (node 2))
(define n2t1 (car n2))
(define n2t2 (cadr n2))

; (ground n0)
(plunker (potential n0t1))

(define Pv
  ((voltage-source (p:const 6))
   n1t1 n0t1))

(define R1 (p:const 4))

(define PR1
  ((linear-resistor R1) n1t2 n2t1))

(define R2 (p:const 2))

(define PR2
  ((linear-resistor R2) n2t2 n0t2))

(define power (p:+ Pv (p:+ PR1 PR2)))

;;; A slice

(define n1t2* (clone-terminal n1t2))

(define n0t2* (clone-terminal n0t2))

(define R1+R2 (make-cell))
  
(sum-constraint R1 R2 R1+R2)


;;; Note that PRS does not contribute to the power in the circuit.

(define PRS
  ((linear-resistor R1+R2) n1t2* n0t2*))
		   
(run)

(pec (symbolic-expression (content (current n2t2))))
