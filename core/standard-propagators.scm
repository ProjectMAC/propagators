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

;;; Standard primitive propagators

(define adder
  (function->propagator-constructor (nary-unpacking generic-+)))
(define subtractor
  (function->propagator-constructor (nary-unpacking generic--)))
(define multiplier
  (function->propagator-constructor (nary-unpacking generic-*)))
(define divider
  (function->propagator-constructor (nary-unpacking generic-/)))

(define absolute-value
  (function->propagator-constructor (nary-unpacking generic-abs)))
(define squarer
  (function->propagator-constructor (nary-unpacking generic-square)))
(define sqrter
  (function->propagator-constructor (nary-unpacking generic-sqrt)))

(define =? (function->propagator-constructor (nary-unpacking generic-=)))
(define <? (function->propagator-constructor (nary-unpacking generic-<)))
(define >? (function->propagator-constructor (nary-unpacking generic->)))
(define <=? (function->propagator-constructor (nary-unpacking generic-<=)))
(define >=? (function->propagator-constructor (nary-unpacking generic->=)))

(define inverter
  (function->propagator-constructor (nary-unpacking generic-not)))
(define conjoiner
  (function->propagator-constructor (nary-unpacking generic-and)))
(define disjoiner
  (function->propagator-constructor (nary-unpacking generic-or)))

(define pass-through
  (function->propagator-constructor identity))

(define switch
  (function->propagator-constructor (nary-unpacking switch-function)))

(define (constant value)
  (function->propagator-constructor
   #; (lambda () value)
   (eq-label! (lambda () value) 'name `(constant ,value))))

;;; Standard "propagator macros"

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
     (named-lambda (name arg-form ...)
       (with-network-group (network-group-named 'name)
	 (lambda ()
	   (name-locally! arg-form 'arg-form) ...
	   body-form ...))))))

;;; This version is just like define-propagator-syntax, but expects
;;; all its arguments to actually be cells, and enforces that
;;; expectation with ENSURE-CELL.
(define-syntax define-macro-propagator
  (syntax-rules ()
    ((define-macro-propagator (name arg-form ...) body-form ...)
     (define name
       (named-macro-propagator (name arg-form ...) body-form ...)))))

;;; This is the "lambda" to define-macro-propagator's "define".
(define-syntax named-macro-propagator
  (syntax-rules ()
    ((named-macro-propagator stuff ...)
     (coercing ensure-cell (named-propagator-syntax stuff ...)))))

;;; This version is just like define-macro-propagator, but
;;; additionally allows the body to be recursive by delaying its
;;; expansion until there is some information in at least one of the
;;; neighbor cells.
(define-syntax define-compound-propagator
  (syntax-rules ()
    ((define-compound-propagator (name arg-form ...) body-form ...)
     (define name
       (named-compound-propagator (name arg-form ...)
	 body-form ...)))))

;;; This is the "lambda" to define-compound-propagator's "define".
(define-syntax named-compound-propagator
  (syntax-rules ()
    ((named-compound-propagator stuff ...)
     (delayed-propagator-constructor
      (named-macro-propagator stuff ...)))))

;;; More remains to be done before I can really make a
;;; propagator-lambda macro, or its corresponding define.  I would
;;; need to settle on the representation of closures --- all the above
;;; produce raw Scheme procedures.  I would also need to settle on the
;;; behavior of closures --- the above use physical copies and
;;; primitive delaying as their abstraction strategy.  Finally, I
;;; would need a story for variable arity procedures, which is
;;; basically the same as the story for compound data.  (And at the
;;; end I would need to adjust the above to define-cell instead of
;;; define, and to return cells instead raw values, but that's easy.)

;;; TODO Here's an idea: maybe the arguments to the Scheme procedures
;;; produced by define-macro-propagator and company should be
;;; optional.  If any are not supplied, that macro can just generate
;;; them.  It may also be fun to standardize on a mechanism like
;;; E:INSPECTABLE-OBJECT and THE from the circuits exploration for
;;; reaching in and grabbing such cells from the outside.

;;; TODO Philosophical clarification that probably needs to be
;;; implemented: Abstractions should always make their own cells for
;;; their formal parameters.  Call sites should attach arguments to
;;; callees with identity-like propagators. (If some argument cells
;;; are omitted from the argument list, just fail to attach anything
;;; to those parameters).  Cons should operate the same as it would
;;; under Church encoding: make its own cells, id-copy its arguments
;;; into them, and then carry those cells around.  This is neither the
;;; "carrying cells" strategy, because the argument cells are not
;;; carried, nor the "copying data" strategy, because the contents of
;;; the cons are not copied every time.  The advantage of this pattern
;;; is that cells really become very analagous to Scheme memory
;;; locations.  Incidentally, this idea is independent of physical vs
;;; virtual copies.

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

;; TODO rconjoiner and rdisjoiner got lost in the interminable shuffles,
;; so these don't work any more.
#;
(define (and-constraint p1 p2 conjunction)
  (conjoiner p1 p2 conjunction)
  (rconjoiner conjunction p1 p2))
#;
(define (or-constraint p1 p2 disjunction)
  (disjoiner p1 p2 disjunction)
  (rdisjoiner disjunction p1 p2))
