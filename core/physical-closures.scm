;;; ----------------------------------------------------------------------
;;; Copyright 2010 Alexey Radul.
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
;;; environment grabs experienced any changes, and APPLICATION, below,
;;; would need to be adjusted accordingly (how, exactly?)  All this
;;; would be perfectly plausible, with the same pros and cons as the
;;; regular "carrying" vs "copying" debate.  Note that the actual
;;; closure data structure, except for MAKE-CLOSURE, is completely
;;; independent of the carrying vs copying choice, just like the
;;; actual partial information type definition for CONS.

;;; The code-tag field is a hack to let me detect "equality" between
;;; two Scheme closures that have the same code but are closed over
;;; different cells.  Such are the moral equivalent of identical data
;;; structures with different contents, and so are mergeable; whereas
;;; Scheme closures with different code are like data structures of
;;; different types and so are not mergeable.

;;; TODO Capture this pattern in a version of define-structure that
;;; creates applicable records?
(define-structure
  (%closure (safe-accessors #t))
  code
  environment
  diagram-style?)

(define (%make-closure code environment diagram-style?)
  (make-entity
   (lambda (self . args)
     (apply application self args))
   (make-%closure code environment diagram-style?)))

(define (closure? thing)
  (and (entity? thing)
       (%closure? (entity-extra thing))))

(define (closure-code-tag thing)
  (procedure-lambda (%closure-code (entity-extra thing))))

(define (closure-code thing)
  (%closure-code (entity-extra thing)))

(define (closure-environment thing)
  (%closure-environment (entity-extra thing)))

(define (closure-diagram-style? thing)
  (%closure-diagram-style? (entity-extra thing)))

(define (closure-copy closure)
  (eq-clone! closure
   (%make-closure (closure-code closure)
		  (closure-environment closure)
		  (closure-diagram-style? closure))))

;; The ensure-cell here makes these be "carrying cells" structures.
(define (make-closure code environment)
  (name-closure!
   (%make-closure code (map ensure-cell environment) #t)))

(define (make-e:closure code environment)
  (name-closure!
   (%make-closure code (map ensure-cell environment) #f)))

(define (name-closure! closure)
  (cond ((eq-get closure 'name) closure) ; ok
	((eq-get (closure-code closure) 'name)
	 (name! closure (closure-code closure)))
	((symbol? (closure-code-tag closure))
	 (name! closure (closure-code-tag closure)))
	(else ; nothing works
	 closure)))

(define (same-code? closure1 closure2)
  (and (eq? (closure-code-tag closure1) (closure-code-tag closure2))
       (eqv? (closure-diagram-style? closure1)
	     (closure-diagram-style? closure2))))

(define (closure-merge closure1 closure2)
  (if (not (same-code? closure1 closure2))
      the-contradiction
      (effectful-bind (merge (closure-environment closure1)
			     (closure-environment closure2))
	(lambda (new-env)
	  (%make-closure
	   (closure-code closure1)
	   new-env
	   (closure-diagram-style? closure1))))))

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

;;; There is also a less important thing that APPLICATION needs to
;;; deal with, that doesn't happen in Scheme, and that's the
;;; distinction between diagram-style and expression-style
;;; propagator constructors.  The former are more general, but require
;;; all their boundary cells, including those for holding "return"
;;; values, to be passed in to them, and ignore the Scheme return
;;; value channel.  The latter are more convenient, because they will
;;; synthesize and return a cell for the "return value" of the
;;; computation they represent.  APPLICATION needs to be able to apply
;;; either kind; and being a propagator constructor itself,
;;; APPLICATION comes in both flavors.

(define (do-apply-prop prop real-args)
  (let ((real-args (map ensure-cell real-args)))
    (with-network-group (network-group-named (name prop))
      (lambda ()
	(apply (prop-body prop) real-args)))))

(define (general-propagator-apply prop-cell arg-cells)
  (define done-props '())
  (define (done? prop)
    (member prop done-props equivalent-closures?))
  (define (arg-copier pass?)
    (lambda (arg)
      (let-cell arg-copy
	(conditional-wire pass? (ensure-cell arg) arg-copy)
	arg-copy)))
  ;; This assumes that closures are "carrying cells" compound
  ;; structures rather than "copying data".
  (define (apply-diagram-style prop pass? arg-cells)
    (do-apply-prop prop (map (arg-copier pass?) arg-cells)))
  (define (apply-expression-style prop pass? arg-cells)
    (let ((input-cells (except-last-pair arg-cells))
	  (output-cell (car (last-pair arg-cells))))
      (conditional-wire pass? output-cell
	(ensure-cell
	 (do-apply-prop
	  prop (map (arg-copier pass?) input-cells))))))
  (define (attach prop)
    (set! done-props (cons prop done-props))
    (with-network-group
     (network-group-named `(attachment ,(name prop)))
     (lambda ()
       (let-cells (pass? key)
	 (add-content key prop)
	 (p:equivalent-closures? prop-cell key pass?)
	 (if (diagram-style? prop)
	     (apply-diagram-style prop pass? arg-cells)
	     (apply-expression-style prop pass? arg-cells))
	 unspecific))))
  (let ((the-propagator
	 (lambda ()
	   ((unary-mapping
	     (lambda (prop)
	       (if (done? prop)
		   unspecific
		   (attach prop))))
	    (content prop-cell)))))
    (eq-label! the-propagator
     'name 'application 'inputs (list prop-cell) 'outputs arg-cells)
    (propagator prop-cell the-propagator)))

(define (eager-diagram-apply prop arg-cells)
  (if (diagram-style? prop)
      (do-apply-prop prop arg-cells)
      (c:== (car (last-pair arg-cells))
	    (do-apply-prop prop (except-last-pair arg-cells)))))

(define (eager-expression-apply prop arg-cells)
  (if (diagram-style? prop)
      (apply
       (handling-implicit-cells
	(lambda cells
	  (do-apply-prop prop cells)))
       arg-cells)
      (do-apply-prop prop arg-cells)))

(define (directly-applicable? thing)
  (or (closure? thing)
      (propagator-constructor? thing)))

(define (prefers-diagram-style? thing)
  (let ((preference-tag (eq-get thing 'preferred-style)))
    (cond (preference-tag
	   (not (eq? preference-tag 'expression)))
	  ((closure? thing)
	   (closure-diagram-style? thing))
	  (else #t))))

(define (try-eager-application object direct-apply general-apply)
  (if (cell? object)
      (if (directly-applicable? (content object))
	  (direct-apply (content object))
	  (general-apply object))
      (if (directly-applicable? object)
	  (direct-apply object)
	  (general-apply (ensure-cell object)))))

(define (p:application object . arg-cells)
  (try-eager-application object
   (lambda (object)
     (eager-diagram-apply object arg-cells))
   (lambda (cell)
     (general-propagator-apply cell arg-cells))))

(define (application object . arg-cells)
  (try-eager-application object
   (lambda (object)
     (if (prefers-diagram-style? object)
	 (eager-diagram-apply object arg-cells)
	 (eager-expression-apply object arg-cells)))
   (lambda (cell)
     (general-propagator-apply cell arg-cells))))

(define e:application (functionalize p:application))
(define d@ p:application)
(define @d d@)
(define e@ e:application)
(define @e e@)

(define (prop-body thing)
  (cond ((closure? thing)
	 (closure-code thing))
	((propagator-constructor? thing)
	 thing)
	(else (error "No prop body" thing))))

(define (diagram-style? thing)
  (cond ((closure? thing)
	 (closure-diagram-style? thing))
	((propagator-constructor? thing)
	 (not (eq-get thing 'expression-style)))
	(else (error "Propagator style question not applicable" thing))))

(initialize-scheduler)			; propagatify makes cells!

(propagatify equivalent-closures? binary-mapping)
