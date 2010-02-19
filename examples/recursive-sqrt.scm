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

(declare (usual-integrations make-cell))

(define (heron-step x g h)
  (compound-propagator (list x g)       ; inputs
    (eq-label!
     (lambda ()				; how to build
       (let-cells (x/g g+x/g two)
	 (divider x g x/g)
	 (adder g x/g g+x/g)
	 ((constant 2) two)
	 (divider g+x/g two h)))
     'name 'heron-step
     'inputs (list x g)
     'outputs (list h)))) ;; TODO Give h a shadow connection for the traversal version

(define (sqrt-iter x g answer)
  (compound-propagator (list x g)
    (eq-label!
     (lambda ()
       (let-cells (done x-if-done x-if-not-done g-if-done g-if-not-done
			new-g recursive-answer)
	 (good-enuf? x g done)
	 (conditional-writer done x x-if-done x-if-not-done)
	 (conditional-writer done g g-if-done g-if-not-done)
	 (heron-step x-if-not-done g-if-not-done new-g)
	 (sqrt-iter x-if-not-done new-g recursive-answer)
	 (conditional done g-if-done recursive-answer answer)))
     'name 'sqrt-iter
     'inputs (list x g)
     'outputs (list answer))))

(define (sqrt-network x answer)
  (compound-propagator x
    (eq-label!
     (lambda ()
       (let-cell one
	 ((constant 1.0) one)
	 (sqrt-iter x one answer)))
     'name 'sqrt-network
     'inputs (list x)
     'outputs (list answer))))

(define (good-enuf? x g done)
  (compound-propagator (list x g)
    (eq-label!
     (lambda ()
       (let-cells (g^2 eps x-g^2 ax-g^2)
	 ((constant .00000001) eps)
	 (multiplier g g g^2)
	 (subtractor x g^2 x-g^2)
	 (absolute-value x-g^2 ax-g^2)
	 (<? ax-g^2 eps done)))
     'name 'good-enuf?
     'inputs (list x g)
     'outputs (list done))))

#|
 (initialize-scheduler)
 (define-cell x)
 (define-cell answer)

 (sqrt-network x answer)

 (add-content x 2)
 (run)
 (content answer)
 ;Value: 1.4142135623746899
|#
