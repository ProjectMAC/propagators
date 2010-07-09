;;; ----------------------------------------------------------------------
;;; Copyright 2009-2010 Alexey Radul.
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

(define (add-interval x y)
  (make-interval (+ (interval-low x) (interval-low y))
		 (+ (interval-high x) (interval-high y))))
(defhandler-coercing generic-+ add-interval ->%interval)

(define interval-maker
  (function->propagator-constructor (binary-mapping make-interval)))

;; This assumes that the input is more than 1
(define (sqrt-network input-cell answer-cell)
  (let-cell one
    ((constant 1) one)
    (interval-maker one input-cell answer-cell)
    (heron-step input-cell answer-cell answer-cell)))

(define-cell x)
(add-content x 2)
(define-cell sqrt-x)
(sqrt-network x sqrt-x)
(run)
;; Oops: raw interval arithmetic loses here:
(content sqrt-x)
; Value: (interval 1. 2.)
