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


(define p:constant constant)
(define (e:constant value)
  (let-cell answer
    ((constant value) answer)
    answer))
(define p:+ adder)
(define e:+ (functionalize adder))
(define p:- subtractor)
(define e:- (functionalize subtractor))
(define p:* multiplier)
(define e:* (functionalize multiplier))
(define p:/ divider)
(define e:/ (functionalize divider))
(define p:abs absolute-value)
(define e:abs (functionalize absolute-value))
(define p:square squarer)
(define e:square (functionalize squarer))
(define p:sqrt sqrter)
(define e:sqrt (functionalize sqrter))
(define p:= =?)
(define e:= (functionalize =?))
(define p:< <?)
(define e:< (functionalize <?))
(define p:> >?)
(define e:> (functionalize >?))
(define p:<= <=?)
(define e:<= (functionalize <=?))
(define p:>= >=?)
(define e:>= (functionalize >=?))
(define p:not inverter)
(define e:not (functionalize inverter))
(define p:and conjoiner)
(define e:and (functionalize conjoiner))
(define p:or disjoiner)
(define e:or (functionalize disjoiner))
(define p:switch switch)
(define e:switch (functionalize switch))
(define p:amb binary-amb)
(define (e:amb)
  (let-cell answer
    (binary-amb answer)
    answer))

(define-syntax propagatify
  (sc-macro-transformer
   (lambda (form use-env)
     (let* ((propagatee-name (cadr form))
	    (propagator-name (symbol 'p: propagatee-name))
	    (expression-oriented-name (symbol 'e: propagatee-name)))
       `(begin
	  (define ,propagator-name
	    (function->propagator-constructor
	     (nary-unpacking
	      (name! ,(close-syntax propagatee-name use-env) ',propagatee-name))))
	  (define ,expression-oriented-name
	    (functionalize ,propagator-name)))))))

(define (flat-function->propagator-expression f)
  (functionalize (function->propagator-constructor (nary-unpacking f))))

(propagatify eq?)
(propagatify expt)

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
