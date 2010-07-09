;;; ----------------------------------------------------------------------
;;; Copyright 2009 Massachusetts Institute of Technology.
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

;;;; Standard primitive propagators

(define adder
  (function->propagator-constructor (binary-mapping generic-+)))
(define subtractor
  (function->propagator-constructor (binary-mapping generic--)))
(define multiplier
  (function->propagator-constructor (binary-mapping generic-*)))
(define divider
  (function->propagator-constructor (binary-mapping generic-/)))

(define absolute-value
  (function->propagator-constructor (unary-mapping generic-abs)))
(define squarer
  (function->propagator-constructor (unary-mapping generic-square)))
(define sqrter
  (function->propagator-constructor (unary-mapping generic-sqrt)))

(define =? (function->propagator-constructor (binary-mapping generic-=)))
(define <? (function->propagator-constructor (binary-mapping generic-<)))
(define >? (function->propagator-constructor (binary-mapping generic->)))
(define <=? (function->propagator-constructor (binary-mapping generic-<=)))
(define >=? (function->propagator-constructor (binary-mapping generic->=)))

(define inverter
  (function->propagator-constructor (nary-unpacking generic-not)))
(define conjoiner
  (function->propagator-constructor (binary-mapping generic-and)))
(define disjoiner
  (function->propagator-constructor (binary-mapping generic-or)))

(define pass-through
  (function->propagator-constructor identity))

(define switch
  (function->propagator-constructor (nary-unpacking switch-function)))

(define (constant value)
  (function->propagator-constructor
   #; (lambda () value)
   (eq-label! (lambda () value) 'name `(constant ,value))))

;;;; Standard "propagator macros"

(define-macro-propagator (conditional control if-true if-false output)
  (let-cell not-control
    (inverter control not-control)
    (switch control if-true output)
    (switch not-control if-false output)))

(define-macro-propagator (conditional-writer control input if-true if-false)
  (let-cell not-control
    (inverter control not-control)
    (switch control input if-true)
    (switch not-control input if-false)))

(define-macro-propagator (conditional-wire control end1 end2)
  (switch control end1 end2)
  (switch control end2 end1))

(define-macro-propagator (sum-constraint a1 a2 sum)
  (adder a1 a2 sum)
  (subtractor sum a1 a2)
  (subtractor sum a2 a1))

(define-macro-propagator (product-constraint m1 m2 product)
  (multiplier m1 m2 product)
  (divider product m1 m2)
  (divider product m2 m1))

(define-macro-propagator (quadratic-constraint x x^2)
  (squarer x x^2)
  (sqrter x^2 x))

(define-macro-propagator (not-constraint p1 p2)
  (inverter p1 p2)
  (inverter p2 p1))

(define-macro-propagator (identity-constraint c1 c2)
  (pass-through c1 c2)
  (pass-through c2 c1))

;; TODO rconjoiner and rdisjoiner got lost in the interminable shuffles,
;; so these don't work any more.
#;
(define (and-constraint p1 p2 conjunction)
  (conjoiner p1 p2 conjunction)
  (rconjoiner conjunction p1 p2))
#;
(define (or-constraint p1 p2 disjunction)
  (disjoiner p1 p2 disjunction)
  (rdisjoiner disjunction p1 p2))
