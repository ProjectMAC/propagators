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
