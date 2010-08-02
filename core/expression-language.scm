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
;;;   (p:+ x y subtotal)
;;;   (p:+ subtotal z total)
;;; This "diagram style" notation is very flexible, because it
;;; allows easy handling of multiple propagators writing to the same
;;; cells, propagators having multiple output cells, having cells that
;;; are ambiguous as to input vs output, etc.

;;; A nested expression notation can be very convenient for simple
;;; cases, however, because it allows the outputs of one propagator to
;;; be piped directly into the inputs to another, without even naming
;;; the intermediate value:
;;;   (e:+ (e:+ x y) z)

;;; The HANDLING-IMPLICIT-CELLS procedure mechanically derives an
;;; expression-style variant of a diagram-style procedure that
;;; operates on cells.  The FUNCTIONALIZE procedure augments it by
;;; handling the metadata of propagator constructors.  The
;;; TAG-PREFERRED-STYLE procedure makes no meaningful change to its
;;; argument, but attaches a tag to it that indicates that 

(define (handling-implicit-cells proc #!optional num-outputs)
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
    (apply proc (map ensure-cell true-inputs))
    (if (= 1 (length outputs))
	(car outputs)
	(apply values outputs))))

(define (functionalize propagator #!optional num-outputs)
  (propagator-constructor!
   (eq-label!
    (handling-implicit-cells propagator num-outputs)
    'expression-style #t
    'preferred-style 'expression)))

(define %% (list 'the-implicit-cell))
(define (implicit-cell? thing)
  (eq? thing %%))
(name! %% '%%)

(define e:application (functionalize p:application))
(define d@ p:application)
(define @d d@)
(define e@ e:application)
(define @e e@)


;;; It is also convenient to provide
;;; multidirectional constraint versions of standard propagator
;;; constructors with a uniform naming scheme.

;;; The naming convention is:
;;;   p:foo  for the propagator version of foo
;;;   e:foo  for the expression-oriented propagator version of foo
;;;   cp:foo for the constraint-propagator version of foo
;;;   ce:foo for the expression-oriented constraint-propagator version of foo

;;;; Propagatify macro

;;; The PROPAGATIFY macro automates the process of defining extensible
;;; propagators whose basic operations are Scheme procedures.

;;; FUNCTION->PROPAGATOR-CONSTRUCTOR turns Scheme procedures into
;;; propagator constructors (that make primitive propagators).  In
;;; principle, that's good enough; but two things can be done to make
;;; the resulting propagator easier to extend to different partial
;;; information structures.  First, a generic operation can be defined
;;; and second, a uniform wrapper from generic-definitions.scm can be
;;; applied.  Finally, to complete the definition, an expression
;;; version of the propagator constructor is usually defined.

;;; The first argument to the macro is the operation to propagatify
;;; (and also the base of the name to give to the result).  Without
;;; further arguments, PROPAGATIFY will assume that the operation is
;;; suitable for propagatification directly, and does not require the
;;; extensibility mechanisms:
;;;   (propagatify +)
;;; would be equivalent to
;;;   (define-cell p:+ (function->propagator-constructor +))
;;;   (define-cell e:+ (expression-style-variant p:+)

;;; If supplied, the second argument is a wrapper to use to add
;;; generic functionality.  Since this indicates that generic
;;; functionality is desired, PROPAGATIFY will also construct a
;;; generic operation with a standard name (whose arity is deduced
;;; from the arity of the operation being propagatified).  So
;;;   (propagatify + binary-mapping)
;;; is equivalent to
;;;   (define generic-+ (make-generic-operator 2 '+ +))
;;;   (define-cell p:+
;;;     (function->propagator-constructor (binary-mapping generic-+)))
;;;   (define-cell e:+ (expression-style-variant p:+))

;;; Finally, the third argument can either be an explicit arity for
;;; circumstances when the arity of the generic would be guessed
;;; wrong, or the expression 'no-generic to indicate that no generic
;;; operation should be defined.  For example,
;;;   (propagatify + binary-mapping 'no-generic)
;;; would be equivalent to
;;;   (define-cell p:+ (function->propagator-constructor (binary-mapping +)))
;;;   (define-cell e:+ (expression-style-variant p:+))
;;; Compare (propagatify +).

(define-syntax propagatify
  (sc-macro-transformer
   (lambda (form use-env)
     (let* ((propagatee-name (cadr form))
	    (generic-name (symbol 'generic- propagatee-name))
	    (propagatee (close-syntax propagatee-name use-env))
	    (direct? (null? (cddr form))))
       (if direct?
	   `(define-by-diagram-variant ,(propagator-naming-convention propagatee-name)
	      (function->propagator-constructor
	       (name! ,propagatee ,propagatee-name)))
	   `(begin
	      (define ,generic-name
		(make-arity-detecting-operator
		 ',propagatee-name ,propagatee ,@(cdddr form)))
	      (define-by-diagram-variant ,(propagator-naming-convention propagatee-name)
		(function->propagator-constructor
		 (,(caddr form) ,generic-name)))))))))

(define (make-arity-detecting-operator
	 name default-operation #!optional arity)
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

(define (propagator-naming-convention name)
  (let* ((name-string (symbol->string name))
	 (long-named? (and (>= (string-length name-string) 3)
			   (equal? "ce:" (substring name-string 0 3))))
	 (propagator-named? (and (>= (string-length name-string) 2)
				 (or (equal? "p:" (substring name-string 0 2))
				     (equal? "e:" (substring name-string 0 2)))))
	 (constraint-named? (and (>= (string-length name-string) 2)
				 (or (equal? "c:" (substring name-string 0 2))
				     long-named?)))
	 (prefix-length (cond (long-named? 3)
			      ((or constraint-named? propagator-named?) 2)
			      (else 0)))
	 (base-name (string-tail name-string prefix-length)))
    (if constraint-named?
	(list (symbol 'c: base-name)
	      (symbol 'ce: base-name))
	(list (symbol 'p: base-name)
	      (symbol 'e: base-name)))))

(define-syntax define-by-diagram-variant
  (syntax-rules ()
    ((define-by-diagram-variant (diagram-name expression-name) form)
     (begin
       (define-cell diagram-name form)
       (define-cell expression-name (expression-style-variant diagram-name))))))

(define-syntax define-by-expression-variant
  (syntax-rules ()
    ((define-by-diagram-variant (diagram-name expression-name) form)
     (begin
       (define-cell expression-name form)
       (define-cell diagram-name (diagram-style-variant expression-name))))))
