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
  (eq? thing %%))
(name! %% '%%)

(define (functionalize propagator #!optional num-outputs)
  (if (default-object? num-outputs)
      (set! num-outputs 1))
  (lambda inputs
    (define (manufacture-cell)
      (eq-put! (make-named-cell 'cell) 'subexprs inputs))
    (define outputs (map (lambda (k) (manufacture-cell))
			 (iota num-outputs)))
    (define true-inputs
      (let loop ((inputs inputs)
		 (outputs outputs))
	(cond ((null? inputs)
	       outputs)
	      ((implicit-cell? (car inputs))
	       (if (null? outputs)
		   (error "Too many implicit cells" inputs)
		   (cons (car outputs)
			 (loop (cdr inputs) (cdr outputs)))))
	      (else
	       (cons (car inputs) (loop (cdr inputs) outputs))))))
    (apply propagator (map ensure-cell true-inputs))
    (if (= 1 (length outputs))
	(car outputs)
	(apply values outputs))))

;;; Naming convention:
;;;   p:foo  for the propagator version of foo
;;;   e:foo  for the expression-oriented propagator version of foo
;;;   cp:foo for the constraint-propagator version of foo
;;;   ce:foo for the expression-oriented constraint-propagator version of foo

(define p:constant constant)
(define (e:constant value)
  (let ((answer (make-named-cell 'cell)))
    ((constant value) answer)
    (eq-put! answer 'subexprs '())
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
  (let ((answer (make-named-cell 'cell)))
    (binary-amb answer)
    (eq-put! answer 'subexprs '())
    answer))
(define p:require require)
(define p:forbid forbid)
;; The expression versions of require and forbid are kinda dumb, but
;; provided anyway
(define e:require (functionalize p:require))
(define e:forbid (functionalize p:forbid))

(define e:one-of (functionalize one-of))

(define (make-arity-detecting-operator name default-operation)
  (make-generic-operator (procedure-arity default-operation) name
			 default-operation))

(define-syntax propagatify
  (sc-macro-transformer
   (lambda (form use-env)
     (let* ((propagatee-name (cadr form))
	    (propagator-name (symbol 'p: propagatee-name))
	    (expression-oriented-name (symbol 'e: propagatee-name))
	    (generic-name (symbol 'generic- propagatee-name))
	    (propagatee (close-syntax propagatee-name use-env))
	    (direct? (null? (cddr form))))
       (if direct?
	   `(begin
	      (define ,propagator-name
		(function->propagator-constructor
		 (name! ,propagatee ,propagatee-name)))
	      (define ,expression-oriented-name
		(functionalize ,propagator-name)))
	   `(begin
	      (define ,generic-name
		(make-arity-detecting-operator ',propagatee-name ,propagatee))
	      (define ,propagator-name
		(function->propagator-constructor
		 (,(caddr form) ,generic-name)))
	      (define ,expression-oriented-name
		(functionalize ,propagator-name))))))))

(propagatify eq? binary-mapping)
(propagatify expt unary-mapping)

(define c:+ sum-constraint)
(define ce:+ (functionalize sum-constraint))
(define c:* product-constraint)
(define ce:* (functionalize product-constraint))
(define c:not not-constraint)
(define ce:not (functionalize not-constraint))
;; (define c:and and-constraint)
;; (define ce:and (functionalize and-constraint))
;; (define c:or or-constraint)
;; (define ce:or (functionalize or-constraint))

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
