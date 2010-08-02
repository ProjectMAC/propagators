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

(define (p:constant value)
  (function->propagator-constructor #; (lambda () value)
   (eq-label! (lambda () value) 'name `(constant ,(name value)))))
(define (e:constant value)
  (let ((answer (make-named-cell 'cell)))
    ((constant value) answer)
    (eq-put! answer 'subexprs '())
    answer))

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

;; Not using propagatify because the name AND names syntax, and I want
;; the procedure BOOLEAN/AND
(define generic-and (make-generic-operator 2 'and boolean/and))
(define-cell p:and
  (function->propagator-constructor (binary-mapping generic-and)))
(define-cell e:and (expression-style-variant p:and))
(define generic-or  (make-generic-operator 2 'or  boolean/or))
(define-cell p:or
  (function->propagator-constructor (binary-mapping generic-or)))
(define-cell e:or (expression-style-variant p:or))

(propagatify eq? binary-mapping)
(propagatify eqv? binary-mapping)
(propagatify expt unary-mapping)

;; I want a name for the function that does the switch job
(define (switch-function control input)
  (if control input nothing))
(name! switch-function 'switch)
(define-cell p:switch
  (function->propagator-constructor (nary-unpacking switch-function)))
(define-cell e:switch (expression-style-variant p:switch))

(name! identity 'identity)
(define-cell pass-through (function->propagator-constructor identity))

;; TODO Do I still want to provide these old names for these things?
(define constant p:constant) (define switch p:switch)

;;;; Standard compound propagators

(define-propagator (conditional control if-true if-false output)
  (switch control if-true output)
  (switch (e:not control) if-false output))

(define-propagator (conditional-router control input if-true if-false)
  (switch control input if-true)
  (switch (e:not control) input if-false))

(define-propagator (conditional-wire control end1 end2)
  (switch control end1 end2)
  (switch control end2 end1))

(define conditional p:conditional)
(define conditional-router p:conditional-router)
(define conditional-wire p:conditional-wire)

;;; Constraining propagators

(define-propagator (c:+ a1 a2 sum)
  (p:+ a1 a2 sum)      (p:- sum a1 a2)      (p:- sum a2 a1))

(define-propagator (c:* m1 m2 product)
  (p:* m1 m2 product)  (p:/ product m1 m2)  (p:/ product m2 m1))

(define-propagator (c:square x x^2)
  (p:square x x^2)     (p:sqrt x^2 x))

(define-propagator (c:not p1 p2)
  (p:not p1 p2)        (p:not p2 p1))

(define-propagator (c:id c1 c2)
  (pass-through c1 c2) (pass-through c2 c1))

(define-cell (p:== . args)
  (let ((target (car (last-pair args))))
    (for-each (lambda (arg)
		(pass-through arg target))
	      (except-last-pair args))
    target))
(propagator-constructor! p:==)
(define-cell e:== (expression-style-variant p:==))

(define-cell (c:== . args)
  (let ((lead (car args)))
    (for-each (lambda (arg)
		(c:id lead arg))
	      (cdr args))
    lead))
(propagator-constructor! c:==)
(define-cell ce:== (expression-style-variant c:==))
