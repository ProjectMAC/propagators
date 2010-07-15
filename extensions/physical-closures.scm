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
;;; fragment is a procedure that, when applied to the environment,
;;; produces a procedure that can be applied to new cells.  This is
;;; done this way, instead of using Scheme closures, because I need to
;;; be able to merge the environments of different closures.

(define-structure
  (closure (constructor %make-closure))
  code-tag
  code
  environment
  propagator-style?)

(define (make-closure code-tag code environment)
  (%make-closure code-tag code environment #t))

(define (make-e:closure code-tag code environment)
  (%make-closure code-tag code environment #f))

(define (same-code? closure1 closure2)
  (eq? (closure-code-tag closure1) (closure-code-tag closure2)))

(define (closure-prepare closure)
  (apply (closure-code closure) (closure-environment closure)))

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
  (and (eq? (closure-code-tag closure1) (closure-code-tag closure2))
       (equivalent? (closure-environment closure1)
		    (closure-environment closure2))))

(declare-coercion rtd:closure ->v&s)

(defhandler merge closure-merge closure? closure?)
(defhandler equivalent? equivalent-closures? closure? closure?)

(propagatify equivalent-closures? binary-mapping)

;;; This application applies the underlying closure propagator-style,
;;; not expression-style.
(define (application closure-cell . arg-cells)
  (let ((closure-cell (ensure-cell closure-cell))
	(arg-cells (map ensure-cell arg-cells)))
    (define done-closures '())
    (define (done? closure)
      (member closure done-closures equivalent-closures?))
    (define (propagator-style-apply closure pass? arg-cells)
      (apply (closure-prepare closure)
	     (map (lambda (arg)
		    (let-cell arg-copy
		      (conditional-wire pass? arg arg-copy)
		      arg-copy))
		  arg-cells)))
    (define (expression-style-apply closure pass? arg-cells)
      (let ((input-cells (except-last-pair arg-cells))
	    (output-cell (car (last-pair arg-cells))))
	(conditional-wire pass? output-cell
         (apply (closure-prepare closure)
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
	(if (closure-propagator-style? closure)
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
