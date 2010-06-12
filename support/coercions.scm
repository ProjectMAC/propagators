;;; ----------------------------------------------------------------------
;;; Copyright 2010 Alexey Radul
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

(declare (usual-integrations))

(define (coercability-tester name)
  (make-generic-operator 1 name (lambda (x) #f)))

(define (coercer name #!optional operation)
  (make-generic-operator 1 name operation))

(define (tag-with-coercer thing coercer)
  (eq-put! thing 'coercer coercer))

(define (specify operation type #!optional coercion)
  (if (not (default-object? coercion))
      (let ((the-coercer (eq-get operation 'coercer)))
	(if the-coercer
	    (defhandler the-coercer coercion type)
	    (error "No coercer available for" operation))))
  (defhandler operation (lambda (thing) #t) type))

(define-syntax declare-named-coercions
  (syntax-rules ()
    ((_ predicate-name coercability-name coercer-name operation)
     (begin
       (define coercability-name
	 (coercability-tester 'coercability-name))
       (define coercer-name
	 (coercer 'coercer-name operation))
       (defhandler coercer-name (lambda (x) x) predicate-name)
       (tag-with-coercer coercability-name coercer-name)))
    ((_ predicate-name coercability-name coercer-name)
     (declare-named-coercions
      predicate-name coercability-name coercer-name #!default))))

(define-syntax declare-coercions
  (sc-macro-transformer
   (lambda (form use-env)
     (let ((name (cadr form))
	   (opt-operation (cddr form)))
       (let ((pred-name (symbol name '?))
	     (coerability-name (symbol name '-able?))
	     (coercer-name (symbol '-> name)))
	 `(declare-named-coercions
	   ,pred-name ,coerability-name, coercer-name ,@opt-operation))))))
