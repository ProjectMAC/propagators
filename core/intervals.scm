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
 (interval
  (type vector) (named 'interval) (print-procedure #f) (safe-accessors #t))
 low high)

(define interval-equal? equal?)

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

(defhandler generic-* mul-interval interval? interval?)
(defhandler generic-/ div-interval interval? interval?)
(defhandler generic-square square-interval interval?)
(defhandler generic-sqrt sqrt-interval interval?)

(define (->interval x)
  (if (interval? x)
      x
      (make-interval x x)))

(defhandler generic-* (coercing ->interval mul-interval) number? interval?)
(defhandler generic-* (coercing ->interval mul-interval) interval? number?)
(defhandler generic-/ (coercing ->interval div-interval) number? interval?)
(defhandler generic-/ (coercing ->interval div-interval) interval? number?)

(defhandler merge
 (lambda (content increment)
   (let ((new-range (intersect-intervals content increment)))
     (cond ((interval-equal? new-range content) content)
           ((interval-equal? new-range increment) increment)
           ((empty-interval? new-range) the-contradiction)
           (else new-range))))
 interval? interval?)

(define (ensure-inside interval number)
  (if (<= (interval-low interval) number (interval-high interval))
      number
      the-contradiction))

(defhandler merge
 (lambda (content increment)
   (ensure-inside increment content))
 number? interval?)

(defhandler merge
 (lambda (content increment)
   (ensure-inside content increment))
 interval? number?)
