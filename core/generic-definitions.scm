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

;;; Base (generic) functions for standard propagators

(define generic-+   (make-generic-operator 2 '+   +))
(define generic--   (make-generic-operator 2 '-   -))
(define generic-*   (make-generic-operator 2 '*   *))
(define generic-/   (make-generic-operator 2 '/   /))
(define generic-abs (make-generic-operator 1 'abs abs))
(define generic-square (make-generic-operator 1 'square square))
(define generic-sqrt (make-generic-operator 1 'sqrt sqrt))
(define generic-=   (make-generic-operator 2 '=   =))
(define generic-<   (make-generic-operator 2 '<   <))
(define generic->   (make-generic-operator 2 '>   >))
(define generic-<=  (make-generic-operator 2 '<=  <=))
(define generic->=  (make-generic-operator 2 '>=  >=))
(define generic-not (make-generic-operator 1 'not not))
(define generic-and (make-generic-operator 2 'and boolean/and))
(define generic-or  (make-generic-operator 2 'or  boolean/or))
;; I want a name for the function that does the switch job
(define (switch-function control input)
  (if control input nothing))
(name! switch-function 'switch)
(name! identity 'identity)

;;; General generic-monadic machinery

(define (generic-bind thing function)
  (generic-flatten (generic-unpack thing function)))

(define generic-unpack 
  (make-generic-operator 2 'unpack
    (lambda (object function)
      (function object))))

(define generic-flatten
  (make-generic-operator 1 'flatten (lambda (object) object)))

(define (nary-unpacking function)
  (lambda args
    (let loop ((args args)
               (function function))
      (if (null? args)
          (function)
          (generic-bind
           (car args)
           (lambda (arg)
             (loop (cdr args)
                   (lambda remaining-args
                     (apply function (cons arg remaining-args))))))))))

;; This version also attaches the name information, for debugging and
;; drawing networks.
(define nary-unpacking
  (let ((nary-unpacking nary-unpacking))
    (lambda (function)
      (eq-label! (nary-unpacking function) 'name function))))

(defhandler generic-unpack
  (lambda (object function) nothing)
  nothing? any?)

;;; This handler is redundant but harmless
(defhandler generic-flatten
  (lambda (thing) nothing)
  nothing?)
