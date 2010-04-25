;;; ----------------------------------------------------------------------
;;; Copyright 2010 Alexey Radul and Gerald Jay Sussman
;;; ----------------------------------------------------------------------
;;; This file is part of Propagator Network Prototype.
;;; 
;;; Propagator Network Prototype is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;; 
;;; Propagator Network Prototype is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;; 
;;; You should have received a copy of the GNU General Public License
;;; along with Propagator Network Prototype.  If not, see <http://www.gnu.org/licenses/>.
;;; ----------------------------------------------------------------------

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

(define (terminal-equivalence ok? t1 t2)
  (conditional-wire ok? (ce:current t1) (ce:current t2))
  (conditional-wire ok? (ce:potential t1) (ce:potential t2)))

(define (voltage-divider-slice R1 R2)
  ;; TODO Need to verify that (the t2 R1) and (the t1 R2) have a node
  ;; in common.
  (let-cells ((Requiv (resistor))
	      (ok? (e:= (e:+ (e:terminal-current (the t2 R1))
			     (e:terminal-current (the t1 R2)))
			0)))
    ;; Maybe this should really be guessing the value of the output
    ;; current...  And applying this model if it's zero...
    (binary-amb ok?)
    (c:+ (the resistance R1)
	 (the resistance R2)
	 (the resistance Requiv))
    (terminal-equivalence ok? (the t1 R1) (the t1 Requiv))
    (terminal-equivalence ok? (the t2 R2) (the t2 Requiv))))

(define (voltage-divider-circuit)
  (let-cells ((R1 (resistor))
	      (R2 (resistor))
	      (V (voltage-source)))
    (let-cells ((n1 (node (the t1 V) (the t1 R1)))
		(n2 (node (the t2 R1) (the t1 R2)))
		(n3 (node (the t2 V) (the t2 R2))))
      ((constant 2) (the resistance R1))
      ((constant 4) (the resistance R2))
      ((constant 6) (the strength V))
      ((constant 0) (the potential n3))
      (e:inspectable-object R1 R2 V n1 n2 n3))))

#|
 (initialize-scheduler)
 ;Value: 0

 (define-cell test (voltage-divider-circuit))
 ;Value: test

 (define-cell answer (the potential n2 test))
 ;Value: answer

 (run)
 ;Value: done

 (content answer)
 ;Value: #(*the-nothing*)

 (voltage-divider-slice (the R1 test) (the R2 test))
 (run)
 (content answer)
 
|#

