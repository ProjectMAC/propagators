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

;;; Propagator cells, in message-accepter style
(define (make-cell)
  (let ((neighbors '()) (content nothing))
    (define (add-content increment)
      (let ((new-content (merge content increment)))
        (cond ((eq? new-content content) 'ok)
              ((contradictory? new-content)
               (error "Ack! Inconsistency!"))
              (else (set! content new-content)
                    (alert-propagators neighbors)))))
    (define (new-neighbor! new-neighbor)
      (if (not (memq new-neighbor neighbors))
          (begin
            (set! neighbors (cons new-neighbor neighbors))
            (alert-propagators new-neighbor))))
    (define (me message)
      (cond ((eq? message 'content) content)
            ((eq? message 'add-content) add-content)
            ((eq? message 'neighbors) neighbors)
            ((eq? message 'new-neighbor!) new-neighbor!)
            (else (error "Unknown message" message))))
    (eq-put! me 'cell #t)
    me))

(define (content cell)
  (cell 'content))

(define (add-content cell increment)
  ((cell 'add-content) increment))

(define (neighbors cell)
  (cell 'neighbors))

(define (new-neighbor! cell neighbor)
  ((cell 'new-neighbor!) neighbor))

(define (cell? thing)
  (eq-get thing 'cell))

(define (make-named-cell name)
  (eq-put! (make-cell) 'name name))

;;; Convenience macros for defining new cells.

;; (define-cell foo) exands into
;; (define foo (make-named-cell 'foo))
(define-syntax define-cell
  (syntax-rules ()
    ((define-cell symbol)
     (define symbol (make-named-cell 'symbol)))))

;; (let-cells (foo bar baz)
;;   stuff)
;; expands into
;; (let ((foo (make-cell-named 'foo))
;;       (bar (make-cell-named 'bar))
;;       (baz (make-cell-named 'baz)))
;;   stuff)
(define-syntax let-cells
  (syntax-rules ()
    ((let-cells (cell-name ...)
       form ...)
     (let ((cell-name (make-named-cell 'cell-name))...)
       form ...))))

;; This version is a grammatical convenience if there is only one
;; cell.  The name either may or may not be enclosed in parens.
;; (let-cell (foo) stuff) and (let-cell foo stuff) are both ok and
;; equivalent to (let-cells (foo) stuff), which reads a bit more
;; awkwardly.
(define-syntax let-cell
  (syntax-rules ()
    ((let-cell (cell-name)
       form ...)
     (let-cells (cell-name)
       form ...))
    ((let-cell cell-name
       form ...)
     (let-cells (cell-name)
       form ...))))

;;; Propagators

(define (propagator neighbors to-do)
  (for-each (lambda (cell)
              (new-neighbor! cell to-do))
            (listify neighbors))
  (eq-put! to-do 'propagator #t)
  (alert-propagator to-do))

(define (propagator? thing)
  (or (eq-get thing 'propagator)
      ;; TODO Do I still need this fallback?
      (not (cell? thing))))

(define (function->propagator-constructor f)
  (lambda cells
    (let ((output (car (last-pair cells)))
          (inputs (except-last-pair cells)))
      (propagator inputs                ; The output isn't a neighbor!
        (lambda ()
          (add-content output
            (apply f (map content inputs))))))))

;;; This version has additional metadata to allow the propagator
;;; network to be effectively traversed (see extensions/prop-dot.scm)
(define (function->propagator-constructor f)
  (lambda cells
    (let ((output (car (last-pair cells)))
          (inputs (except-last-pair cells)))
      (let ((the-propagator
             (lambda ()
               (add-content output (apply f (map content inputs))))))
        (eq-adjoin! output 'shadow-connections the-propagator)
        (eq-label! the-propagator 'name f 'inputs inputs 'outputs (list output))
        (propagator inputs the-propagator)))))

(define (constant value)
  (function->propagator-constructor
   #; (lambda () value)
   (eq-label! (lambda () value) 'name `(const ,value))))

;;; Propagators that defer the construction of their bodies, as one
;;; mechanism of abstraction.
(define (compound-propagator neighbors to-build)
  (let ((done? #f) (neighbors (listify neighbors)))
    (define (test)
      (if done?
          'ok
          (if (every nothing? (map content neighbors))
              'ok
              (begin (set! done? #t)
                     (to-build)))))
    (propagator neighbors test)))

;;; Merging, and the basic data types.

(define merge
  (make-generic-operator 2 'merge
   (lambda (content increment)
     (if (default-equal? content increment)
         content
         the-contradiction))))

(define nothing #(*the-nothing*))

(define (nothing? thing)
  (eq? thing nothing))

(define the-contradiction #(*the-contradiction*))

(define contradictory?
  (make-generic-operator 1 'contradictory?
   (lambda (thing) (eq? thing the-contradiction))))

(defhandler merge
 (lambda (content increment) content)
 any? nothing?)

(defhandler merge
 (lambda (content increment) increment)
 nothing? any?)
