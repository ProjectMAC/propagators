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

(declare (usual-integrations make-cell cell?))

(define-syntax propagatify-direct
  (sc-macro-transformer
   (lambda (form use-env)
     (let* ((propagatee-name (cadr form))
	    (propagator-name (symbol 'p: propagatee-name))
	    (expression-oriented-name (symbol 'e: propagatee-name)))
       `(begin
	  (define ,propagator-name
	    (function->propagator-constructor
	     (name! ,(close-syntax propagatee-name use-env) ',propagatee-name)))
	  (define ,expression-oriented-name
	    (functionalize ,propagator-name)))))))

(define-structure
  (terminal
   (safe-accessors #t)
   (print-procedure
    (simple-unparser-method
     'terminal (lambda (terminal)
		 (list (terminal-potential terminal)
		       (terminal-current terminal)))))
   (constructor make-terminal)
   (constructor make-terminal-from-potential (potential))
   (constructor make-terminal-from-current (current)))
  (potential nothing)
  (current nothing))

(slotful-information-type
 terminal? make-terminal terminal-potential terminal-current)

(propagatify terminal-potential)
(propagatify terminal-current)

(propagatify-direct make-terminal)
(propagatify-direct make-terminal-from-potential)
(propagatify-direct make-terminal-from-current)

(define (c:potential terminal potential)
  (p:terminal-potential terminal potential)
  (p:make-terminal-from-potential potential terminal))

(define ce:potential (functionalize c:potential))

(define (c:current terminal current)
  (p:terminal-current terminal current)
  (p:make-terminal-from-current current terminal))

(define ce:current (functionalize c:current))

(define-structure
  (element-descriptor
   (safe-accessors #t)
   (print-procedure
    (simple-unparser-method
     'e-d (lambda (ed)
	    (element-descriptor-alist ed)))))
  alist)

(define (make-element-descriptor-from . names)
  (name!
   (lambda items
     (make-element-descriptor (map cons names items)))
   `(make-element-descriptor-from ,@names)))

(define (element-descriptor-lookup name desc)
  (information-assq name (element-descriptor-alist desc)))

(define (element-descriptor-get name)
  (name!
   (lambda (ed)
     (element-descriptor-lookup name ed))
   `(element-descriptor-get ,name)))

(define (append-element-descriptor ed1 ed2)
  (make-element-descriptor
   (append (element-descriptor-alist ed1)
	   (element-descriptor-alist ed2))))
(propagatify append-element-descriptor)

(define (filter-element-descriptor names)
  (name!
   (lambda (desc)
     (make-element-descriptor
      (filter (lambda (pair)
		(memq (car pair) names))
	      (element-descriptor-alist desc))))
   `(filter-for ,@names)))

(define (filter-out-element-descriptor names)
  (name!
   (lambda (desc)
     (make-element-descriptor
      (filter (lambda (pair)
		(not (memq (car pair) names)))
	      (element-descriptor-alist desc))))
   `(filter-out ,@names)))

(define (merge-element-descriptors ed1 ed2)
  (effectful-bind (merge-alist (element-descriptor-alist ed1)
			       (element-descriptor-alist ed2))
    make-element-descriptor))

(define (element-descriptor-equal? ed1 ed2)
  (and (element-descriptor? ed1)
       (element-descriptor? ed2)
       (same-alist? (element-descriptor-alist ed1)
		    (element-descriptor-alist ed2))))

(defhandler merge
  (eq?-standardizing merge-element-descriptors element-descriptor-equal?)
  element-descriptor? element-descriptor?)

(define (function->unpacking->propagator-constructor f)
  (function->propagator-constructor
   (nary-unpacking f)))

(define-syntax e:inspectable-object
  (syntax-rules ()
    ((_ name ...)
     (e:inspectable-object-func (list 'name ...)
				(list name ...)))))

(define (e:inspectable-object-func names things)
  (let ((answer (make-named-cell 'cell)))
    (apply
     (function->cell-carrier-constructor #;function->propagator-constructor
      (apply make-element-descriptor-from names))
     (append things (list answer)))#;
    (for-each
     (lambda (name thing)
       ((function->unpacking->propagator-constructor
	 (element-descriptor-get name))
	answer thing))
     names things)
    answer))

(define-syntax ce:append-inspectable-object
  (syntax-rules ()
    ((_ sub-object name ...)
     (ce:append-inspectable-object-func
      (list 'name ...)
      sub-object
      (e:inspectable-object name ...)))))

(define (ce:append-inspectable-object-func names sub-object addition)
  (let ((answer (make-named-cell 'cell)))
    (p:append-element-descriptor sub-object addition answer)
    ((function->unpacking->propagator-constructor
      (filter-element-descriptor names))
     answer addition)
    ((function->unpacking->propagator-constructor
      (filter-out-element-descriptor names))
     answer sub-object)
    answer))

(define-syntax the
  (syntax-rules ()
    ((_ thing)
     thing)
    ((_ name form ...)
     (the-func 'name (the form ...)))))

(define (the-func name thing)
  (let ((answer (make-named-cell 'cell)))
    #;((function->unpacking->propagator-constructor
      (element-descriptor-get name))
     thing answer)
    ((function->cell-carrier-constructor #;function->propagator-constructor
      (make-element-descriptor-from name))
     answer thing)
    answer))
