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

(define (compoundify-propagator-constructor prop-ctor)
  (lambda args
    (compound-propagator
     args ;; TODO Can I autodetect "inputs" that should not trigger construction?
     (apply eq-label!
      (lambda ()
	(apply prop-ctor args))
      (compute-aggregate-metadata prop-ctor args)))))

(define *interesting-cells* #f)

(define (compute-aggregate-metadata prop-ctor arg-cells)
  ;; This check is here to keep recursive compounds from computing
  ;; their internal metadata forever.  The reason this is ok is that
  ;; to learn the metadata of an unexpanded box, I only need to
  ;; observe what propagators want to attach to its interior boundary,
  ;; not to the entire interior.
  (if (or (not *interesting-cells*)
	  (not (null? (lset-intersection eq?
                        *interesting-cells* arg-cells))))
      (do-compute-aggregate-metadata prop-ctor arg-cells)
      '()))

(define (do-compute-aggregate-metadata prop-ctor arg-cells)
  ;; Assumes the prop-ctor is stateless!
  (with-independent-scheduler
   (lambda ()
     (let ((test-cell-map (map (lambda (arg)
				 (cons arg (make-cell)))
			       arg-cells)))
       (fluid-let ((*interesting-cells* (map cdr test-cell-map)))
	 (apply prop-ctor (map cdr test-cell-map)))
       (let* ((the-props (all-propagators))
	      (inputs (apply append (map (lambda (prop)
					   (or (eq-get prop 'inputs)
					       '()))
					 the-props)))
	      (outputs (apply append (map (lambda (prop)
					    (or (eq-get prop 'outputs)
						'()))
					  the-props)))
	      (my-inputs (map car
			      (filter (lambda (arg-test)
					(memq (cdr arg-test) inputs))
				      test-cell-map)))
	      (my-outputs (map car
			       (filter (lambda (arg-test)
					 (memq (cdr arg-test) outputs))
				       test-cell-map)))
	      (constructed-objects ;; Should only be one
	       (filter (lambda (x) (not (cell? x)))
		       (network-group-elements *current-network-group*))))
	 `(name ,(name (car constructed-objects))
	   inputs ,my-inputs outputs ,my-outputs))))))

(define (with-independent-scheduler thunk)
  ;; TODO This really belongs split across scheduler.scm,
  ;; metadata.scm, and search.scm in core.
  (fluid-let ((*alerted-propagators* #f)
	      (*alerted-propagator-list* #f)
	      (*abort-process* #f)
	      (*last-value-of-run* #f)
	      (*propagators-ever-alerted* #f)
	      (*propagators-ever-alerted-list* #f)
	      (*current-network-group* #f)
	      (*number-of-calls-to-fail* #f))
    (initialize-scheduler)
    (thunk)))

(define-macro-propagator (m-heron-step x g h)
  (let-cells (x/g g+x/g two)
    (divider x g x/g)
    (adder g x/g g+x/g)
    ((constant 2) two)
    (divider g+x/g two h)))
(define heron-step (compoundify-propagator-constructor m-heron-step))

(define-macro-propagator (m-sqrt-iter x g answer)
  (let-cells (done x-if-done x-if-not-done g-if-done g-if-not-done
		   new-g recursive-answer)
    (good-enuf? x g done)
    (conditional-writer done x x-if-done x-if-not-done)
    (conditional-writer done g g-if-done g-if-not-done)
    (heron-step x-if-not-done g-if-not-done new-g)
    (sqrt-iter x-if-not-done new-g recursive-answer)
    (conditional done g-if-done recursive-answer answer)))
(define sqrt-iter (compoundify-propagator-constructor m-sqrt-iter))

(define-macro-propagator (m-sqrt-network x answer)
  (let-cell one
    ((constant 1.0) one)
    (sqrt-iter x one answer)))
(define sqrt-network (compoundify-propagator-constructor m-sqrt-network))

(define-macro-propagator (m-good-enuf? x g done)
  (let-cells (g^2 eps x-g^2 ax-g^2)
    ((constant .00000001) eps)
    (multiplier g g g^2)
    (subtractor x g^2 x-g^2)
    (absolute-value x-g^2 ax-g^2)
    (<? ax-g^2 eps done)))
(define good-enuf? (compoundify-propagator-constructor m-good-enuf?))


#|
 (initialize-scheduler)
 (define-cell x)
 (define-cell answer)

 (sqrt-network x answer)

 (add-content x 2)
 (run)
 (content answer)
 ;Value: 1.4142135623746899
|#
