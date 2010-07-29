;;; ----------------------------------------------------------------------
;;; Copyright 2009-2010 Alexey Radul.
;;; ----------------------------------------------------------------------
;;; This file is part of Propagator Network Prototype.
;;; 
;;; Propagator Network Prototype is free software; you can
;;; redistribute it and/or modify it under the terms of the GNU
;;; General Public License as published by the Free Software
;;; Foundation, either version 3 of the License, or (at your option)
;;; any later version.
;;; 
;;; Propagator Network Prototype is distributed in the hope that it
;;; will be useful, but WITHOUT ANY WARRANTY; without even the implied
;;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;;; See the GNU General Public License for more details.
;;; 
;;; You should have received a copy of the GNU General Public License
;;; along with Propagator Network Prototype.  If not, see
;;; <http://www.gnu.org/licenses/>.
;;; ----------------------------------------------------------------------

(declare (usual-integrations make-cell cell?))

(define-recursive-propagator (heron-step x g h)
  (let-cells (x/g g+x/g two)
    (p:/ x g x/g)
    (p:+ g x/g g+x/g)
    ((constant 2) two)
    (p:/ g+x/g two h)))

(define-recursive-propagator (sqrt-iter x g answer)
  (let-cells (done x-if-done x-if-not-done g-if-done g-if-not-done
		   new-g recursive-answer)
    (good-enuf? x g done)
    (conditional-router done x x-if-done x-if-not-done)
    (conditional-router done g g-if-done g-if-not-done)
    (heron-step x-if-not-done g-if-not-done new-g)
    (sqrt-iter x-if-not-done new-g recursive-answer)
    (conditional done g-if-done recursive-answer answer)))

(define-recursive-propagator (sqrt-network x answer)
  (let-cell one
    ((constant 1.0) one)
    (sqrt-iter x one answer)))

(define-recursive-propagator (good-enuf? x g done)
  (let-cells (g^2 eps x-g^2 ax-g^2)
    ((constant .00000001) eps)
    (p:* g g g^2)
    (p:- x g^2 x-g^2)
    (p:abs x-g^2 ax-g^2)
    (p:< ax-g^2 eps done)))

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

(define-syntax shielded-when
  (syntax-rules ()
    ((shielded-when conditional (shieldee ...) body ...)
     (let-cells ((shieldee (e:conditional-wire conditional shieldee)) ...)
       ((delayed-propagator-constructor
	 (lambda (shieldee ...)
	   body ...))
	shieldee ...)))))

(define-propagator (p:factorial-1 n n!)
  (shielded-when
   (e:not (e:= 0 n))
   (n n!)
   (p:== (e:* n (e:factorial-1 (e:- n 1))) n!))
  (switch (e:= 0 n) 1 n!))
(define e:factorial-1 (functionalize p:factorial-1))

(define-syntax shielded-unless
  (syntax-rules ()
    ((shielded-unless conditional stuff ...)
     (shielded-when (e:not conditional) stuff ...))))

(define-syntax shielded-if
  (syntax-rules ()
    ((shielded-if conditional shieldees consequent alternate)
     (let-cell (conditional-value conditional)
       (shielded-when conditional-value shieldees consequent)
       (shielded-unless conditional-value shieldees alternate)))))

(define-propagator (p:factorial-2 n n!)
  (shielded-if
   (e:= 0 n)
   (n n!)
   (p:== 1 n!)
   (p:== (e:* n (e:factorial-2 (e:- n 1))) n!)))
(define e:factorial-2 (functionalize p:factorial-2))
