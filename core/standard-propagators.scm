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

;; (define adder
;;   (function->propagator-constructor (binary-mapping generic-+)))
;; (define subtractor
;;   (function->propagator-constructor (binary-mapping generic--)))
;; (define multiplier
;;   (function->propagator-constructor (binary-mapping generic-*)))
;; (define divider
;;   (function->propagator-constructor (binary-mapping generic-/)))

;; (define absolute-value
;;   (function->propagator-constructor (unary-mapping generic-abs)))
;; (define squarer
;;   (function->propagator-constructor (unary-mapping generic-square)))
;; (define sqrter
;;   (function->propagator-constructor (unary-mapping generic-sqrt)))

;; (define =? (function->propagator-constructor (binary-mapping generic-=)))
;; (define <? (function->propagator-constructor (binary-mapping generic-<)))
;; (define >? (function->propagator-constructor (binary-mapping generic->)))
;; (define <=? (function->propagator-constructor (binary-mapping generic-<=)))
;; (define >=? (function->propagator-constructor (binary-mapping generic->=)))

;; (define inverter
;;   (function->propagator-constructor (unary-mapping generic-not)))

(propagatify + binary-mapping)
(propagatify - binary-mapping)
(propagatify * binary-mapping)
(propagatify / binary-mapping)
(propagatify abs unary-mapping)
(propagatify square unary-mapping)
(propagatify sqrt unary-mapping)
(propagatify = binary-mapping)
(propagatify < binary-mapping)
(propagatify > binary-mapping)
(propagatify <= binary-mapping)
(propagatify >= binary-mapping)
(propagatify not unary-mapping)

(define adder p:+)
(define subtractor p:-)
(define multiplier p:*)
(define divider p:/)
(define absolute-value p:abs)
(define squarer p:square)
(define sqrter p:sqrt)
(define =? p:=)
(define <? p:<)
(define >? p:>)
(define <=? p:<=)
(define >=? p:>=)
(define inverter p:not)

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

(propagatify eq? binary-mapping)
(propagatify expt unary-mapping)

(define p:constant constant)
(define (e:constant value)
  (let ((answer (make-named-cell 'cell)))
    ((constant value) answer)
    (eq-put! answer 'subexprs '())
    answer))

(define p:and conjoiner)
(define e:and (functionalize conjoiner))
(define p:or disjoiner)
(define e:or (functionalize disjoiner))
(define p:switch switch)
(define e:switch (functionalize switch))

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


(define c:+ sum-constraint)
(define ce:+ (functionalize sum-constraint))
(define c:* product-constraint)
(define ce:* (functionalize product-constraint))
(define c:not not-constraint)
(define ce:not (functionalize not-constraint))

(define (p:== . args)
  (let ((target (car (last-pair args))))
    (for-each (lambda (arg)
		(pass-through arg target))
	      (except-last-pair args))
    target))
(define e:== (functionalize p:==))

(define (c:== . args)
  (let ((lead (car args)))
    (for-each (lambda (arg)
		(identity-constraint lead arg))
	      (cdr args))
    lead))
(define ce:== (functionalize c:==))

(define p:conditional conditional)
(define e:conditional (functionalize p:conditional))
