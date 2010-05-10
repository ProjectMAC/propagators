;;; ----------------------------------------------------------------------
;;; Copyright 2010 Alexey Radul and Gerald Jay Sussman
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

(define-structure list-tms
  tag
  car
  cdr)

(define (pre-list-tms-merge list-tms1 list-tms2)
  (make-list-tms
   (merge (list-tms-tag list-tms1)
	  (list-tms-tag list-tms2))
   (merge (list-tms-car list-tms1)
	  (list-tms-car list-tms2))
   (merge (list-tms-cdr list-tms1)
	  (list-tms-cdr list-tms2))))

(define (list-tms-equal? list-tms1 list-tms2)
  (and (eq? (list-tms-tag list-tms1)
	    (list-tms-tag list-tms2))
       (eq? (list-tms-car list-tms1)
	    (list-tms-car list-tms2))
       (eq? (list-tms-cdr list-tms1)
	    (list-tms-cdr list-tms2))))

(define list-tms-merge (eq?-standardizing pre-list-tms-merge list-tms-equal?))

(define (list-tms-able? thing)
  (or (pair? thing)
      (null? thing)
      (nothing? thing)
      (and (tms? thing)
	   (every list-tms-able? (tms-values thing)))
      (and (v&s? thing)
	   (list-tms-able? (v&s-value thing)))))

(define (->list-tms thing)
  (cond ((list-tms? thing)
	 thing)
	((nothing? thing)
	 (make-list-tms
	  (make-tms '()) (make-tms '()) (make-tms '())))
	((null? thing)
	 (make-list-tms
	  (->tms '()) (make-tms '()) (make-tms '())))
	((pair? thing)
	 (make-list-tms
	  (->tms (cons nothing nothing)) (->tms (car thing)) (->tms (cdr thing))))
	((v&s? thing)
	 (cond ((list-tms? (v&s-value thing))
		(make-list-tms
		 (->tms (generic-bind thing list-tms-tag))
		 (->tms (generic-bind thing list-tms-car))
		 (->tms (generic-bind thing list-tms-cdr))))
	       ((list-tms-able? (v&s-value thing))
		(->list-tms
		 (supported (->list-tms (v&s-value thing))
			    (v&s-support thing))))
	       (else
		(error "Inappropriate coersion for ->list-tms" thing))))
	((tms? thing)
	 (reduce merge nothing (map ->list-tms (tms-values thing))))
	(else
	 (error "??? ->list-tms" thing))))

(defhandler merge list-tms-merge list-tms? list-tms?)
(defhandler merge
  (coercing ->list-tms list-tms-merge) list-tms? list-tms-able?)
(defhandler merge
  (coercing ->list-tms list-tms-merge) list-tms-able? list-tms?)

(defhandler merge (coercing ->list-tms list-tms-merge) pair? v&s?)
(defhandler merge (coercing ->list-tms list-tms-merge) v&s? pair?)
(defhandler merge (coercing ->list-tms list-tms-merge) pair? tms?)
(defhandler merge (coercing ->list-tms list-tms-merge) tms? pair?)
(defhandler merge (coercing ->list-tms list-tms-merge) null? v&s?)
(defhandler merge (coercing ->list-tms list-tms-merge) v&s? null?)
(defhandler merge (coercing ->list-tms list-tms-merge) null? tms?)
(defhandler merge (coercing ->list-tms list-tms-merge) tms? null?)

(define generic-tag
  (make-generic-operator 1 'the-tag
    ;; This wants to be an extractor of the Lisp type
    (lambda (x) x)))

(defhandler generic-tag
  list-tms-tag
  list-tms?)

(defhandler generic-tag
  (lambda (x) nothing)
  nothing?)

(defhandler generic-car
  list-tms-car
  list-tms?)

(defhandler generic-cdr
  list-tms-cdr
  list-tms?)

(define p:tag (function->propagator-constructor generic-tag))

;; This is the null? test assuming the tag bits have been separated out
(define %p:null? (function->propagator-constructor (nary-unpacking null?)))
(define %p:pair? (function->propagator-constructor (nary-unpacking pair?)))

(define-macro-propagator (p:null? thing answer)
  (let-cell tag
    (p:tag thing tag)
    (%p:null? tag answer)))

(define-macro-propagator (p:pair? thing answer)
  (let-cell tag
    (p:tag thing tag)
    (%p:pair? tag answer)))

(define e:pair? (functionalize p:pair?))

(define-macro-propagator (c:null? null answer)
  (p:null? null answer)
  (switch answer '() null))

(define ce:null? (functionalize c:null?))
