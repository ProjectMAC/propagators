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


(defhandler generic-unpack
  (lambda (tms function)
    (let ((relevant-information (tms-query tms)))
      (make-tms (list (generic-bind relevant-information function)))))
  tms? any?)

(defhandler generic-flatten
  (lambda (tms)
    (let ((candidates
           (append-map tms-values
                       (map ->tms
                            (map generic-flatten (tms-values tms))))))
      (if (null? candidates)
          nothing
          (make-tms candidates))))
  tms?)

(defhandler generic-flatten
  (lambda (v&s)
    (generic-flatten
     (make-tms
      (generic-flatten
       (supported (tms-query (v&s-value v&s)) (v&s-support v&s))))))
  (lambda (thing) (and (v&s? thing) (tms? (v&s-value thing)))))

(define (->tms thing)
  (cond ((tms? thing) thing)
        ((nothing? thing) (make-tms '()))
        (else (make-tms (list (->v&s thing))))))

(define (the-tms-handler thing1 thing2)
  (tms-merge thing1 thing2))

(defhandler merge the-tms-handler tms? tms?)
(defhandler merge (coercing ->tms the-tms-handler) tms? v&s?)
(defhandler merge (coercing ->tms the-tms-handler) v&s? tms?)
(defhandler merge (coercing ->tms the-tms-handler) tms? flat?)
(defhandler merge (coercing ->tms the-tms-handler) flat? tms?)
