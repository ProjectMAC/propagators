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

(define-structure
  (%interval (safe-accessors #t)
	     (print-procedure
	      (simple-unparser-method
	       'interval
	       (lambda (interval)
		 (list (interval-low interval)
		       (interval-high interval))))))
  low high)
(declare-type-tester %interval? rtd:%interval)

(declare-coercion-target %interval)

(declare-coercion <number> ->%interval (lambda (x) (make-%interval x x)))

;;; TODO Make %interval-> generic?
(define (%interval-> int)
  (if (= (interval-low int) (interval-high int))
      (interval-low int)
      int))

(define (interval? x)
  (or (%interval? x)
      (%interval-able? x)))

(define (interval-low thing)
  (%interval-low (->%interval thing)))

(define (interval-high thing)
  (%interval-high (->%interval thing)))

(define (make-interval low high)
  (%interval-> (make-%interval low high)))

(define-method generic-match ((pattern <vector>) (object rtd:%interval))
  (generic-match
   pattern
   (vector 'interval (interval-low object) (interval-high object))))

(define (interval-equal? int1 int2)
  (and (= (interval-low int1) (interval-low int2))
       (= (interval-high int1) (interval-high int2))))

(define (mul-interval x y)
  (make-interval (* (interval-low x) (interval-low y))
                 (* (interval-high x) (interval-high y))))

(define (div-interval x y)
  (mul-interval x (make-interval (/ 1.0 (interval-high y))
                                 (/ 1.0 (interval-low y)))))

(define (square-interval x)
  (make-interval (square (interval-low x))
                 (square (interval-high x))))

(define (sqrt-interval x)
  (make-interval (sqrt (interval-low x))
                 (sqrt (interval-high x))))

(define (empty-interval? x)
  (> (interval-low x) (interval-high x)))

(define (intersect-intervals x y)
  (make-interval
   (max (interval-low x) (interval-low y))
   (min (interval-high x) (interval-high y))))

(define merge-intervals
  (eq?-standardizing intersect-intervals interval-equal?))

(defhandler generic-* mul-interval %interval? %interval?)
(defhandler generic-* mul-interval %interval? %interval-able?)
(defhandler generic-* mul-interval %interval-able? %interval?)
(defhandler generic-/ div-interval %interval? %interval?)
(defhandler generic-/ div-interval %interval? %interval-able?)
(defhandler generic-/ div-interval %interval-able? %interval?)
(defhandler generic-square square-interval %interval?)
(defhandler generic-sqrt sqrt-interval %interval?)

(defhandler merge merge-intervals %interval? %interval?)
(defhandler merge merge-intervals %interval? %interval-able?)
(defhandler merge merge-intervals %interval-able? %interval?)

(defhandler contradictory? empty-interval? %interval?)

