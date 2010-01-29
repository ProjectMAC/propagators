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

(define (fahrenheit->celsius f c)
  (let ((thirty-two (make-cell))
        (f-32 (make-cell))
        (five (make-cell))
        (c*9 (make-cell))
        (nine (make-cell)))
    ((constant 32) thirty-two)
    ((constant 5) five)
    ((constant 9) nine)
    (subtractor f thirty-two f-32)
    (multiplier f-32 five c*9)
    (divider c*9 nine c)))

(define nothing #(*the-nothing*))

(define (nothing? thing)
  (eq? thing nothing))

(define (content cell)
  (cell 'content))

(define (add-content cell increment)
  ((cell 'add-content) increment))

(define (new-neighbor! cell neighbor)
  ((cell 'new-neighbor!) neighbor))

(define (propagator neighbors to-do)
  (for-each (lambda (cell)
              (new-neighbor! cell to-do))
            (listify neighbors))
  (alert-propagator to-do))

(define (function->propagator-constructor f)
  (lambda cells
    (let ((output (car (last-pair cells)))
          (inputs (except-last-pair cells)))
      (propagator inputs                ; The output isn't a neighbor!\footnote{Because the function's activities do not depend upon changes in the content of the output cell.
        (lambda ()
          (add-content output
            (apply f (map content inputs))))))))
;;; Add the metadata
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
    (eq-label! (lambda () value) 'name `(const ,value)) #;
    (lambda () value)))

(define (sum x y total)
  (adder x y total)
  (subtractor total x y)
  (subtractor total y x))

(define (product x y total)
  (multiplier x y total)
  (divider total x y)
  (divider total y x))

(define (quadratic x x^2)
  (squarer x x^2)
  (sqrter x^2 x))

;;; ...

(define (fahrenheit-celsius f c)
  (let ((thirty-two (make-cell))
        (f-32 (make-cell))
        (five (make-cell))
        (c*9 (make-cell))
        (nine (make-cell)))
    ((constant 32) thirty-two)
    ((constant 5) five)
    ((constant 9) nine)
    (sum thirty-two f-32 f)
    (product f-32 five c*9)
    (product c nine c*9)))

(define (fall-duration t h)
  (let ((g (make-cell))
        (one-half (make-cell))
        (t^2 (make-cell))
        (gt^2 (make-cell)))
    ((constant (make-interval 9.789 9.832)) g)
    ((constant (make-interval 1/2 1/2)) one-half)
    (quadratic t t^2)
    (product g t^2 gt^2)
    (product one-half gt^2 h)))

(define (similar-triangles s-ba h-ba s h)
  (let ((ratio (make-cell)))
    (product s-ba ratio h-ba)
    (product s ratio h)))

(define (mul-interval x y)
  (make-interval (* (interval-low x) (interval-low y))
                 (* (interval-high x) (interval-high y))))

(define (div-interval x y)
  (mul-interval x (make-interval (/ 1.0 (interval-high y))
                                 (/ 1.0 (interval-low y)))))

(define (square-interval x)
  (make-interval (square (interval-low x))
                 (square (interval-high x))))

(define (sqrt-interval x)
  (make-interval (sqrt (interval-low x))
                 (sqrt (interval-high x))))

(define (empty-interval? x)
  (> (interval-low x) (interval-high x)))

(define (intersect-intervals x y)
  (make-interval
   (max (interval-low x) (interval-low y))
   (min (interval-high x) (interval-high y))))

(define (make-cell)
  (let ((neighbors '()) (content nothing))
    (define (add-content increment)     ; ***
      (let ((new-content (merge content increment)))
        (cond ((eq? new-content content) 'ok)
              ((contradictory? new-content)
               (error "Ack! Inconsistency!"))
              (else (set! content new-content)
                    (alert-propagators neighbors)))))
    ;; ... new-neighbor! and me are still the same
    (define (new-neighbor! new-neighbor)
      (if (not (memq new-neighbor neighbors))
          (begin
            (set! neighbors (cons new-neighbor neighbors))
            (alert-propagators new-neighbor))))
    (define (me message)
      (cond ((eq? message 'new-neighbor!) new-neighbor!)
            ((eq? message 'add-content) add-content)
            ((eq? message 'content) content)
            ((eq? message 'neighbors) neighbors)
            (else (error "Unknown message" message))))
    (eq-put! me 'cell #t)
    me
  ))

(define (neighbors cell) (cell 'neighbors))
(define (cell? thing) (eq-get thing 'cell))

(define-syntax define-cell
  (syntax-rules ()
    ((define-cell symbol)
     (define symbol (make-named-cell 'symbol)))))

(define (make-named-cell name)
  (eq-put! (make-cell) 'name name))

(define-syntax let-cells
  (syntax-rules ()
    ((let-cell (cell-name ...) form ...)
     (let ((cell-name (make-named-cell 'cell-name))...)
       form ...))))

(define (propagator? thing)
  (or (eq-get thing 'propagator?)
      (not (cell? thing))))

(define merge
  (make-generic-operator 2 'merge
   (lambda (content increment)
     (if (default-equal? content increment)
         content
         the-contradiction))))

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

(defhandler merge
 (lambda (content increment)
   (let ((new-range (intersect-intervals content increment)))
     (cond ((interval-equal? new-range content) content)
           ((interval-equal? new-range increment) increment)
           ((empty-interval? new-range) the-contradiction)
           (else new-range))))
 interval? interval?)

(define (ensure-inside interval number)
  (if (<= (interval-low interval) number (interval-high interval))
      number
      the-contradiction))

(defhandler merge
 (lambda (content increment)
   (ensure-inside increment content))
 number? interval?)

(defhandler merge
 (lambda (content increment)
   (ensure-inside content increment))
 interval? number?)

(load-compiled "generic-definitions")
(load-compiled "intervals")
