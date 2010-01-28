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

(process-examples)
(process-examples)

(define (sum a b total)
  (adder a b total)                     ; a + b -> total
  (subtractor total a b)                ; total - a -> b
  (subtractor total b a))               ; total - b -> a
(process-examples)

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

(define (heron-step x g h)
  (compound-propagator (list x g)       ; inputs
    (lambda ()                          ; how to build
      (let ((x/g (make-cell))
            (g+x/g (make-cell))
            (two (make-cell)))
        (divider x g x/g)
        (adder g x/g g+x/g)
        ((constant 2) two)
        (divider g+x/g two h)))))

(define (sqrt-iter x g answer)
  (compound-propagator (list x g)
    (lambda ()
      (let ((done (make-cell))
            (x-if-not-done (make-cell))
            (g-if-done (make-cell))
            (g-if-not-done (make-cell))
            (new-g (make-cell))
            (recursive-answer (make-cell)))
        (good-enuf? x g done)
        (conditional-writer done x (make-cell) x-if-not-done)
        (conditional-writer done g g-if-done g-if-not-done)
        (heron-step x-if-not-done g-if-not-done new-g)
        (sqrt-iter x-if-not-done new-g recursive-answer)
        (conditional done g-if-done recursive-answer answer)))))

(define (sqrt-network x answer)
  (compound-propagator x
    (lambda ()
      (let ((one (make-cell)))
        ((constant 1.0) one)
        (sqrt-iter x one answer)))))

(define (good-enuf? x g done)
  (compound-propagator (list x g)
    (lambda ()
      (let ((g^2 (make-cell))
            (eps (make-cell))
            (x-g^2 (make-cell))
            (ax-g^2 (make-cell)))
        ((constant .00000001) eps)
        (multiplier g g g^2)
        (subtractor x g^2 x-g^2)
        (absolute-value x-g^2 ax-g^2)
        (<? ax-g^2 eps done)))))


(process-examples)
(process-examples)

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
