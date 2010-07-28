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

;;;; Carcinogens for the semicolon

;;; Here be macros that provide syntactic sugar for playing with the
;;; propagator language as embedded in Scheme.  Syntactic regularities
;;; in patterns of definition of cells and propagator constructors are
;;; captured.

;;;; Defining cells

;; (define-cell foo form)
;; is the same as
;; (define foo (ensure-cell form))
;; except it grabs the name foo and associates it with the
;; cell that form constructs.
;;
;; For the frequent case when you want a fresh cell
;; (define-cell foo)
;; expands into
;; (define-cell foo (make-named-cell 'foo))
;; The metadata is then available two ways.

(define-syntax define-cell
  (syntax-rules ()
    ((define-cell symbol form)
     (define symbol (name-locally! (ensure-cell form) 'symbol)))
    ((define-cell symbol)
     (define-cell symbol (make-named-cell 'symbol)))))

;; (let-cells ((foo foo-form)
;;             (bar bar-form)
;;             (baz baz-form))
;;   stuff)
;; is the same as 
;; (let ((foo (ensure-cell foo-form))
;;       (bar (ensure-cell bar-form))
;;       (baz (ensure-cell baz-form)))
;;   stuff)
;; except that it captures the names foo bar and baz and associates
;; them with the cells that the corresponding forms return.
;;
;; For the frequent case when you want fresh cells
;; (let-cells (foo bar baz)
;;   stuff)
;; expands into
;; (let-cells ((foo (make-named-cell 'foo))
;;             (bar (make-named-cell 'bar))
;;             (baz (make-named-cell 'baz)))
;;   stuff)
;; The metadata is then available two ways.

;; The following would suffice for the above:
#;
 (define-syntax let-cells
   (syntax-rules ()
     ((let-cells ((name form) ...)
	form ...)
      (let ((name (name-locally! (ensure-cell form) 'name)) ...)
	form ...))
     ((let-cells (name ...)
	form ...)
      (let-cells ((name (make-named-cell 'name))...)
	form ...))))

;; The much more horrible LET-CELLS macro below allows the two use
;; patterns above to mix, as follows,
;; (let-cells ((foo foo-form)
;;             bar
;;             (baz baz-form))
;;   stuff)
;; and have the right thing happen.  It also interprets the
;; slightly more traditional
;; (let-cells ((foo foo-form)
;;             (bar)
;;             (baz baz-form))
;;   stuff)
;; in agreement with Scheme's let.

(define-syntax let-cells
  (syntax-rules ()
    ((let-cells (cell-binding ...)
       form ...)
     (let-cells "process-clauses"
       (cell-binding ...)
       ()
       form ...))
    ((let-cells "process-clauses"
       ()
       ((cell-name cell-form) ...)
       form ...)
     (let ((cell-name (name-locally! (ensure-cell cell-form) 'cell-name)) ...)
       form ...))
    ((let-cells "process-clauses"
       ((cell-name cell-form) clause ...)
       (done-clause ...)
       form ...)
     (let-cells "process-clauses"
       (clause ...)
       ((cell-name cell-form) done-clause ...)
       form ...))
    ((let-cells "process-clauses"
       ((cell-name) clause ...)
       (done-clause ...)
       form ...)
     (let-cells "process-clauses"
       (cell-name clause ...)
       (done-clause ...)
       form ...))
    ((let-cells "process-clauses"
       (cell-name clause ...)
       (done-clause ...)
       form ...)
     (let-cells "process-clauses"
       (clause ...)
       ((cell-name (make-named-cell 'cell-name)) done-clause ...)
       form ...))))

;; This version is a grammatical convenience if there is only one
;; cell.  (let-cell (foo foo-form) stuff) and (let-cell foo stuff) are
;; both ok and equivalent to (let-cells ((foo foo-form)) stuff) and
;; (let-cells (foo) stuff), respectively, which are more awkward to
;; read.

(define-syntax let-cell
  (syntax-rules ()
    ((let-cell cell-binding
       form ...)
     (let-cells (cell-binding)
       form ...))))

;; And here is the moral equivalent of let*
(define-syntax let-cells*
  (syntax-rules ()
    ((let-cells* (binding bindings ...)
       form ...)
     (let-cell binding
       (let-cells* (bindings ...)
	 form ...)))
    ((let-cells* ()
       form ...)
     (let-cells ()
       form ...))))

;; TODO Do I need let-cells-rec?  What would that do for me?

;;;; Defining propagators

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

;;; This version is just like define-propagator-syntax, but allows the
;;; body to be recursive by delaying its expansion until there is some
;;; information in at least one of the neighbor cells.  This has the
;;; effect of requiring the neighbors to indeed be cells.
(define-syntax define-recursive-propagator
  (syntax-rules ()
    ((define-recursive-propagator (name arg-form ...) body-form ...)
     (define name
       (named-recursive-propagator (name arg-form ...)
	 body-form ...)))))

;;; This is the "lambda" to define-recursive-propagator's "define".
(define-syntax named-recursive-propagator
  (syntax-rules ()
    ((named-recursive-propagator stuff ...)
     (delayed-propagator-constructor (named-propagator-syntax stuff ...)))))

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
