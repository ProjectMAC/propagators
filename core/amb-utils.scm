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

(define-macro-propagator (require cell)
  ((constant #t) cell))

(define-macro-propagator (forbid cell)
  ((constant #f) cell))

(define-propagator-syntax (require-distinct cells)
  (for-each-distinct-pair
   (lambda (c1 c2)
     (define-cell p)
     (=? c1 c2 p)
     (forbid p))
   cells))

(define-propagator-syntax (one-of values output-cell)
  (let ((cells
         (map (lambda (value)
                (define-cell cell)
		((constant value) cell)
		cell)
              values)))
    (one-of-the-cells cells output-cell)))

(define-propagator-syntax (one-of-the-cells input-cells output-cell)
  (cond ((= (length input-cells) 2)
         (let-cell p
           (conditional p
             (car input-cells) (cadr input-cells)
             output-cell)
           (binary-amb p)))
        ((> (length input-cells) 2)
         (let-cells (link p)
           (one-of-the-cells (cdr input-cells) link)
           (conditional
            p (car input-cells) link output-cell)
           (binary-amb p)))
        (else
         (error "Inadequate choices for one-of-the-cells"
                input-cells output-cell))))
