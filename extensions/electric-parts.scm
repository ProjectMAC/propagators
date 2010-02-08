(declare (usual-integrations make-cell))

;;; Primitive data structures

(define (make-terminal i e)
  (cons i e))
(define (current terminal)
  (car terminal))
(define (potential terminal)
  (cdr terminal))

;; TODO (re)insert optional names for cells and devices
(define ((2-terminal-device vic) t1 t2)
  "We measure the voltage from t1 to t2 (i.e. v = e(t1) - e(t2)),
and the current is measured as flowing into t1."
  (let ((i1 (current t1)) (e1 (potential t1))
	(i2 (current t2)) (e2 (potential t2)))
    (let-cells (v P zero)
      ((constant 0) zero)
      (sum-constraint v e2 e1)
      (sum-constraint i1 i2 zero)
      (product-constraint i1 v P)
      (vic v i1)
      P)))

(define (linear-resistor R)
  (2-terminal-device
   (lambda (v i)
     (product-constraint R i v))))

(define (voltage-source strength)
  (2-terminal-device
   (lambda (v i)
     (identity-constraint strength v))))

(define (current-source strength)
  (2-terminal-device
   (lambda (v i)
     (identity-constraint strength i))))

(define (ground node)
  ((constant 0) (potential (car node))))

(define (spst-switch ctl in out)
  (switch ctl in out)
  (switch ctl out in))

(define (node n)
  (let ((e (make-cell))
	(is
	 (let lp ((n n))
	   (cond ((= n 1)
		  (let-cell i
		    (list i i)))
		 ((= n 2)
		  (let-cells (i1 i2 i)
		    (sum-constraint i1 i2 i)
		    (list i i1 i2)))
 		 ((even? n)
		  (let ((a1 (lp (/ n 2)))
			(a2 (lp (/ n 2)))
			(a (make-cell)))
		    (sum-constraint (car a1) (car a2) a)
		    (cons a (append (cdr a1) (cdr a2)))))
		 ((odd? n)
		  (let ((a1 (lp (- n 1)))
			(i2 (make-cell))
			(a (make-cell)))
		    (sum-constraint (car a1) i2 a)
		    (cons a (cons i2 (cdr a1)))))
		 (else (error))))))
    ((constant 0) (car is))
    (map (lambda (i)
	   (make-terminal i e))
	 (cdr is))))


;;; Support for slices -- GJS

(define (clone-terminal terminal)
  (make-terminal (current terminal)
		 (potential terminal)))

(define (ideal-diode)
  (2-terminal-device
   (lambda (v i)
     (let-cells (zero-volts zero-amps if>=0 vreverse
		 vr<=0 iforward conducting -conducting)
       ((constant 0) zero-volts)
       ((constant 0) zero-amps)
       ;;#t=>conducting; #f=>not conducting
       (binary-amb conducting)
       (inverter conducting -conducting)
       (spst-switch conducting zero-volts v)
       (spst-switch -conducting v vreverse)
       (<=-constraint vr<=0 vreverse zero-volts)
       (require vr<=0)
       (spst-switch -conducting zero-amps i)
       (spst-switch conducting i iforward)
       (>=-constraint if>=0 iforward zero-amps)
       (require if>=0)))))
