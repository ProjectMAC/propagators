;;; ----------------------------------------------------------------------
;;; Copyright 2010 Alexey Radul and Gerald Jay Sussman
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

(define-structure
  (layered
   (print-procedure
    (simple-unparser-method
     'layered (lambda (layered)
		(layered-alist layered)))))
  alist)

(define (layered-lookup name layered)
  (information-assq name (layered-alist layered)))

(define (layered-get name)
  (name!
   (lambda (ed)
     (layered-lookup name ed))
   `(layered-get ,name)))

(define (make-layered-from . names)
  (name!
   (lambda items
     (make-layered (map cons names items)))
   `(make-layered-from ,@names)))

;;; TODO Oh, what macrology this is!  I could have a cell hold the
;;; name of the layer instead...
(define (cp:layered-get name)
  (lambda (cell target)
    ((function->unpacking->propagator-constructor
      (layered-get name))
     cell target)
    ((function->propagator-constructor
      (make-layered-from name))
     target cell)))

(define (ce:layered-get name)
  (functionalize (cp:layered-get name)))

(define (binary-layered-unpacking f)
  (let ((alist-f (binary-alist-unpacking f)))
    (lambda (layered1 layered2)
      (make-layered (alist-f (layered-alist layered1)
			     (layered-alist layered2))))))

(define (layered-coercing f)
  (lambda (layered thing)
    (f layered
       (make-layered
	(map (lambda (name)
	       (cons name thing))
	     (map car (layered-alist layered)))))))

(define (flipping f)
  (lambda (a b)
    (f b a)))

(define (layer-coercable? thing)
  (or (flat? thing)
      (and (tms? thing)
	   (or (null? (tms-values thing))
	       (flat? (v&s-value (car (tms-values thing))))))))

(define (attach-layer-method operation method)
  (defhandler operation
    method layered? layered?)
  (defhandler operation
    (layered-coercing method)
    layered? layer-coercable?)
  (defhandler operation
    (flipping (layered-coercing (flipping method)))
    layer-coercable? layered?))

(define (layered-equal? thing1 thing2)
  (and (layered? thing1)
       (layered? thing2)
       (same-alist? (layered-alist thing1)
		    (layered-alist thing2))))

(defhandler generic-flatten
  (lambda (tms)
    (reduce merge nothing
	    (map (lambda (v&s)
		   (make-layered
		    ((unary-alist-unpacking
		      (lambda (layer-value)
			(generic-flatten
			 (make-tms (supported layer-value
					      (v&s-support v&s))))))
		     (layered-alist (v&s-value v&s)))))
		 (tms-values tms))))
  (lambda (thing)
    (and (tms? thing)
	 (not (null? (tms-values thing)))
	 (v&s? (car (tms-values thing)))
	 (layered? (v&s-value (car (tms-values thing)))))))


(for-each
 (lambda (operation)
   (attach-layer-method operation
     (binary-layered-unpacking (nary-unpacking operation))))
 (list generic-+ generic-- generic-* generic-/))

(attach-layer-method merge
  (with-equality (binary-layered-unpacking merge) layered-equal?))

(defhandler contradictory?
  (lambda (layered)
    (any (lambda (pair)
	   (contradictory? (cdr pair)))
	 (layered-alist layered)))
  layered?)

(define-method generic-match ((pattern <vector>) (object rtd:layered))
  (generic-match
   pattern (list->vector (cons 'layered (layered-alist object)))))

(define (in-layer name diagram)
  (lambda args
    (apply diagram
      (map (ce:layered-get name) args))))
