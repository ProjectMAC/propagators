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

(define (name thing)
  (let ((name-property (eq-get thing 'name)))
    (if name-property
	(name name-property)
	thing)))

(eq-put! generic-+ 'name '+)
(eq-put! generic-- 'name '-)
(eq-put! generic-* 'name '*)
(eq-put! generic-/ 'name '/)

(eq-put! generic-abs    'name 'abs)
(eq-put! generic-square 'name 'square)
(eq-put! generic-sqrt   'name 'sqrt)
(eq-put! generic-=      'name '=)
(eq-put! generic-<      'name '<)
(eq-put! generic->      'name '>)
(eq-put! generic-<=     'name '<=)
(eq-put! generic->=     'name '>=)

(eq-put! generic-not 'name 'not)
(eq-put! generic-and 'name 'and)
(eq-put! generic-or  'name 'or)

(eq-put! switch-function 'name 'switch)
(eq-put! identity 'name 'identity)

(define (neighbors element)
  (if (cell? element)
      (element 'neighbors)
      (let ((neighbors-property (eq-get element 'neighbors)))
	(if neighbors-property
	    neighbors-property
	    ;; Fail over
	    '()))))

