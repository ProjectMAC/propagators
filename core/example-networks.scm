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

;;; Some propagator functions used in the test suite.

(define (fahrenheit->celsius f c)
  (let-cells (thirty-two f-32 five c*9 nine)
    ((constant 32) thirty-two)
    ((constant 5) five)
    ((constant 9) nine)
    (subtractor f thirty-two f-32)
    (multiplier f-32 five c*9)
    (divider c*9 nine c)))

(define (fahrenheit-celsius f c)
  (let-cells (thirty-two f-32 five c*9 nine)
    ((constant 32) thirty-two)
    ((constant 5) five)
    ((constant 9) nine)
    (sum-constraint thirty-two f-32 f)
    (product-constraint f-32 five c*9)
    (product-constraint c nine c*9)))

(define (celsius-kelvin c k)
  (let-cell many
    ((constant 273.15) many)
    (sum-constraint c many k)))

(define (fall-duration t h)
  (let-cells (g one-half t^2 gt^2)
    ((constant (make-interval 9.789 9.832)) g)
    ((constant (make-interval 1/2 1/2)) one-half)
    (quadratic-constraint t t^2)
    (product-constraint g t^2 gt^2)
    (product-constraint one-half gt^2 h)))

(define (similar-triangles s-ba h-ba s h)
  (let-cell ratio
    (product-constraint s-ba ratio h-ba)
    (product-constraint s ratio h)))
