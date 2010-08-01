;;; ----------------------------------------------------------------------
;;; Copyright 2010 Alexey Radul and Gerald Jay Sussman
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

(define-structure
  (layered
   (constructor %make-layered)
   (print-procedure
    (simple-unparser-method
     'layered (lambda (layered)
		(if (not (nothing? (layered-base layered)))
		    (list (layered-alist layered)
			  (layered-base layered))
		    (layered-alist layered))))))
  alist
  (base nothing))

(define (make-layered alist #!optional base)
  (if (default-object? base)
      (set! base nothing))
  (%make-layered alist base))

(define (layered-lookup name layered)
  (merge (information-assq name (layered-alist layered))
	 (layered-base layered)))

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
  (really-functionalize (cp:layered-get name)))

(define (layered-binary-map layered1 layered2)
  (lambda (f)
    (let ((alist1 (layered-alist layered1))
	  (alist2 (layered-alist layered2)))
      (let ((keys (lset-union eq? (map car alist1) (map car alist2))))
	(make-layered
	 (map (lambda (key)
		(cons key (f (layered-lookup key layered1)
			     (layered-lookup key layered2))))
	      keys)
	 (f (layered-base layered1)
	    (layered-base layered2)))))))

(define (->layered thing)
  (cond ((layered? thing)
	 thing)
	(else (make-layered '() thing))))

(define (layer-coercable? thing)
  (or (v&s-able? thing)
      (and (tms? thing)
	   (or (null? (tms-values thing))
	       (v&s-able? (v&s-value (car (tms-values thing))))))))

(tag-coercion-metadata layered? ->layered layer-coercable?)

(define (layered-equal? thing1 thing2)
  (and (layered? thing1)
       (layered? thing2)
       (same-alist? (layered-alist thing1)
		    (layered-alist thing2))
       (equivalent? (layered-base thing1)
		    (layered-base thing2))))

(defhandler-coercing binary-map layered-binary-map ->layered)

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

(defhandler generic-flatten
  (lambda (layered)
    (make-layered
     (map (lambda (binding)
	    (cons (car binding)
		  (if (layered? (cdr binding))
		      (layered-lookup (car binding) (cdr binding))
		      (cdr binding))))
	  (layered-alist layered))))
  (lambda (thing)
    (and (layered? thing)
	 (any layered? (map cdr (layered-alist thing))))))

(defhandler-coercing merge (lambda (x y)
			     ((layered-binary-map x y) merge)) ->layered)
(defhandler-coercing equivalent? layered-equal? ->layered)

(defhandler contradictory?
  (lambda (layered)
    (any (lambda (pair)
	   (contradictory? (cdr pair)))
	 (layered-alist layered)))
  layered?)

(define-method generic-match ((pattern <vector>) (object rtd:layered))
  (generic-match
   pattern (list->vector
	    (cons 'layered
		  (if (not (nothing? (layered-base object)))
		      (list (layered-alist object)
			    (layered-base object))
		      (layered-alist object))))))

(define (in-layer name diagram)
  (lambda args
    (apply diagram
      (map (ce:layered-get name) args))))
