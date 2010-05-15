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

;;; This appears to be the right story for merging compound data,
;;; regardless of the choice between the "copying data" or "carrying
;;; cells" representations.  I say "appears" because it might be
;;; wrong.

(define (pair-merge pair1 pair2)
  (effectful-bind (merge (car pair1) (car pair2))
    (lambda (car-answer)
      (effectful-bind (merge (cdr pair1) (cdr pair2))
	(lambda (cdr-answer)
	  (cond ((and (eq? (car pair1) car-answer)
		      (eq? (cdr pair1) cdr-answer))
		 pair1)
		((and (eq? (car pair2) car-answer)
		      (eq? (cdr pair2) cdr-answer))
		 pair2)
		(else
		 (cons car-answer cdr-answer))))))))

(defhandler merge pair-merge pair? pair?)

;;; The generalization to arbitrary product types:

(define (slotful-information-type predicate? constructor . accessors)
  (define (slotful-merge thing1 thing2)
    (let* ((slots1 (map (lambda (accessor) (accessor thing1))
			accessors))
	   (slots2 (map (lambda (accessor) (accessor thing2))
			accessors)))
      (effectful-list-bind (map merge slots1 slots2)
	(lambda (submerges)
	  (let ((ok1? (apply boolean/and (map eq? submerges slots1)))
		(ok2? (apply boolean/and (map eq? submerges slots2))))
	    (cond (ok1? thing1)
		  (ok2? thing2)
		  (else (apply constructor submerges))))))))
  (defhandler merge slotful-merge predicate? predicate?)
  
  (define (slotful-contradiction? thing)
    (apply boolean/or (map contradictory? (map (lambda (accessor)
						 (accessor thing))
					       accessors))))
  (defhandler contradictory? slotful-contradiction? predicate?))

;;; The "copying data" strategy from the thesis is given by these
;;; definitions of the cons-car-cdr propagators:

(define conser (function->propagator-constructor cons))
(define carer (function->propagator-constructor (nary-unpacking car)))
(define cdrer (function->propagator-constructor (nary-unpacking cdr)))

;;; The "carrying cells" strategy is elaborated in
;;; extensions/carrying-cells.scm.  Since the merging is the same in
;;; both cases, the two strategies may be intermixed within the same
;;; network --- just make sure your propagators know what to expect
;;; (and there is as yet no good story for merging a piece of data and
;;; a cell, so merging a carrying cons with a copying cons will not do
;;; anything good).

;;; Test slotful structure
(define-structure (kons (constructor kons))
  kar
  kdr)

(slotful-information-type kons? kons kons-kar kons-kdr)
(define konser (function->propagator-constructor kons))
(define karer (function->propagator-constructor (nary-unpacking kons-kar)))
(define kdrer (function->propagator-constructor (nary-unpacking kons-kdr)))

(define-method generic-match ((pattern <vector>) (object rtd:kons))
  (generic-match
   pattern
   (vector 'kons (kons-kar object) (kons-kdr object))))
