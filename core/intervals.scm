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

(declare (usual-integrations make-cell))


(defhandler generic-* mul-interval interval? interval?)
(defhandler generic-/ div-interval interval? interval?)
(defhandler generic-square square-interval interval?)
(defhandler generic-sqrt sqrt-interval interval?)

(define (->interval x)
  (if (interval? x)
      x
      (make-interval x x)))

(define (coercing coercer f)
  (lambda args
    (apply f (map coercer args))))

(defhandler generic-* (coercing ->interval mul-interval) number? interval?)
(defhandler generic-* (coercing ->interval mul-interval) interval? number?)
(defhandler generic-/ (coercing ->interval div-interval) number? interval?)
(defhandler generic-/ (coercing ->interval div-interval) interval? number?)
