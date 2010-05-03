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

(define-structure cons-tms
  pair?
  car
  cdr)

(define (pre-cons-tms-merge cons-tms1 cons-tms2)
  (make-cons-tms
   (merge (cons-tms-pair? cons-tms1)
	  (cons-tms-pair? cons-tms2))
   (merge (cons-tms-car cons-tms1)
	  (cons-tms-car cons-tms2))
   (merge (cons-tms-cdr cons-tms1)
	  (cons-tms-cdr cons-tms2))))

(define (cons-tms-equal? cons-tms1 cons-tms2)
  (and (eq? (cons-tms-pair? cons-tms1)
	    (cons-tms-pair? cons-tms2))
       (eq? (cons-tms-car cons-tms1)
	    (cons-tms-car cons-tms2))
       (eq? (cons-tms-cdr cons-tms1)
	    (cons-tms-cdr cons-tms2))))

(define cons-tms-merge (with-equality pre-cons-tms-merge cons-tms-equal?))

(define (->cons-tms thing)
  (cond ((nothing? thing)
	 (make-cons-tms
	  (make-tms '()) (make-tms '()) (make-tms '())))
	((cons-tms? thing)
	 thing)
	((pair? thing)
	 (make-cons-tms
	  (->tms #t) (->tms (car thing)) (->tms (cdr thing))))
	((v&s? thing)
	 (cond ((cons-tms? (v&s-value thing))
		(make-cons-tms
		 (->tms (generic-bind thing cons-tms-pair?))
		 (->tms (generic-bind thing cons-tms-car))
		 (->tms (generic-bind thing cons-tms-cdr))))
	       ((cons-tms-able? (v&s-value thing))
		(->cons-tms
		 (supported (->cons-tms (v&s-value thing))
			    (v&s-support thing))))
	       (else
		(error "Inappropriate coersion for ->cons-tms" thing))))
	((tms? thing)
	 (reduce merge nothing (map ->cons-tms (tms-values thing))))
	(else
	 (error "??? ->cons-tms" thing))))

(define (cons-tms-able? thing)
  (or (tms? thing)
      (v&s? thing)
      (pair? thing)
      (nothing? thing)))

(defhandler merge cons-tms-merge cons-tms? cons-tms?)
(defhandler merge
  (coercing ->cons-tms cons-tms-merge) cons-tms? cons-tms-able?)
(defhandler merge
  (coercing ->cons-tms cons-tms-merge) cons-tms-able? cons-tms?)

(defhandler merge (coercing ->cons-tms cons-tms-merge) pair? v&s?)
(defhandler merge (coercing ->cons-tms cons-tms-merge) v&s? pair?)
(defhandler merge (coercing ->cons-tms cons-tms-merge) pair? tms?)
(defhandler merge (coercing ->cons-tms cons-tms-merge) tms? pair?)

#|
 (pp (merge
      (->cons-tms
       (make-tms
	(supported (cons (make-tms (supported 4 '(fred))) nothing)
		   '(george))))
      (make-tms
       (supported (cons nothing (make-tms (supported 3 '(bill))))
		  '()))))
 #[cons-tms 1161]
 (pair? #(tms (#(supported #t ()))))
 (car #(tms (#(supported 4 (fred george)))))
 (cdr #(tms (#(supported 3 (bill)))))
|#

(define generic-pair? (make-generic-operator 1 'pair? pair?))
(define generic-car (make-generic-operator 1 'car car))
(define generic-cdr (make-generic-operator 1 'cdr cdr))

(define p:pair? (function->propagator-constructor generic-pair?))
(define p:car (function->propagator-constructor generic-car))
(define p:cdr (function->propagator-constructor generic-cdr))

(defhandler generic-pair?
  cons-tms-pair?
  cons-tms?)

(defhandler generic-pair?
  (lambda (x) nothing)
  nothing?)

(defhandler generic-car
  cons-tms-car
  cons-tms?)

(defhandler generic-car
  (lambda (x) nothing)
  nothing?)

(defhandler generic-cdr
  cons-tms-cdr
  cons-tms?)

(defhandler generic-cdr
  (lambda (x) nothing)
  nothing?)

(define p:cons (function->propagator-constructor cons))

(define-macro-propagator (c:car pair thing)
  (p:car pair thing)
  (p:cons thing nothing pair))

(define-macro-propagator (c:cdr pair thing)
  (p:cdr pair thing)
  (p:cons nothing thing pair))

(define-macro-propagator (c:cons thing1 thing2 pair)
  (p:cons thing1 thing2 pair)
  (p:car pair thing1)
  (p:cdr pair thing2))

(define-macro-propagator (c:pair? pair thing)
  (p:pair? pair thing)
  (switch thing (e:cons nothing nothing) pair))

(define e:pair?  (functionalize p:pair?))
(define e:car    (functionalize p:car))
(define e:cdr    (functionalize p:cdr))
(define e:cons   (functionalize p:cons))

(define ce:pair? (functionalize c:pair?))
(define ce:car   (functionalize c:car))
(define ce:cdr   (functionalize c:cdr))
(define ce:cons  (functionalize c:cons))

(in-test-group
 cons-tms
 (define-test (smoke)
   (interaction
    (initialize-scheduler)
    (define-cell bill (make-tms (supported 3 '(bill))))
    (define-cell bill-cons (e:cons nothing bill))
    (define-cell answer)
    (c:== bill-cons answer)
    (define-cell fred (make-tms (supported 4 '(fred))))
    (define-cell fred-cons (e:cons fred nothing))
    (define-cell george (make-tms (supported #t '(george))))
    (conditional-wire george fred-cons answer)
    (define-cell the-pair? (e:pair? answer))
    (define-cell the-car (e:car answer))
    (define-cell the-cdr (e:cdr answer))
    (run)
    (pp (content answer))
    (content the-pair?)
    (produces #(tms (#(supported #t ()))))
    (content the-car)
    (produces #(tms (#(supported 4 (fred george)))))
    (content the-cdr)
    (produces #(tms (#(supported 3 (bill))))))))
