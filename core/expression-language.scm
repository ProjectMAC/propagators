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

