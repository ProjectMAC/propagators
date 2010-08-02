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

;;;; Defining cells

;; (define-cell foo form)
;; is the same as
;; (define foo (ensure-cell form))
;; except it grabs the name foo and associates it with the
;; cell that form constructs.
;;
;; For the frequent case when you want a fresh cell
;; (define-cell foo)
;; expands into
;; (define-cell foo (make-named-cell 'foo))
;; The metadata is then available two ways.

(define-syntax define-cell
  (syntax-rules ()
    ((define-cell symbol form)
     (define symbol (name-locally! (ensure-cell form) 'symbol)))
    ((define-cell symbol)
     (define-cell symbol (make-named-cell 'symbol)))))

;; (let-cells ((foo foo-form)
;;             (bar bar-form)
;;             (baz baz-form))
;;   stuff)
;; is the same as 
;; (let ((foo (ensure-cell foo-form))
;;       (bar (ensure-cell bar-form))
;;       (baz (ensure-cell baz-form)))
;;   stuff)
;; except that it captures the names foo bar and baz and associates
;; them with the cells that the corresponding forms return.
;;
;; For the frequent case when you want fresh cells
;; (let-cells (foo bar baz)
;;   stuff)
;; expands into
;; (let-cells ((foo (make-named-cell 'foo))
;;             (bar (make-named-cell 'bar))
;;             (baz (make-named-cell 'baz)))
;;   stuff)
;; The metadata is then available two ways.

;; The following would suffice for the above:
#;
 (define-syntax let-cells
   (syntax-rules ()
     ((let-cells ((name form) ...)
	form ...)
      (let ((name (name-locally! (ensure-cell form) 'name)) ...)
	form ...))
     ((let-cells (name ...)
	form ...)
      (let-cells ((name (make-named-cell 'name))...)
	form ...))))

;; The much more horrible LET-CELLS macro below allows the two use
;; patterns above to mix, as follows,
;; (let-cells ((foo foo-form)
;;             bar
;;             (baz baz-form))
;;   stuff)
;; and have the right thing happen.  It also interprets the
;; slightly more traditional
;; (let-cells ((foo foo-form)
;;             (bar)
;;             (baz baz-form))
;;   stuff)
;; in agreement with Scheme's let.

(define-syntax let-cells
  (syntax-rules ()
    ((let-cells (cell-binding ...)
       form ...)
     (let-cells "process-clauses"
       (cell-binding ...)
       ()
       form ...))
    ((let-cells "process-clauses"
       ()
       ((cell-name cell-form) ...)
       form ...)
     (let ((cell-name (name-locally! (ensure-cell cell-form) 'cell-name)) ...)
       form ...))
    ((let-cells "process-clauses"
       ((cell-name cell-form) clause ...)
       (done-clause ...)
       form ...)
     (let-cells "process-clauses"
       (clause ...)
       ((cell-name cell-form) done-clause ...)
       form ...))
    ((let-cells "process-clauses"
       ((cell-name) clause ...)
       (done-clause ...)
       form ...)
     (let-cells "process-clauses"
       (cell-name clause ...)
       (done-clause ...)
       form ...))
    ((let-cells "process-clauses"
       (cell-name clause ...)
       (done-clause ...)
       form ...)
     (let-cells "process-clauses"
       (clause ...)
       ((cell-name (make-named-cell 'cell-name)) done-clause ...)
       form ...))))

;; This version is a grammatical convenience if there is only one
;; cell.  (let-cell (foo foo-form) stuff) and (let-cell foo stuff) are
;; both ok and equivalent to (let-cells ((foo foo-form)) stuff) and
;; (let-cells (foo) stuff), respectively, which are more awkward to
;; read.

(define-syntax let-cell
  (syntax-rules ()
    ((let-cell cell-binding
       form ...)
     (let-cells (cell-binding)
       form ...))))

;; And here is the moral equivalent of let*
(define-syntax let-cells*
  (syntax-rules ()
    ((let-cells* (binding bindings ...)
       form ...)
     (let-cell binding
       (let-cells* (bindings ...)
	 form ...)))
    ((let-cells* ()
       form ...)
     (let-cells ()
       form ...))))

;; TODO Do I need let-cells-rec?  What would that do for me?
