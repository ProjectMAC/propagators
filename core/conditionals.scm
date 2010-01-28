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

(process-examples)

(define switch
  (function->propagator-constructor
   (lambda (control input)
     (if (nothing? control)
         nothing
         (if control input nothing)))))

(define switch
  (function->propagator-constructor
   (handling-nothings
    (lambda (control input)
      (if control input nothing)))))

(define switch
  (function->propagator-constructor
   (nary-unpacking
    (lambda (control input)
      (if control input nothing)))))
;;; But I want a name for the function that does the switch job
(define (switch-function control input)
  (if control input nothing))
(define switch
  (function->propagator-constructor
   (nary-unpacking switch-function)))

(interactive-example

(initialize-scheduler)
(define input (make-cell))
(define control (make-cell))
(define output (make-cell))
(switch control input output)

(add-content input 4)
(add-content control (supported #t '(fred)))
(run)
(content output)
=> #(supported 4 (fred))
)


(define (conditional control if-true if-false output)
  (let ((not-control (make-cell)))
    (inverter control not-control)
    (switch control if-true output)
    (switch not-control if-false output)))

;;; But, with annotations:
(define (conditional control if-true if-false output)
  (let-cells (not-control)
    (inverter control not-control)
    (switch control if-true output)
    (switch not-control if-false output)))

(define (conditional-writer control input if-true if-false)
  (let ((not-control (make-cell)))
    (inverter control not-control)
    (switch control input if-true)
    (switch not-control input if-false)))
