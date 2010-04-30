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

(define conser (function->propagator-constructor cons))

(define carer (function->propagator-constructor (nary-unpacking car)))

(define (pair-merge pair1 pair2)
  (let ((car-answer (merge (car pair1) (car pair2)))
        (cdr-answer (merge (cdr pair1) (cdr pair2))))
    (cond ((and (eq? (car pair1) car-answer)
                (eq? (cdr pair1) cdr-answer))
           pair1)
          ((and (eq? (car pair2) car-answer)
                (eq? (cdr pair2) cdr-answer))
           pair2)
          (else
           (cons car-answer cdr-answer)))))

(defhandler merge pair-merge pair? pair?)

;;; The generalization (though I don't know whether this strategy is right):
(define (slotful-information-type predicate? constructor . accessors)
  (define (slotful-merge thing1 thing2)
    (let* ((slots1 (map (lambda (accessor) (accessor thing1))
			accessors))
	   (slots2 (map (lambda (accessor) (accessor thing2))
			accessors))
	   (submerges (map merge slots1 slots2))
	   (ok1? (apply boolean/and (map eq? submerges slots1)))
	   (ok2? (apply boolean/and (map eq? submerges slots2))))
      (cond (ok1? thing1)
	    (ok2? thing2)
	    (else (apply constructor submerges)))))
  (defhandler merge slotful-merge predicate? predicate?)
  
  (define (slotful-contradiction? thing)
    (apply boolean/or (map contradictory? (map (lambda (accessor)
						 (accessor thing))
					       accessors))))
  (defhandler contradictory? slotful-contradiction? predicate?))

;;; This strategy is presented in the text as an alternative to the
;;; preceding.  I choose not to enable it by default.
#|
 (define (conser a-cell d-cell output)
   (propagator ()                        ; That's right, no inputs.
     (lambda ()
       (add-content output
	 (cons a-cell d-cell)))))

 (define (carer cons-cell output)
   (propagator (list cons-cell)
     (lambda ()
       (add-content output
	 (content (car (content cons-cell)))))))

 (define (carer cons-cell output)
   (propagator (list cons-cell)
     (lambda ()
       (identity (car (content cons-cell)) output))))

 (define (identity input output)
   (propagator (list input)
     (lambda ()
       (add-content output (content input)))))

 (define (carer cons-cell output)
   (propagator (list cons-cell)
     (lambda ()
       (let* ((best-pair (tms-query (content cons-cell)))
	      (transported-cell (car (v&s-value best-pair))))
	 ((conditional-identity (v&s-support best-pair))
	  transported-cell output)))))

 (define ((conditional-identity support) input output)
   (propagator (list input)
     (lambda ()
       (if (all-premises-in? support)
	   (add-content output
	     (attach-support (tms-query (content input)) support))))))

 (define (attach-support v&s more-support)
   (supported
    (v&s-value v&s)
    (lset-union eq? (v&s-support v&s) more-support)))
|#
