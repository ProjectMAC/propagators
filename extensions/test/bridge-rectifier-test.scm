;;; ----------------------------------------------------------------------
;;; Copyright 2009-2010 Alexey Radul.
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

(in-test-group
 bridge-rectifier

 (define-test (consistent-state-test)
   (interaction
    (initialize-scheduler)
    (define-cell victim)
    (binary-amb victim)
    (map-consistent-states
      (lambda ()
	(v&s-value (tms-query (content victim))))
      victim)
    (produces '(#t #f))))

 ;; This test takes a very long time to run
 #;
 (define-test (plunking-rectifier)
   (interaction
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

    (define-cell strength-Vs)
    (define Vs (voltage-source strength-Vs))
    (add-content strength-Vs 6)

    (define-cell resistance-R1)
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

    (define-cell P)
    (define-cell P12)
    (define-cell P34)
    (define-cell P56)
    (define-cell P1234)

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
    ;; Note: Only one consistent state
    (map-consistent-states
      (lambda ()
	(v&s-value (tms-query (content (current n2t2)))))
      all-cells)
    (produces
     '(#(symbolic 2 #(metadata (x) (((= x 6) ())) ()))))))

 )
