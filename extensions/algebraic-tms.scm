;;; ----------------------------------------------------------------------
;;; Copyright 2010 Alexey Radul and Gerald Jay Sussman
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

(define *algebraic-types* '())

(define-structure algebraic-type
  predicate
  constructor
  accessors)

(define (algebraic? thing)
  (apply boolean/or
   (map (lambda (type)
	  ((algebraic-type-predicate type) thing))
	*algebraic-types*)))

(define (algebraic-type-of thing)
  (let ((candidates (filter (lambda (type)
			      ((algebraic-type-predicate type) thing))
			    *algebraic-types*)))
    (cond ((= 0 (length candidates))
	   (error "Not an algebraic object" thing))
	  ((= 1 (length candidates))
	   (car candidates))
	  (else (error "Algebraic types not exclusive" thing)))))

(define (algebraic-tag thing)
  (let ((type (algebraic-type-of thing)))
    (apply (algebraic-type-constructor type)
	   (map (lambda (accessor)
		  nothing)
		(algebraic-type-accessors type)))))

(define (algebraic-accessors thing)
  (algebraic-type-accessors (algebraic-type-of thing)))

(define (declare-algebraic predicate constructor . accessors)
  (set! *algebraic-types*
	(cons (make-algebraic-type predicate constructor accessors)
	      *algebraic-types*)))

(define-structure algebraic-tms
  fields)
(declare-type-tester algebraic-tms? rtd:algebraic-tms)

(define (algebraic-tms-merge atms1 atms2)
  (effectful-bind (merge-alist (algebraic-tms-fields atms1)
			       (algebraic-tms-fields atms2))
    make-algebraic-tms))

(define (algebraic-tms-equal? atms1 atms2)
  (and (algebraic-tms? atms1)
       (algebraic-tms? atms2)
       (same-alist? (algebraic-tms-fields atms1)
		    (algebraic-tms-fields atms2))))

(declare-coercion-target algebraic-tms)

(declare-coercion algebraic? ->algebraic-tms
  (lambda (thing)
    (make-algebraic-tms
     `((,algebraic-tag . ,(->tms (algebraic-tag thing)))
       ,@(map (lambda (accessor)
		(cons accessor (->tms (accessor thing))))
	      (algebraic-accessors thing))))))

(declare-coercion nothing? ->algebraic-tms
  (lambda (thing) (make-algebraic-tms '())))

(declare-coercion
 (lambda (thing)
   (and (tms? thing)
	(every algebraic-tms-able? (tms-values thing))))
 ->algebraic-tms
 (lambda (thing)
   (merge* (map ->algebraic-tms (tms-values thing)))))

(declare-coercion
 (lambda (thing)
   (and (v&s? thing)
	(or (algebraic-tms? (v&s-value thing))
	    (algebraic-tms-able? (v&s-value thing)))))
 ->algebraic-tms
 (lambda (thing)
   (cond ((algebraic-tms? (v&s-value thing))
	  (make-algebraic-tms
	   (map (lambda (accessor)
		  (cons accessor
			(->tms (generic-bind thing
				(handling-algebraic-partial-information
				 accessor)))))
		(map car (algebraic-tms-fields (v&s-value thing))))))
	 ((algebraic-tms-able? (v&s-value thing))
	  (->algebraic-tms
	   (supported (->algebraic-tms (v&s-value thing))
		      (v&s-support thing))))
	 (else (error "Inappropriate coersion for ->algebraic-tms" thing)))))

(defhandler-coercing merge algebraic-tms-merge ->algebraic-tms)
(defhandler-coercing equivalent? algebraic-tms-equal? ->algebraic-tms)

(defhandler merge
  (coercing ->algebraic-tms algebraic-tms-merge) algebraic? v&s?)
(defhandler merge
  (coercing ->algebraic-tms algebraic-tms-merge) v&s? algebraic?)
(defhandler merge
  (coercing ->algebraic-tms algebraic-tms-merge) algebraic? tms?)
(defhandler merge
  (coercing ->algebraic-tms algebraic-tms-merge) tms? algebraic?)

(define (handling-algebraic-partial-information accessor)
  ;;; TODO handling-algebraic-partial-information wants to be generic
  (lambda (info)
    (cond ((nothing? info)
	   nothing)
	  ((algebraic-tms? info)
	   (tms-> (information-assq accessor (algebraic-tms-fields info))))
	  (else (accessor info)))))

(define %p:tag (function->propagator-constructor
		(handling-algebraic-partial-information algebraic-tag)))

(define-method generic-match ((pattern <vector>) (object rtd:algebraic-tms))
  (generic-match
   pattern
   (vector 'algebraic-tms 
	   (information-assq algebraic-tag (algebraic-tms-fields object))
	   (alist-delete algebraic-tag (algebraic-tms-fields object) eq?))))

;;; Nulls

; This for completeness
(define null (lambda () '()))

(declare-algebraic null? null)

(define %p:copy-null?
  (function->propagator-constructor
   (unary-mapping null?)))

(define-propagator-syntax (p:copy-null? thing answer)
  (let-cell tag
    (%p:tag thing tag)
    (%p:copy-null? tag answer)))

(define copy-null null)
(propagatify copy-null)

(define-propagator (c:copy-null? thing answer)
  (p:copy-null? thing answer)
  (switch answer (e:copy-null) thing))

(define-propagator (c:copy-null answer)
  (p:copy-null answer))

(define e:copy-null? (expression-style-variant p:copy-null?))

;;; Pairs

(declare-algebraic pair? cons car cdr)

(define %p:copy-pair?
  (function->propagator-constructor (unary-mapping pair?)))

(define-propagator-syntax (p:copy-pair? thing answer)
  (let-cell tag
    (%p:tag thing tag)
    (%p:copy-pair? tag answer)))

(define p:copy-cons (function->propagator-constructor cons))

(define p:copy-car (function->propagator-constructor
		    (handling-algebraic-partial-information car)))

(define p:copy-cdr (function->propagator-constructor
		    (handling-algebraic-partial-information cdr)))

(define-propagator (c:copy-pair? pair answer)
  (p:copy-pair? pair answer)
  (switch answer (e:copy-cons nothing nothing) pair))

(define-propagator (c:copy-cons thing1 thing2 pair)
  (p:copy-cons thing1 thing2 pair)
  (p:copy-car pair thing1)
  (p:copy-cdr pair thing2))

(define-propagator (c:copy-car pair answer)
  (p:copy-car pair answer)
  (p:copy-cons answer nothing pair))

(define-propagator (c:copy-cdr pair answer)
  (p:copy-cdr pair answer)
  (p:copy-cons nothing answer pair))

(define e:copy-pair?  (expression-style-variant p:copy-pair?))
(define e:copy-cons   (expression-style-variant p:copy-cons))
(define e:copy-car    (expression-style-variant p:copy-car))
(define e:copy-cdr    (expression-style-variant p:copy-cdr))
