;;; ----------------------------------------------------------------------
;;; Copyright 2010 Alexey Radul.
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

;;;; Closures, physical-copies style

;;; A normal propagator constructor in the physical copies style is a
;;; Scheme procedure that, when given some cells, will build some
;;; quantity of network structure onto those cells.  As stated, these
;;; are expected not to be closed (in Scheme) over anything
;;; interesting.

;;; A closure in the physical copies style is a propagator constructor
;;; that may be closed over some cells, together with an explicit list
;;; of those cells.  The list needs to be explicit because in order to
;;; merge closures, I have to merge the cells they are closed over.
;;; (Cell merging is such that the underlying Scheme closures that
;;; implement the propagator construction do not need to be modified
;;; when this happens).

;;; Requiring physical-copies closures to close only over cells
;;; amounts to specifying the "carrying cells" strategy for compound
;;; data, at least with regard to closures.  This feels like the right
;;; thing; but in principle there is no reason to insist on it.  To do
;;; "copying data", MAKE-CLOSURE would need to construct a propagator
;;; that would rebuild the closure every time any of the cells the
;;; enviornment grabs experienced any changes, and APPLICATION, below,
;;; would need to be adjusted accordingly (how, exactly?)  All this
;;; would be perfectly plausible too, with the same pros and cons of
;;; the regular "carrying" vs "copying" debate.  Note that the actual
;;; closure data structure, except for MAKE-CLOSURE, is completely
;;; independent of the carrying vs copying choice, just like the
;;; actual partial information type definition for CONS.

;;; The code-tag field is a hack to let me detect "equality" between
;;; two Scheme closures that have the same code but are closed over
;;; different cells.  Such are the moral equivalent of identical data
;;; structures with different contents, and so are mergeable; whereas
;;; Scheme closures with different code are like data structures of
;;; different types and so are not mergeable.

(define-structure
  (closure (constructor %make-closure) (safe-accessors #t))
  code-tag
  code
  environment
  propagator-style?)

(define (make-closure code-tag code environment)
  (%make-closure code-tag code (map ensure-cell environment) #t))

(define (make-e:closure code-tag code environment)
  (%make-closure code-tag code (map ensure-cell environment) #f))

(define (same-code? closure1 closure2)
  (and (eq? (closure-code-tag closure1) (closure-code-tag closure2))
       (eqv? (closure-propagator-style? closure1)
	     (closure-propagator-style? closure2))))

(define (closure-merge closure1 closure2)
  (if (not (same-code? closure1 closure2))
      the-contradiction
      (effectful-bind (merge (closure-environment closure1)
			     (closure-environment closure2))
	(lambda (new-env)
	  (%make-closure
	   (closure-code-tag closure1)
	   (closure-code closure1)
	   new-env
	   (closure-propagator-style? closure1))))))

(define (equivalent-closures? closure1 closure2)
  (or (eqv? closure1 closure2)
      (and (closure? closure1)
	   (closure? closure2)
	   (eq? (closure-code-tag closure1) (closure-code-tag closure2))
	   (equivalent? (closure-environment closure1)
			(closure-environment closure2)))))

(define (contradictory-closure? closure)
  (contradictory? (closure-environment closure)))

(defhandler merge closure-merge closure? closure?)
(defhandler equivalent? equivalent-closures? closure? closure?)
(defhandler contradictory? contradictory-closure? closure?)

(declare-coercion rtd:closure ->v&s)

;;;; Applying the contents of cells

;;; APPLICATION is to the propagator world what APPLY is to Scheme.

;;; Propagator networks may be constructed by directly writing Scheme
;;; code that defines cells and calls various of the propagator
;;; constructor procedures at desired junctures.  This is the moral
;;; equivalent of macrology, the pleasantness and sophistication of
;;; the macro language (Scheme) notwithstanding.  But there is another
;;; way: just as Scheme interprets a combination as a call to the
;;; distinguished procedure APPLY which collects a procedure from a
;;; variable and applies it to arguments, it is sensible to define a
;;; distinguished propagator constructor called APPLICATION which
;;; collects a propagator constructor from a cell and invokes it on
;;; argument cells.

;;; The propagator constructors found in cells may either be
;;; primitive, as defined for example by
;;; FUNCTION->PROPAGATOR-CONSTRUCTOR, DEFINE-MACRO-PROPAGATOR, etc, or
;;; may be closures, per the closure data structure above.  That
;;; distinction is the same as the distinction between primitive and
;;; compound Scheme procedures.

;;; The important thing for APPLICATION to deal with, that's new to
;;; the propagator world and is not found in Scheme, is, of course,
;;; the fact that the available information about the propagator
;;; constructor being applied may be partial; and that APPLICATION
;;; needs to be properly idempotent, because it may be called multiple
;;; times as that partial information is refined.  This is done by
;;; making the transfer of information across the call boundary
;;; conditional on the propagator constructor being applied, with the
;;; effect that both the arguments and the return values inherit any
;;; partialness of that particular propagator constructor indeed being
;;; the one applied.

(define (application closure-cell . arg-cells)
  (let ((closure-cell (ensure-cell closure-cell))
	(arg-cells (map ensure-cell arg-cells)))
    (define done-closures '())
    (define (done? closure)
      (member closure done-closures equivalent-closures?))
    ;; This assumes that closures are "carrying cells" compound
    ;; structures rather than "copying data".
    (define (propagator-style-apply closure pass? arg-cells)
      (apply (closure-body closure)
	     (map (lambda (arg)
		    (let-cell arg-copy
		      (conditional-wire pass? arg arg-copy)
		      arg-copy))
		  arg-cells)))
    (define (expression-style-apply closure pass? arg-cells)
      (let ((input-cells (except-last-pair arg-cells))
	    (output-cell (car (last-pair arg-cells))))
	(conditional-wire pass? output-cell
         (apply (closure-body closure)
		(map (lambda (arg)
		       (let-cell arg-copy
			 (conditional-wire pass? arg arg-copy)
			 arg-copy))
		     input-cells)))))
    (define (attach closure)
      (set! done-closures (cons closure done-closures))
      (let-cells (pass? key)
	(add-content key closure)
	(p:equivalent-closures? closure-cell key pass?)
	(if (propagator-style? closure)
	    (propagator-style-apply closure pass? arg-cells)
	    (expression-style-apply closure pass? arg-cells))
	unspecific))
    (propagator closure-cell
      (name!
       (lambda ()
	 ((unary-mapping
	   (lambda (closure)
	     (if (done? closure)
		 unspecific
		 (attach closure))))
	  (content closure-cell)))
       'application))))

(define e:application (functionalize application))

(define (closure-body thing)
  (cond ((closure? thing)
	 (closure-code thing))
	((propagator-constructor? thing)
	 thing)
	(else (error "No closure body" thing))))

(define (propagator-style? thing)
  (cond ((closure? thing)
	 (closure-propagator-style? thing))
	((propagator-constructor? thing)
	 (not (eq-get thing 'expression-style)))
	(else (error "Propagator style question not applicable" thing))))

(propagatify equivalent-closures? binary-mapping)
