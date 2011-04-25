;;; ----------------------------------------------------------------------
;;; Copyright 2011 Alexey Radul and Gerald Jay Sussman
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

(define-structure (%diagram safe-accessors (constructor %make-%diagram))
  identity
  parts
  promises
  clubs) ; These are the diagrams that have me as a part

;; Cells are also diagrams, with trivial identity, no parts, and no
;; promises.

(define (diagram? thing)
  (or (%diagram? thing)
      (cell? thing)))

(define (diagram-identity thing)
  (if (%diagram? thing)
      (%diagram-identity thing)
      thing))

(define (diagram-parts thing)
  (if (%diagram? thing)
      (%diagram-parts thing)
      (eq-get thing 'parts '())))

(define (set-diagram-parts! thing new-parts)
  (if (%diagram? thing)
      (set-%diagram-parts! thing new-parts)
      (eq-put! thing 'parts new-parts)))

(define (diagram-promises thing)
  (if (%diagram? thing)
      (%diagram-promises thing)
      (eq-get thing 'promises '())))

(define (set-diagram-promises! thing new-promises)
  (if (%diagram? thing)
      (set-%diagram-promises! thing new-promises)
      (eq-put! thing 'promises new-promises)))

(define (diagram-clubs thing)
  (if (%diagram? thing)
      (%diagram-clubs thing)
      (eq-get thing 'clubs '())))

(define (set-diagram-clubs! thing new-clubs)
  (if (%diagram? thing)
      (set-%diagram-clubs! thing new-clubs)
      (eq-put! thing 'clubs new-clubs)))

(define (add-diagram-club! thing club)
  (diagram-set-clubs! thing (lset-adjoin eq? club (diagram-clubs thing))))

(define (make-%diagram identity parts promises)
  (let ((answer (%make-%diagram identity parts promises '())))
    ;; produces (eq-adjoin! output 'shadow-connections the-propagator)
    (for-each (lambda (part)
		(add-diagram-club! part answer))
	      (map cdr parts))
    answer))


(define (make-anonymous-i/o-diagram identity inputs outputs)
  (define (with-synthetic-names lst base)
    (map cons
	 (map symbol (make-list (length lst) base)
	      (iota (length lst)))
	 lst))
  (let* ((parts (append (with-synthetic-names inputs 'input)
			(with-synthetic-names outputs 'output)))
	 (boundary (append inputs outputs))
	 (un-read (lset-difference eq? boundary inputs))
	 (un-written (lset-difference eq? boundary outputs)))
    (make-%diagram
     identity
     parts
     (append (map promise-not-to-write un-written)
	     (map promise-not-to-read un-read)))))

;; In propagators.scm
(define (function->propagator-constructor f)
  (let ((n (name f)))
    (define (the-constructor . cells)
      (let ((output (ensure-cell (car (last-pair cells))))
	    (inputs (map ensure-cell (except-last-pair cells))))
	(define (the-propagator)
	  (fluid-let ((*active-propagator* the-propagator))
	    (add-content output
			 (apply f (map content inputs))
			 the-propagator)))
	(name! the-propagator (if (symbol? n)
				  (symbol n ':p)
				  f))
	(propagator inputs the-propagator)
	(make-anonymous-i/o-diagram propagator inputs (list output))))
    (if (symbol? n) (name! the-constructor (symbol 'p: n)))
    (propagator-constructor! the-constructor)))

;; Various inspectors should use the diagram-clubs facility instead of
;; the cell neighbors field, which, though somewhat redundant, is used
;; for the scheduler and for a different purpose.

;; Also, all analogues of function->propagator-constructor should be
;; adjusted, and a new one made for compound propagators.
