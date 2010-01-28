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

(define PR1
  ((linear-resistor (p:const 4))
   n1t2 n2t1))

(define PR2
  ((linear-resistor (p:const 2))
   n2t2 n0t2))

(define power (p:+ Pv (p:+ PR1 PR2)))

(plunker (potential n2t1))

(run)

(pp (content (potential n2t1)))
#|
#[:symbolic 15]
(expression (+ 2 x43))
(metadata #[:symbolic-metadata 16])
|#

(pec (symbolic-expression (content (current n2t2))))
#| Result:
1
|#

(pec (symbolic-expression (content power)))
#| Result:
0
|#
