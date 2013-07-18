;;; ----------------------------------------------------------------------
;;; Copyright 2013 Massachusetts Institute of Technology.
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

;;;; Sets that preserve insertion order

(define-structure (insertion-order-set (conc-name oset-))
  table deque)

(define (make-eq-oset)
  (make-insertion-order-set (make-strong-eq-hash-table)
                            (deque:make)))

(define (oset-insert oset thing)
  (hash-table/lookup
   (oset-table oset)
   thing
   (lambda (value) 'ok)
   (lambda ()
     (hash-table/put! (oset-table oset) thing #t)
     (deque:add-to-front! (oset-deque oset) thing))))

(define (oset-peek oset)
  (if (= 0 (oset-count oset))
      (error "Peeking empty oset" oset))
  (deque:first (oset-deque oset)))

(define (oset-pop! oset)
  (let ((answer (oset-peek oset)))
    (hash-table/remove! (oset-table oset) answer)
    (deque:remove-first! (oset-deque oset))
    answer))


(define (oset-peek-tail oset)
  (if (= 0 (oset-count oset))
      (error "Peeking empty oset" oset))
  (deque:last (oset-deque oset)))

(define (oset-pop-tail! oset)
  (let ((answer (oset-peek-tail oset)))
    (hash-table/remove! (oset-table oset) answer)
    (deque:remove-last! (oset-deque oset))
    answer))


(define (oset-members oset)
  (deque:all (oset-deque oset)))

(define (oset-clear! oset)
  (hash-table/clear! (oset-table oset))
  (set-oset-deque! oset (deque:make)))

(define (oset-count oset)
  (hash-table/count (oset-table oset)))
