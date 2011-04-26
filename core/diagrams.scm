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

(define (clear-diagram-parts! thing)
  (set-diagram-parts! thing '()))

(define (diagram-promises thing)
  (if (%diagram? thing)
      (%diagram-promises thing)
      (eq-get thing 'promises '())))

(define (set-diagram-promises! thing new-promises)
  (if (%diagram? thing)
      (set-%diagram-promises! thing new-promises)
      (eq-put! thing 'promises new-promises)))

(define (clear-diagram-promises! thing)
  (set-diagram-promises! thing '()))

(define (diagram-clubs thing)
  (if (%diagram? thing)
      (%diagram-clubs thing)
      (eq-get thing 'clubs '())))

(define (set-diagram-clubs! thing new-clubs)
  (if (%diagram? thing)
      (set-%diagram-clubs! thing new-clubs)
      (eq-put! thing 'clubs new-clubs)))

(define (clear-diagram-clubs! thing)
  (set-diagram-clubs! thing '()))

(define (add-diagram-club! thing club)
  (diagram-set-clubs! thing (lset-adjoin eq? club (diagram-clubs thing))))

(define (make-%diagram identity parts promises)
  (let ((answer (%make-%diagram identity parts promises '())))
    ;; produces (eq-adjoin! output 'shadow-connections the-propagator)
    (for-each (lambda (part)
		(add-diagram-club! part answer))
	      (map cdr parts))
    answer))

(define (make-compound-diagram identity parts)
  (make-%diagram identity parts (compute-derived-promises parts)))

(define (compute-derived-promises parts)
  ;; TODO For every part that's a cell, I can promise not to read
  ;; (resp. write) it if every part either doesn't mention it or
  ;; promises not to read (resp. write) it.  See
  ;; DO-COMPUTE-AGGREGATE-METADATA.  I just have to take due care to
  ;; make sure that recursive parts are properly taken care of.
  '())

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

;;;; Implicit diagram production

(define (empty-diagram identity)
  (make-%diagram identity '() '()))

(define *current-diagram* (empty-diagram 'toplevel))

(define (add-diagram-named-part! diagram name part)
  (set-diagram-parts!
   diagram
   (lset-adjoin equal? (cons name part) (diagram-parts diagram)))
  (add-diagram-club! part diagram))

(define (note-diagram-part! diagram part)
  (if (memq part (map cdr (diagram-parts diagram)))
      'ok
      (begin
	(set-diagram-parts! diagram
	 (cons ((gensym) part) (diagram-parts diagram)))
	(add-diagram-club! part diagram))))

(define (network-register thing)
  (note-diagram-part! *current-diagram* thing))

(define (in-diagram diagram thunk)
  (if diagram
      (fluid-let ((*current-diagram* diagram))
	(thunk))
      (thunk))) ;; TODO What should I really do if there is no diagram?

(define (with-diagram diagram thunk)
  (network-register diagram)
  (in-diagram diagram thunk))

(define (name-in-current-diagram! name part)
  (add-diagram-named-part! *current-diagram* name part))

;; TODO network-unregister

;;; Getting rid of diagrams when they are no longer needed requires
;;; eliminating appropriate entries in the eq-properties table,
;;; because those values would otherwise point back to themselves.

(define (destroy-diagram! diagram)
  (clear-diagram-clubs! diagram)
  (clear-diagram-promises! diagram)
  (for-each destroy-diagram! (map cdr (diagram-parts diagram)))
  (clear-diagram-parts! diagram))

(define (reset-diagrams!)
  (destroy-diagram! *current-diagram*)
  (set! *current-diagram* (empty-diagram 'toplevel)))

;;; Restarting requires resetting the toplevel diagram
(define initialize-scheduler
  (let ((initialize-scheduler initialize-scheduler))
    (lambda ()
      (initialize-scheduler)
      (reset-diagrams!))))

(define with-independent-scheduler
  (let ((with-independent-scheduler with-independent-scheduler))
    (lambda args
      (fluid-let ((*current-diagram* #f))
	(apply with-independent-scheduler args)))))

;;;; New transmitters at the primitive-diagram level

;;; In propagators.scm
(define (function->propagator-constructor f)
  (let ((n (name f)))
    (define (the-constructor . cells)
      (let ((output (ensure-cell (last cells)))
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

(define (delayed-propagator-constructor prop-ctor)
  (eq-clone! prop-ctor
   (lambda args
     ;; TODO Can I autodetect "inputs" that should not trigger
     ;; construction?
     (let ((args (map ensure-cell args)))
       (define the-propagator
	 (one-shot-propagator args
	  (lambda ()
	    (apply prop-ctor args))))
       ;; This is the analogue of (compute-aggregate-metadata prop-ctor args)
       ;; TODO much work can be saved by use of the diagram made by
       ;; MAKE-COMPOUND-DIAGRAM.
       (make-diagram-for-compound-constructor
	the-propagator prop-ctor arg-cells)))))

;; This is a peer of PROPAGATOR
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
    (propagator neighbors test)))

;;; In application.scm
(let ((the-propagator
       (lambda ()
	 ((unary-mapping
	   (lambda (prop)
	     (if (done? prop)
		 unspecific
		 (attach prop))))
	  (content prop-cell)))))
  (name! the-propagator 'application)
  (propagator prop-cell the-propagator)
  (make-anonymous-i/o-diagram the-propagator (list prop-cell) arg-cells))

;;; In search.scm
(name! amb-choose 'amb-choose)
(propagator cell amb-choose) ; <-- No neighbors?
(make-anonymous-i/o-diagram amb-choose '() (list cell))



;; Various inspectors should use the diagram-clubs facility instead of
;; the cell neighbors field, which, though somewhat redundant, is used
;; for the scheduler and for a different purpose.

;; Also, all analogues of function->propagator-constructor should be
;; adjusted, and a new one made for compound propagators.

;; ./core/propagators.scm:(define (propagator neighbors to-do)  
;; ./core/propagators.scm:       (propagator inputs                ; The output isn't a neighbor!
;; ./core/propagators.scm:	(propagator inputs the-propagator)))
;; ./core/propagators.scm:    (propagator neighbors test)))
;; ./core/application.scm:    (propagator prop-cell the-propagator)))
;; ./core/search.scm:    (propagator cell amb-choose)))

;; ./extensions/virtual-environments.scm:      (propagator cells
;; ./extensions/virtual-environments.scm:      (propagator cells
;; ./extensions/virtual-closures.scm:  (propagator outside
;; ./extensions/virtual-closures.scm:  (propagator (cons frame-map-cell outside)
;; ./extensions/virtual-closures.scm:  (propagator (list frame-map-cell outside)
;; ./extensions/virtual-closures.scm:  (propagator (list frame-map-cell inside outside)
;; ./extensions/virtual-closures.scm:    (propagator (cons* frame-map-cell closure-cell outside-cells)
;; ./extensions/virtual-closures.scm:  (propagator output

;; ./examples/masyu.scm:  (propagator neighbors
;; ./examples/masyu.scm:  (propagator cells
;; ./examples/masyu.scm:  (propagator (list far-left left right far-right)
;; ./examples/masyu.scm:  (propagator (list far-left left right far-right)
;; ./examples/selectors/selectors.scm:    (propagator inputs the-propagator)))
;; ./examples/selectors/selectors.scm:    (propagator inputs the-propagator)))
;; ./examples/selectors/selectors.scm:    (propagator inputs the-propagator)))
