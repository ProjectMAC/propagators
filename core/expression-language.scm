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

;;;; Expression style of propagator notation

;;; The most general propagator notation supplies all the input and
;;; output cells to the desired propagator constructor explicitly:
;;;   (adder x y subtotal)
;;;   (adder subtotal z total)
;;; This "propagator style" notation is very flexible, because it
;;; allows easy handling of multiple propagators writing to the same
;;; cells, propagators having multiple output cells, having cells that
;;; are ambiguous as to input vs output, etc.

;;; A nested expression notation can be very convenient for simple
;;; cases, however, because it allows the outputs of one propagator to
;;; be piped directly into the inputs to another, without even naming
;;; the intermediate value:
;;;   (e:+ (e:+ x y) z)

;;; Here, expression-style variants of propagator-style propagator
;;; constructors are mechanically derived and defined.  It is also
;;; convenient to provide multidirectional constraint versions of
;;; standard propagator constructors with a uniform naming scheme.

;;; The naming convention is:
;;;   p:foo  for the propagator version of foo
;;;   e:foo  for the expression-oriented propagator version of foo
;;;   cp:foo for the constraint-propagator version of foo
;;;   ce:foo for the expression-oriented constraint-propagator version of foo

(define (functionalize propagator #!optional num-outputs)
  (if (default-object? num-outputs)
      (set! num-outputs 1))
  (propagator-constructor!
   (eq-put!
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
	  (apply values outputs)))
    'expression-style #t)))

(define %% (list 'the-implicit-cell))
(define (implicit-cell? thing)
  (eq? thing %%))
(name! %% '%%)

;;;; Propagatify macro

;;; An experimental macro trying to abstract the propagator definition
;;; cycle carried out between here and generic-definitions.scm.

(define (make-arity-detecting-operator name default-operation #!optional arity)
  (if (default-object? arity)
      (set! arity (procedure-arity default-operation)))
  ;; The generic machinery only likes fixed arity operations; assume
  ;; that a fully variadic input operation is really the associative
  ;; version of a binary one, and the binary one will do for
  ;; extensibility.
  (cond ((not (procedure-arity? arity))
	 ;; This allows the user to explictly prevent the construction
	 ;; of the generic operation by specifying a bogus arity for
	 ;; it.
	 default-operation)
	((eqv? (procedure-arity-min arity)
	       (procedure-arity-max arity))
	 (make-generic-operator arity name default-operation))
	((and (or (eqv? 0 (procedure-arity-min arity))
		  (eqv? 1 (procedure-arity-min arity)))
	      (eqv? #f (procedure-arity-max arity)))
	 (make-generic-operator 2 name default-operation))
	(else default-operation)))

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
		(make-arity-detecting-operator
		 ',propagatee-name ,propagatee ,@(cdddr form)))
	      (define ,propagator-name
		(function->propagator-constructor
		 (,(caddr form) ,generic-name)))
	      (define ,expression-oriented-name
		(functionalize ,propagator-name))))))))

