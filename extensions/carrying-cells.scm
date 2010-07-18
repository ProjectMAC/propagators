;;; ----------------------------------------------------------------------
;;; Copyright 2010 Alexey Radul and Gerald Jay Sussman
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

(declare (usual-integrations make-cell cell?))

;;;; Propagators implementing the carrying cells strategy

;;; The specific version
#;
(define-macro-propagator (p:carry-cons a-cell d-cell output)
  ((constant (cons a-cell d-cell))
   output))

;;; The general version
(define (function->cell-carrier-constructor f)
  (lambda cells
    (let ((output (ensure-cell (car (last-pair cells))))
          (inputs (map ensure-cell (except-last-pair cells))))
      (execute-propagator ; To enable the early-access-hack below
       ((constant (apply f inputs))
	output)))))
(define p:carry-cons (function->cell-carrier-constructor cons))
(define e:carry-cons (functionalize p:carry-cons))

(define-macro-propagator (p:carry-car pair-cell output)
  (p:carry-cons output nothing pair-cell))
(define %e:carry-car (functionalize p:carry-car))
#;
(define (e:carry-car pair-cell)
  (if (and (cell? pair-cell)
	   (pair? (content pair-cell))
	   (cell? (car (content pair-cell))))
      (car (content pair-cell))
      (%e:carry-car pair-cell)))

(define (early-access-hack type? accessor fallback)
  (lambda (structure-cell)
    (if (and (cell? structure-cell)
	     (type? (content structure-cell))
	     (cell? (accessor (content structure-cell))))
	(accessor (content structure-cell))
	(fallback structure-cell))))
(define e:carry-car (early-access-hack pair? car %e:carry-car))

(define-macro-propagator (p:carry-cdr pair-cell output)
  (p:carry-cons nothing output pair-cell))
(define %e:carry-cdr (functionalize p:carry-cdr))
(define e:carry-cdr (early-access-hack pair? cdr %e:carry-cdr))
