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

;;;; Carcinogens for the semicolon part 2: Defining propagators

;;; Here be macros that provide syntactic sugar for playing with the
;;; propagator language as embedded in Scheme.  Syntactic regularities
;;; in patterns of definition of propagator constructors are captured.

;;;; Paired propagator definitions

;;; Propagator objects are usually defined in pairs, one preferring to
;;; be applied diagram-style, and one preferring to be applied
;;; expression-style.  These two macros define such pairs of
;;; propagator objects, with the given names.  Said names are
;;; presumably computed by PROPAGATOR-NAMING-CONVENTION, below

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

;;;; Propagator naming convention

;;; The naming convention is:
;;;   p:foo   the propagator version of foo
;;;   e:foo   the expression-style variant of p:foo
;;;   c:foo   the constraint-propagator version of foo
;;;   ce:foo  the expression-style variant of c:foo

;;; For convenience, this convention includes constraint-propagator
;;; versions of the various propagators.  The procedure
;;; PROPAGATOR-NAMING-CONVENTION is a macro-helper; it constructs a
;;; pair of names derived from the given name, one to name the
;;; diagram-style variant and one to name the expression-style
;;; variant.  This is calibrated for use with
;;; DEFINE-BY-DIAGRAM-VARIANT and DEFINE-BY-EXPRESSION-VARIANT, above.

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

;;;; Defining primitive propagators

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
	   `(define-by-diagram-variant
	      ,(propagator-naming-convention propagatee-name)
	      (function->propagator-constructor
	       (name! ,propagatee ,propagatee-name)))
	   `(begin
	      (define ,generic-name
		(make-arity-detecting-operator
		 ',propagatee-name ,propagatee ,@(cdddr form)))
	      (define-by-diagram-variant
		,(propagator-naming-convention propagatee-name)
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

;;;; Defining "propagator macros"

;;; Scheme is the macro language of this embedded propagator system.
;;; Therefore defining "propagator macros" is just a matter of
;;; defining Scheme procedures.  Some patterns are common, however, so
;;; merit a little macro support.

;;; DEFINE-PROPAGATOR-SYNTAX is (meant to be) just like define, except
;;; that it wraps the body being defined in a WITH-NETWORK-GROUP,
;;; which is a hook for tagging all cells and propagators created
;;; inside the call with a common identity, which can then be passed
;;; on to the graph drawing tools used to inspect the network.
;;; DEFINE-PROPAGATOR-SYNTAX also assigns the formal parameter names
;;; as names to the incoming arguments.  The latter is most useful in
;;; the regime where all the passed arguments are actually cells (as
;;; opposed to, say, Scheme-lists of cells).

(define-syntax define-propagator-syntax
  (syntax-rules ()
    ((define-propagator-syntax (name arg-form ...) body-form ...)
     (define name
       (named-propagator-syntax (name arg-form ...)
	 body-form ...)))
    ;; N.B. This is the clause that will match dot-notation argument lists
    ((define-propagator-syntax name body-form ...)
     (define name
       (with-network-group (network-group-named 'name)
	 (lambda ()
	   body-form ...))))))

;;; This is the "lambda" to define-propagator-syntax's "define".
(define-syntax named-propagator-syntax
  (syntax-rules ()
    ((named-propagator-syntax (name arg-form ...) body-form ...)
     (propagator-constructor!
      (named-lambda (name arg-form ...)
	(with-network-group (network-group-named 'name)
	 (lambda ()
	   (name-locally! arg-form 'arg-form) ...
	   body-form ...)))))))

;;;; Defining compound propagators

;;; DEFINE-PROPAGATOR is to the propagator language what DEFINE is to
;;; Scheme.  These macros make closures --- see physical-closures.scm.
;;; This one defines propagators in diagram style --- that is, all
;;; boundary cells are explicitly named.

(define-syntax define-propagator
  (rsc-macro-transformer
   (lambda (form defn-env)
     (let ((name (caadr form))
	   (formals (cdadr form))
	   (body (cddr form)))
       `(define-%propagator ,(propagator-naming-convention name)
	  ,formals ,@body)))))

(define-syntax define-%propagator
  (syntax-rules ()
    ((define-%propagator names (arg ...)
       body ...)
     (define-by-diagram-variant names
       (name!
	(lambda-propagator (arg ...)
	  body ...)
	(car 'names))))))

(define-syntax lambda-propagator
  (syntax-rules (import)
    ((lambda-propagator (arg ...)
       (import cell ...)
       body ...)
     (make-closure
      (naming-lambda (arg ...)
	body ...)
      (list cell ...)))
    ((lambda-propagator (arg ...)
       body ...)
     (lambda-propagator (arg ...)
       (import)
       body ...))))

;;; DEFINE-E:PROPAGATOR is just like DEFINE-PROPAGATOR, except that
;;; there is one more implicit boundary cell, which is expected to be
;;; returned by the last form in the body being defined.

(define-syntax define-e:propagator
  (rsc-macro-transformer
   (lambda (form defn-env)
     (let ((name (caadr form))
	   (formals (cdadr form))
	   (body (cddr form)))
       `(define-%e:propagator ,(propagator-naming-convention name)
	  ,formals ,@body)))))

(define-syntax define-%e:propagator
  (syntax-rules ()
    ((define-%e:propagator names (arg ...)
       body ...)
     (define-by-expression-variant names
       (name!
	(lambda-e:propagator (arg ...)
	  body ...)
	(car 'names))))))

(define-syntax lambda-e:propagator
  (syntax-rules (import)
    ((lambda-e:propagator (arg ...)
       (import cell ...)
       body ...)
     (make-e:closure
      (naming-lambda (arg ...)
	body ...)
      (list cell ...)))
    ((lambda-e:propagator (arg ...)
       body ...)
     (lambda-e:propagator (arg ...)
       (import)
       body ...))))

;;; DEFINE-DELAYED-PROPAGATOR is one mechanism for achieving
;;; recursion.  It is just like DEFINE-PROPAGATOR, except that the
;;; closure it produces delays expansion until some content appears on
;;; its boundary.

(define-syntax define-delayed-propagator
  (rsc-macro-transformer
   (lambda (form defn-env)
     (let ((name (caadr form))
	   (formals (cdadr form))
	   (body (cddr form)))
       `(define-%delayed-propagator
	  ,(propagator-naming-convention name) ,formals ,@body)))))

(define-syntax define-%delayed-propagator
  (syntax-rules ()
    ((define-%delayed-propagator names (arg ...)
       body ...)
     (define-by-diagram-variant names
       (name!
	(lambda-delayed-propagator (arg ...)
	  body ...)
	(car 'names))))))

(define-syntax lambda-delayed-propagator
  (syntax-rules (import)
    ((lambda-delayed-propagator (arg ...)
       (import cell ...)
       body ...)
     (make-closure
      (delayed-propagator-constructor
       (naming-lambda (arg ...)
	 body ...))
      (list cell ...)))
    ((lambda-delayed-propagator (arg ...)
       body ...)
     (lambda-delayed-propagator (arg ...)
       (import)
       body ...))))

;;; This is a convenience for defining closures (with make-closure)
;;; that track the Scheme names given to the incoming cells.
(define-syntax naming-lambda
  (syntax-rules ()
    ((naming-lambda (arg-form ...) body-form ...)
     (lambda (arg-form ...)
       (name-locally! arg-form 'arg-form) ...
       body-form ...))))

;;;     TODO Is it now time to refactor the above propagator macro
;;; nonsense into a propagator-lambda macro that emits closures, per
;;; physical-closures.scm?
;;;     TODO I need variable arity propagator constructors; this can
;;; be taken from the story for compound data.  (And at the end I need
;;; to adjust the above to define-cell instead of define, and to
;;; return cells instead raw values, but that's easy.)
;;;     TODO Here's an idea: maybe the arguments to the Scheme
;;; procedures produced by define-macro-propagator and company should
;;; be optional.  If any are not supplied, that macro can just
;;; generate them.  It may also be fun to standardize on a mechanism
;;; like E:INSPECTABLE-OBJECT and THE from the circuits exploration
;;; for reaching in and grabbing such cells from the outside.
;;;     TODO Philosophical clarification that probably needs to be
;;; implemented: Abstractions should nominally always make their own
;;; cells for their formal parameters.  Call sites should attach
;;; arguments to callees with identity-like propagators. (If some
;;; argument cells are omitted from the argument list, just fail to
;;; attach anything to those parameters).  Cons should operate the
;;; same as it would under Church encoding: make its own cells,
;;; id-copy its arguments into them, and then carry those cells
;;; around.  This is neither the "carrying cells" strategy, because
;;; the argument cells are not carried, nor the "copying data"
;;; strategy, because the contents of the cons are not copied every
;;; time.  The advantage of this pattern is that cells really become
;;; very analagous to Scheme memory locations.  Incidentally, this
;;; idea is independent of physical vs virtual copies.  Hm.  It
;;; appears that carrying cells is actually just a slight optimization
;;; of this --- if the closure constructor's call site knows that it
;;; is about to make a few new cells and attach them to existing cells
;;; with unconditional identity propagators, then might as well just
;;; grab those cells in the first place.  But if those propagators do
;;; something funny like shift levels in a virtual copies scheme, or
;;; attach the provenance of the procedure being applied, then that's
;;; another story.
