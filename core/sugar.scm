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

;;;; Propagator naming convention

;;; Defined propagators come in variants that perfer to be applied
;;; diagram-style and expression-style.  The styles are distinguised
;;; by naming convention.  It is also convenient to provide
;;; multidirectional constraint versions of standard propagator
;;; constructors within the same naming scheme.

;;; The naming convention is:
;;;   p:foo   the propagator version of foo
;;;   e:foo   the expression-style variant of p:foo
;;;   c:foo   the constraint-propagator version of foo
;;;   ce:foo  the expression-style variant of c:foo

;;; The procedure PROPAGATOR-NAMING-CONVENTION is a macro-helper; it
;;; constructs a pair of names derived from the given name, one to
;;; name the diagram-style variant and one to name the
;;; expression-style variant.

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

;;; These two macros define pairs of propagator objects, one
;;; diagram-style and one expression-style, with the given names.
;;; Said names are presumably computed by
;;; PROPAGATOR-NAMING-CONVENTION.

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

;;; This is (meant to be) just like define, except that it wraps the
;;; body being defined in a with-network-group, which is a hook for
;;; tagging all cells and propagators created inside the call with a
;;; common identity, which can then be passed on to the graph drawing
;;; tools used to inspect the network.  It also assigns the formal
;;; parameter names as names to the incoming arguments.  The latter
;;; is most useful in the regime where all the passed arguments are
;;; actually cells (as opposed to, say, Scheme-lists of cells).

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

(define-syntax define-%delayed-propagator
  (syntax-rules ()
    ((define-%delayed-propagator names (arg ...)
       body ...)
     (define-by-diagram-variant names
       (name!
	(lambda-delayed-propagator (arg ...)
	  body ...)
	(car 'names))))))

(define-syntax define-delayed-propagator
  (rsc-macro-transformer
   (lambda (form defn-env)
     (let ((name (caadr form))
	   (formals (cdadr form))
	   (body (cddr form)))
       `(define-%delayed-propagator
	  ,(propagator-naming-convention name) ,formals ,@body)))))

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
