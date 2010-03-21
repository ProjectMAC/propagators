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
               (error "Ack! Inconsistency!" me increment))
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
    (network-register me)
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
  (name! (make-cell) name))

;;; Convenience macros for defining new cells.

;; (define-cell foo form)
;; is the same as
;; (define foo form)
;; except it grabs the name foo and associates it with the
;; object (presumably a cell) that form constructs.
;;
;; for the frequent case when you want a fresh cell
;; (define-cell foo)
;; expands into
;; (define-cell foo (make-named-cell 'foo))
;; The metadata is then available two ways.
(define-syntax define-cell
  (syntax-rules ()
    ((define-cell symbol form)
     (define symbol (name-locally! form 'symbol)))
    ((define-cell symbol)
     (define-cell symbol (make-named-cell 'symbol)))))

;; (let-cells ((foo foo-form)
;;             (bar bar-form)
;;             (baz baz-form))
;;   stuff)
;; is the same as 
;; (let ((foo foo-form)
;;       (bar bar-form)
;;       (baz baz-form))
;;   stuff)
;; except that it captures the names foo bar and baz
;; and associates them with the objects (presumably cells)
;; that the corresponding forms return.
;;
;; for the frequent case when you want fresh cells
;; (let-cells (foo bar baz)
;;   stuff)
;; expands into
;; (let-cells ((foo (make-named-cell 'foo))
;;             (bar (make-named-cell 'bar))
;;             (baz (make-named-cell 'baz)))
;;   stuff)
;; The metadata is then available two ways.
;;
;; The following would suffice for the above.
#;
(define-syntax let-cells
  (syntax-rules ()
    ((let-cells ((cell-name cell-form) ...)
       form ...)
     (let ((cell-name (name-locally! cell-form 'cell-name)) ...)
       form ...))
    ((let-cells (cell-name ...)
       form ...)
     (let-cells ((cell-name (make-named-cell 'cell-name))...)
       form ...))))

;; The much more horrible macro below allows the two use patterns
;; above to mix, as follows,
;; (let-cells ((foo foo-form)
;;             bar
;;             (baz baz-form))
;;   stuff)
;; and have the right thing happen.
(define-syntax let-cells
  (syntax-rules ()
    ((let-cells (cell-binding ...)
       form ...)
     (let-cells "process-clauses"
       (cell-binding ...)
       ()
       form ...))
    ((let-cells "process-clauses"
       ()
       ((cell-name cell-form) ...)
       form ...)
     (let ((cell-name (name-locally! cell-form 'cell-name)) ...)
       form ...))
    ((let-cells "process-clauses"
       ((cell-name cell-form) clause ...)
       (done-clause ...)
       form ...)
     (let-cells "process-clauses"
       (clause ...)
       ((cell-name cell-form) done-clause ...)
       form ...))
    ((let-cells "process-clauses"
       (cell-name clause ...)
       (done-clause ...)
       form ...)
     (let-cells "process-clauses"
       (clause ...)
       ((cell-name (make-named-cell 'cell-name)) done-clause ...)
       form ...))))

;; This version is a grammatical convenience if there is only one
;; cell.  (let-cell (foo foo-form) stuff) and (let-cell foo stuff) are
;; both ok and equivalent to (let-cells ((foo foo-form)) stuff) and
;; (let-cells (foo) stuff), respectively, which are more awkward to
;; read.
(define-syntax let-cell
  (syntax-rules ()
    ((let-cell cell-binding
       form ...)
     (let-cells (cell-binding)
       form ...))))

;;; Propagators

(define (propagator neighbors to-do)
  (for-each (lambda (cell)
              (new-neighbor! cell to-do))
            (listify neighbors))
  (eq-put! to-do 'propagator #t)
  (network-register to-do)
  (alert-propagator to-do))

(define (propagator? thing)
  (eq-get thing 'propagator))

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
   (eq-label! (lambda () value) 'name `(constant ,value))))

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
		     (in-network-group (network-group-of test)
		      (lambda ()
			;; The act of expansion makes the compound
			;; itself uninteresting
			(network-unregister test)
			(with-network-group (network-group-named (name to-build))
			 to-build)))))))
    (eq-clone! to-build test)
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
