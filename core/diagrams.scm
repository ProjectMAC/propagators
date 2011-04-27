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
      (or (eq-get thing 'parts) '())))

(define (set-diagram-parts! thing new-parts)
  (if (%diagram? thing)
      (set-%diagram-parts! thing new-parts)
      (eq-put! thing 'parts new-parts)))

(define (clear-diagram-parts! thing)
  (set-diagram-parts! thing '()))

(define (diagram-promises thing)
  (if (%diagram? thing)
      (%diagram-promises thing)
      (or (eq-get thing 'promises) '())))

(define (set-diagram-promises! thing new-promises)
  (if (%diagram? thing)
      (set-%diagram-promises! thing new-promises)
      (eq-put! thing 'promises new-promises)))

(define (clear-diagram-promises! thing)
  (set-diagram-promises! thing '()))

(define (diagram-clubs thing)
  (if (%diagram? thing)
      (%diagram-clubs thing)
      (or (eq-get thing 'clubs) '())))

(define (set-diagram-clubs! thing new-clubs)
  (if (%diagram? thing)
      (set-%diagram-clubs! thing new-clubs)
      (eq-put! thing 'clubs new-clubs)))

(define (clear-diagram-clubs! thing)
  (set-diagram-clubs! thing '()))

(define (add-diagram-club! thing club)
  (set-diagram-clubs! thing (lset-adjoin eq? (diagram-clubs thing) club)))

(define (remove-diagram-club! thing club)
  ;; delq == lset-delete eq?
  (set-diagram-clubs! thing (delq club (diagram-clubs thing))))

;;; Abstraction barrier

;;; Invariants:
;;; - Every part of a diagram should be a (possibly implicit) diagram.
;;; - Every club a diagram particiaptes in should be a (possibly
;;;   implicit) diagram.
;;; - The clubs list of a diagram X should always contain exactly the
;;;   diagrams that contain X as a part.

(define (make-%diagram identity parts promises)
  (let ((answer (%make-%diagram identity parts promises '())))
    ;; produces (eq-adjoin! output 'shadow-connections the-propagator)
    (for-each (lambda (part)
		(add-diagram-club! part answer))
	      (map cdr parts))
    answer))

(define (empty-diagram identity)
  (make-%diagram identity '() '()))

(define (make-compound-diagram identity parts)
  (make-%diagram identity parts (compute-derived-promises parts)))

(define (compute-derived-promises parts)
  ;; TODO For every part that's a cell, I can promise not to read
  ;; (resp. write) it if every part either doesn't mention it or
  ;; promises not to read (resp. write) it.  See
  ;; DO-COMPUTE-AGGREGATE-METADATA.  I just have to take due care to
  ;; make sure that recursive parts are properly taken care of.
  '())

(define diagram make-compound-diagram)

(define (add-diagram-named-part! diagram name part)
  (set-diagram-parts!
   diagram
   (lset-adjoin equal? (diagram-parts diagram) (cons name part)))
  (add-diagram-club! part diagram))

(define (delete-diagram-part! diagram part)
  (set-diagram-parts!
   diagram
   (filter (lambda (name.part)
	     (not (eq? (cdr name.part) part)))
	   (diagram-parts diagram)))
  (remove-diagram-club! part diagram))

(define (names-in-diagram diagram part)
  (map car (filter (lambda (name.part)
		     (eq? part (cdr name.part)))
		   (diagram-parts diagram))))

;;;; Implicit diagram production

(define *toplevel-diagram* (empty-diagram 'toplevel))

(define (diagram-inserter target-diagram)
  (lambda (subdiagram #!optional name)
    (if (default-object? name)
	(note-diagram-part! target-diagram subdiagram)
	(add-diagram-named-part! target-diagram name subdiagram))
    subdiagram))

;;; Every propagator constructor is expected to call the procedure
;;; REGISTER-DIAGRAM exactly once on a diagram describing the network
;;; it just constructed.  This procedure is a fluid-bindable hook.  In
;;; addition, a diagram-style propagator constructor is expected to
;;; return that same diagram, whereas an expression-style propagator
;;; constructor is expected to return the cell containing its return
;;; value.

(define register-diagram (diagram-inserter *toplevel-diagram*))

(define (note-diagram-part! diagram part)
  (if (memq part (map cdr (diagram-parts diagram)))
      'ok
      (add-diagram-named-part! diagram (generate-uninterned-symbol) part)))

(define (delete-diagram-parts! diagram)
  (for-each
   (lambda (part)
     (delete-diagram-part! diagram part)
     (if (null? (diagram-clubs part))
	 (network-unregister part)))
   (map cdr (diagram-parts diagram))))

(define (network-unregister thing)
  (for-each
   (lambda (club)
     (delete-diagram-part! club thing))
   (diagram-clubs thing))
  (delete-diagram-parts! thing))

(define (replace-diagram! diagram new-diagram)
  (delete-diagram-parts! diagram)
  (for-each
   (lambda (name.part)
     (add-diagram-named-part! diagram (car name.part) (cdr name.part)))
   (diagram-parts new-diagram))
  (network-unregister new-diagram))

;;; Getting rid of diagrams when they are no longer needed requires
;;; eliminating appropriate entries in the eq-properties table,
;;; because those values would otherwise point back to themselves.

(define (destroy-diagram! diagram)
  (clear-diagram-clubs! diagram)
  (clear-diagram-promises! diagram)
  (for-each destroy-diagram! (map cdr (diagram-parts diagram)))
  (clear-diagram-parts! diagram))

(define (reset-diagrams!)
  (destroy-diagram! *toplevel-diagram*)
  (set! *toplevel-diagram* (empty-diagram 'toplevel)))

;;; Restarting requires resetting the toplevel diagram
(define initialize-scheduler
  (let ((initialize-scheduler initialize-scheduler))
    (lambda ()
      (initialize-scheduler)
      (reset-diagrams!))))

(define with-independent-scheduler
  (let ((with-independent-scheduler with-independent-scheduler))
    (lambda args
      (fluid-let ((*toplevel-diagram* #f))
	(apply with-independent-scheduler args)))))

;;;; New transmitters at the primitive-diagram level

;; Stubs:
(define (promise-not-to-write thing) #f)
(define (promise-not-to-read thing) #f)

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

(defhandler name
  (lambda (diagram)
    (let ((own-name (default-name diagram)))
      (if (not (eq? own-name diagram))
	  own-name
	  (let ((my-names
		 (append-map
		  (lambda (club)
		    (names-in-diagram club diagram))
		  (diagram-clubs diagram))))
	    (if (null? my-names)
		diagram
		(last my-names))))))
  diagram?)
