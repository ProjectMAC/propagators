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

;;; Propagators

(define (propagator neighbors to-do)
  (for-each (lambda (cell)
              (new-neighbor! cell to-do))
            (listify neighbors))
  (eq-put! to-do 'propagator #t)
  (network-register to-do)
  (alert-propagator to-do)
  to-do)

(define (propagator? thing)
  (eq-get thing 'propagator))

(define (propagator-constructor? thing)
  (or (eq-get thing 'propagator-constructor)
      ;; TODO This is such a hack!  I probably should not represent
      ;; propagator constructors quite this directly as Scheme
      ;; procedures...
      (and (not (eq-get thing 'not-propagator-constructor))
	   (procedure? thing)
	   (not (cell? thing))
	   (not (propagator? thing))
	   (warn "Imputing propagator-constructor-hood" thing)
	   #t)))

(define (propagator-constructor! thing)
  (eq-put! thing 'propagator-constructor #t)
  thing)

(define (function->propagator-constructor f)
  (lambda cells
    (let ((output (ensure-cell (car (last-pair cells))))
          (inputs (map ensure-cell (except-last-pair cells))))
      (propagator inputs                ; The output isn't a neighbor!
        (lambda ()
          (add-content output
            (apply f (map content inputs))))))))

;;; This version has additional metadata to allow the propagator
;;; network to be effectively traversed (see extensions/draw.scm)
(define (function->propagator-constructor f)
  (propagator-constructor!
   (lambda cells
     (let ((output (ensure-cell (car (last-pair cells))))
	   (inputs (map ensure-cell (except-last-pair cells))))
       (let ((the-propagator
	      (lambda ()
		(add-content output (apply f (map content inputs))))))
	 (eq-adjoin! output 'shadow-connections the-propagator)
	 (eq-label! the-propagator 'name f 'inputs inputs 'outputs (list output))
	 (propagator inputs the-propagator))))))

;;; Propagators that defer the construction of their bodies, as one
;;; mechanism of abstraction.
(define (one-shot-propagator neighbors action)
  (let ((done? #f) (neighbors (map ensure-cell (listify neighbors))))
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
			(action)))))))
    (eq-clone! action test)
    (propagator neighbors test)))

(define (delayed-propagator-constructor prop-ctor)
  (propagator-constructor!
   (lambda args
     ;; TODO Can I autodetect "inputs" that should not trigger
     ;; construction?
     (let ((args (map ensure-cell args)))
       (one-shot-propagator args
	(apply eq-label!
	       (lambda ()
		 (apply prop-ctor args))
	       (compute-aggregate-metadata prop-ctor args)))))))
