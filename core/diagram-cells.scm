;;; ----------------------------------------------------------------------
;;; Copyright 2011 Massachusetts Institute of Technology.
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

;;; What does it mean to merge a diagram into another diagram?

;;; The identity (name) of the merged diagram is that of the target
;;;
;;; The parts of the merged diagram is the set-union of the parts of
;;; the target and increment.
;;;
;;; If a promise is present and the same in both the target and
;;; increment, then keep the promise.
;;;
;;; If a promise is present in either the target or the increment but
;;; not both, and the part to which the promise applies is present
;;; only in the diagram in which the promise is made, keep the
;;; promise.

;;; QUESTIONS:
;;;
;;; - Should the existence of the previous diagrams be removed?
;;;   (i.e. should parts replace their membership in the clubs of the
;;;   target and increment with membership in the merge?)
;;;   [CURRENTLY: YES]
;;; - Should it be possible to merge cells? [CURRENTLY: NO]
(define (merge-diagram target increment)
  (let ((merged target))
    ;; Merge parts/clubs
    ;; What if the name is the same?
    (for-each (lambda (part)
		;; The position of the club is significant
		(let ((club.clubs (memq increment (diagram-clubs (cdr part)))))
		  (set-car! club.clubs merged))
		(add-diagram-named-part! merged (car part) (cdr part)))
	      (diagram-parts increment))
    
    ;; Merge promises
    (let ((merged-promises
	   (lset-union
	    ;; Can parts ever be equal? but not eq?
	    (lset-intersection diagram-promise-equal?
			       (diagram-promises merged)
			       (diagram-promises increment))
	    (filter (lambda (promise)
		      (not (eq? (memq (diagram-promise-target promise)
				      (map cdr (diagram-parts increment)))
				#f)))
		    (diagram-promises merged))
	    (filter (lambda (promise)
		      (not (eq? (memq (diagram-promise-target promise)
				      (map cdr (diagram-parts merged)))
				#f)))
		    (diagram-promises increment)))))
      (set-diagram-promises! merged merged-promises))
    
    ;; Finish unregistering the increment.
    (clear-diagram-parts! increment)
    (network-unregister increment)
    (clear-diagram-promises! increment)
    
    merged))

(define (diagram-equivalent? target increment)
  (and (= (length (lset-xor diagram-promise-equal?
			    (diagram-promises target)
			    (diagram-promises increment)))
	  0)
       (= (length (lset-xor eq?
			    ;; We just need parts, not names to be the
			    ;; same.
			    (map cdr (diagram-parts target))
			    (map cdr (diagram-parts increment))))
	  0)
       (= (length (lset-xor eq?
			    (diagram-clubs target)
			    (diagram-clubs increment)))
	  0)))

;;; Diagram merging

(defhandler merge merge-diagram %diagram? %diagram?)
(defhandler equivalent? diagram-equivalent? %diagram? %diagram?)

;;; *metadiagram* is the toplevel-diagram for diagram cells.  It is
;;; the only diagram that is not in a cell, and its only purpose is to
;;; hold cells in which diagrams are contained to keep them out of
;;; visualizations of the toplevel-diagram.
(define *metadiagram* (empty-diagram 'metadiagram))

;(define (toplevel-merge content increment)
;  (if (eq? increment *toplevel-diagram*)
;      increment
;      (merge content increment)))

;;; *toplevel-diagram-cell* is the cell containing the
;;; toplevel-diagram.  It belongs to the *metadiagram*
(define *toplevel-diagram-cell*
  (fluid-let ((register-diagram (diagram-inserter *metadiagram*)))
    (make-cell)))
(add-content *toplevel-diagram-cell* *toplevel-diagram*)

;;; Redefine diagram insertion in terms of operations on the
;;; *toplevel-diagram-cell*
(define (diagram-cell-inserter target-diagram-cell)
  (lambda (subdiagram #!optional name)
    ;;; Wrap the subdiagram in a diagram in a cell.
    (let ((subdiagram-wrapper (empty-diagram 'wrapper)))
      (if (default-object? name)
	  (note-diagram-part! subdiagram-wrapper subdiagram)
	  (add-diagram-named-part! subdiagram-wrapper name subdiagram))
      (add-content target-diagram-cell subdiagram-wrapper))
    subdiagram))

(define (register-diagram subdiagram #!optional name)
  ((diagram-cell-inserter *toplevel-diagram-cell*) subdiagram name))

(define (reset-diagrams!)
  ;; Clean out the metadiagram.
  (destroy-diagram! *metadiagram*)
  (set! *metadiagram* (empty-diagram 'metadiagram))
  (fluid-let ((register-diagram (diagram-inserter *metadiagram*)))
    ;; And then, reset the toplevel diagram.
    (set! *toplevel-diagram-cell* (make-cell)))
  ;; Hmmm...  This doesn't look monotonic.
  (destroy-diagram! *toplevel-diagram*)
  (set! *toplevel-diagram* (empty-diagram 'toplevel))
  (set! register-diagram (diagram-cell-inserter *toplevel-diagram-cell*))
  (add-content *toplevel-diagram-cell* *toplevel-diagram*))

(define (empty-diagram-cell identity)
  (let ((diagram-cell
	 (fluid-let ((register-diagram (diagram-inserter *metadiagram*)))
	   (make-cell))))
    (add-content diagram-cell (make-%diagram identity '() '()))
    diagram-cell))

(define (do-make-diagram-for-compound-constructor identity prop-ctor args)
  (with-independent-scheduler
   (lambda ()
     (let ((test-cell-map (map (lambda (arg)
				 (cons (make-cell) arg))
			       args)))
       (fluid-let ((*interesting-cells* (map car test-cell-map)))
	 (apply prop-ctor (map car test-cell-map)))
       ;; The following code shouldn't execute until the diagram
       ;; registrations from prop-ctor are reflected in the
       ;; *toplevel-diagram-cell*
       (propagator *toplevel-diagram-cell*
	 (lambda ()
	   ;; Specifically, we assume that there are parts to the
	   ;; *toplevel-diagram*, so we need to wait until this is
	   ;; true.
	   (if (null? (diagram-parts (contents *toplevel-diagram-cell*)))
	       'ok
	       (let ((prop-ctor-diagram
		      (car
		       ;; There should only be one of these
		       (filter (lambda (x) (not (cell? x)))
			       (map cdr
				    (diagram-parts
				     (contents *toplevel-diagram-cell*)))))))
		 (make-%diagram
		  identity
		  (map (lambda (name.part)
			 (cons (car name.part)
			       (cdr (assq (cdr name.part) test-cell-map))))
		       (filter (lambda (name.part)
				 (assq (cdr name.part) test-cell-map))
			       (diagram-parts prop-ctor-diagram)))
		  (map (lambda (promise)
			 (retarget-promise
			  promise
			  (cdr (assq (diagram-promise-target promise)
				     test-cell-map))))
		       (filter (lambda (promise)
				 (assq (diagram-promise-target promise)
				       test-cell-map))
			       (diagram-promises prop-ctor-diagram))))))))))))
