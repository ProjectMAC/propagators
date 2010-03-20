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
  elements
  names)

(define *current-network-group* #f)

(define (network-group-named name)
  (name! (make-network-group '() (make-eq-hash-table)) name))

(define (name-in-group! group thing name)
  (hash-table/put! (network-group-names group) thing name)
  thing)

(define (name-in-group group thing)
  (and group
       (hash-table/get (network-group-names group) thing #f)))

(define (network-register thing)
  (if (memq thing (network-group-elements *current-network-group*))
      'ok
      (set-network-group-elements! *current-network-group*
       (cons thing (network-group-elements *current-network-group*))))
  (eq-put! thing 'network-group *current-network-group*))

(define (network-unregister thing)
  (let ((group (network-group-of thing)))
    (if group
	(set-network-group-elements! group
	 (delq thing (network-group-elements group)))))
  (eq-rem! thing 'network-group))

(define (network-group-of thing)
  (eq-get thing 'network-group))

(define (in-network-group group thunk)
  (if group
      (fluid-let ((*current-network-group* group))
	(thunk))
      (thunk) ;; TODO What should I really do if there is no group?
      ))

(define (with-network-group group thunk)
  (network-register group)
  (in-network-group group thunk))

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

(define (propagator-inputs propagator)
  (or (eq-get propagator 'inputs)
      (eq-get propagator 'neighbors)
      '()))

(define (propagator-outputs propagator)
  (or (eq-get propagator 'outputs)
      (eq-get propagator 'neighbors)
      '()))

(define (name-locally! thing name)
  (name-in-group! *current-network-group* thing name))

(define name
  (let ((name name))
    (lambda (thing)
      (let ((group-name (name-in-group (network-group-of thing) thing)))
	(if group-name
	    (name group-name)
	    (name thing))))))

(define (cell-connections cell)
  ;; The neighbors are the ones that need to be woken up; the
  ;; connections are the ones that touch the cell at all.  This
  ;; concept is useful for walking the graph structure of the network.
  (append (neighbors cell)
	  (or (eq-get cell 'shadow-connections)
	      '())))
