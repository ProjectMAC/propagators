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

;;; A "closure" is a structure containing a code fragment and an
;;; environment.  The environment is a list of cells.  The code
;;; fragment is a Scheme closure, such that the only interesting
;;; things it is closed over are cells listed in the environment.
;;; This is done this way, instead of just using Scheme closures,
;;; because I need to be able to merge the environments of different
;;; closures.  If closures are desired that close over interesting
;;; things that are not cells, a variant can be created where the
;;; Scheme procedure accepts the environment and then returns a new
;;; Scheme procedure to fill the role of the closure-code here.

;;; These closures embody the "carrying cells" strategy.  If I wanted
;;; "copying data", make-closure would need to construct a propagator
;;; that would rebuild the closure every time any of the cells the
;;; enviornment grabs experienced any changes.  That would be
;;; perfectly plausible too, with the same pros and cons of the
;;; regular "carrying" vs "copying" debate.  I chose the carrying
;;; strategy here.

(define-structure
  (closure (constructor %make-closure))
  code-tag
  code
  environment
  propagator-style?)

(define (make-closure code-tag code environment)
  (%make-closure code-tag code (map ensure-cell environment) #t))

(define (make-e:closure code-tag code environment)
  (%make-closure code-tag code (map ensure-cell environment) #f))

(define (same-code? closure1 closure2)
  (eq? (closure-code-tag closure1) (closure-code-tag closure2)))

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
	 (not (eq-get thing 'expression-style?)))
	(else (error "Propagator style question not applicable" thing))))

(define (closure-merge closure1 closure2)
  (if (or (not (same-code? closure1 closure2))
	  (not (eqv? (closure-propagator-style? closure1)
		     (closure-propagator-style? closure2))))
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

(declare-coercion rtd:closure ->v&s)

(defhandler merge closure-merge closure? closure?)
(defhandler equivalent? equivalent-closures? closure? closure?)

(propagatify equivalent-closures? binary-mapping)

(define (application closure-cell . arg-cells)
  (let ((closure-cell (ensure-cell closure-cell))
	(arg-cells (map ensure-cell arg-cells)))
    (define done-closures '())
    (define (done? closure)
      (member closure done-closures equivalent-closures?))
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
      (lambda ()
	((unary-mapping
	  (lambda (closure)
	    (if (done? closure)
		unspecific
		(attach closure))))
	 (content closure-cell))))))

(define e:application (functionalize application))
