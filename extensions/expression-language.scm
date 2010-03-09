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

(declare (usual-integrations make-cell cell?))

(define %% (list 'the-implicit-cell))
(define (implicit-cell? thing)
  (eq? thing 'the-implicit-cell))

(define (->cell thing)
  (if (or (implicit-cell? thing) (cell? thing))
      thing
      (e:constant thing)))

(define (functionalize propagator #!optional num-outputs)
  (if (default-object? num-outputs)
      (set! num-outputs 1))
  (lambda args
    (define inputs (map ->cell args))
    (define outputs '())
    (define (manufacture-cell)
      (let-cell cell
	(set! outputs (cons cell outputs))
	cell))
    (define implicit-cells-present? (any implicit-cell? inputs))
    (define true-inputs
      (if implicit-cells-present?
	  (map (lambda (cell)
		 (if (implicit-cell? cell)
		     (manufacture-cell)
		     cell))
	       inputs)
	  (append inputs (map (lambda (k) (manufacture-cell))
			      (iota num-outputs)))))
    (apply propagator true-inputs)
    (if (= 1 (length outputs))
	(car outputs)
	;; TODO Maybe (reverse outputs) here?
	(apply values outputs))))

;;; Naming convention:
;;;   p:foo  for the propagator version of foo
;;;   e:foo  for the expression-oriented propagator version of foo
;;;   cp:foo for the constraint-propagator version of foo
;;;   ce:foo for the expression-oriented constraint-propagator version of foo


(define (e:constant value)
  (let-cell answer
    ((constant value) answer)
    answer))
(define e:+ (functionalize adder))
(define e:- (functionalize subtractor))
(define e:* (functionalize multiplier))
(define e:/ (functionalize divider))
(define e:abs (functionalize absolute-value))
(define e:square (functionalize squarer))
(define e:sqrt (functionalize sqrter))
(define e:= (functionalize =?))
(define e:< (functionalize <?))
(define e:> (functionalize >?))
(define e:<= (functionalize <=?))
(define e:>= (functionalize >=?))
(define e:not (functionalize inverter))
(define e:and (functionalize conjoiner))
(define e:or (functionalize disjoiner))
(define e:switch (functionalize switch))
(define (e:amb)
  (let-cell answer
    (binary-amb answer)
    answer))

(define (flat-function->propagator-expression f)
  (functionalize (function->propagator-constructor (nary-unpacking f))))

(define e:eq? (flat-function->propagator-expression eq?))
(name! eq? 'eq?)
(define e:expt (flat-function->propagator-expression expt))
(name! expt 'expt)
(define p:eq? e:eq?)
(define p:expt e:expt)
(define p:or e:or)
(define p:not e:not)
(define p:amb e:amb)

(define c:+ (functionalize sum-constraint))
(define c:* (functionalize product-constraint))
(define c:not (functionalize not-constraint))
(define c:identity (functionalize identity-constraint))
; (define c:and (functionalize and-constraint))
; (define c:or (functionalize or-constraint))

(define (c:== . args)
  (let ((lead (car args)))
    (for-each (lambda (arg)
		(identity-constraint lead arg))
	      (cdr args))
    lead))
