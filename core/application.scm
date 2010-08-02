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

