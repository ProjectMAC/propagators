;;; ----------------------------------------------------------------------
;;; Copyright 2010 Alexey Radul.
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

(declare (usual-integrations))

(define-structure network-group
  elements)

(define *current-network-group* #f)

(define (network-group-named name)
  (eq-put! (make-network-group '()) 'name name))

(define (network-register thing)
  (if (memq thing (network-group-elements *current-network-group*))
      'ok
      (set-network-group-elements! *current-network-group*
       (cons thing (network-group-elements *current-network-group*))))
  (eq-put! thing 'network-group *current-network-group*))

(define (with-network-group group thunk)
  (network-register group)
  (fluid-let ((*current-network-group* group))
    (thunk)))

(define (clear-network-group thing)
  (eq-rem! thing 'shadow-connections 'inputs 'outputs 'network-group)
  (if (network-group? thing)
      (for-each clear-network-group (network-group-elements thing))))

(define (reset-network-groups!)
  (clear-network-group *current-network-group*)
  (set! *current-network-group* (network-group-named 'top-group)))

(define initialize-scheduler
  (let ((initialize-scheduler initialize-scheduler))
    (lambda ()
      (initialize-scheduler)
      (reset-network-groups!))))