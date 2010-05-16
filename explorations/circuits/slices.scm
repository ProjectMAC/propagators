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

(define-macro-propagator (terminal-equivalence ok? t1 t2)
  (conditional-wire ok? (ce:current t1) (ce:current t2))
  (conditional-wire ok? (ce:potential t1) (ce:potential t2)))

(define-macro-propagator (exact-voltage-divider-slice R1 node R2)
  ;; TODO Need to verify that (the t2 R1) and (the t1 R2) have a node
  ;; in common, and are the only terminals on that node
  (let-cells ((Requiv (resistor)))
    (c:+ (the resistance R1)
	 (the resistance R2)
	 (the resistance Requiv))
    (terminal-equivalence #t (the t1 R1) (the t1 Requiv))
    (terminal-equivalence #t (the t2 R2) (the t2 Requiv))))
