;;; ----------------------------------------------------------------------
;;; Copyright 2010 Massachusetts Institute of Technology
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

(declare (usual-integrations))

;;;; Most General Generic Dispatch, accelerated for the common case

;;; A handler tree is a trie.  It is an association list of predicate
;;; to subtree.  To look up a list of items in a handler tree, apply
;;; each top-level predicate in turn to the first item.  Whenever one
;;; matches, recursively look up the rest of the list in the
;;; corresponding subtree.  Backtracking may be needed.

(define (make-generic-operator-axch arity #!optional name)
  (guarantee-procedure-arity arity 'make-generic-operator)
  (if (default-object? name)
      (set! name #f))
  (and name (guarantee-symbol name 'make-generic-operator))
  (let* ((internal-generic (compute-internal-generic arity name))
	 (operator (compute-toplevel-operator internal-generic)))
    (set-operator-record! operator internal-generic)
    operator))

(define (procedure-arity-dispatch thing . options)
  (define (do-procedure-arity-dispatch arity)
    (let ((min (procedure-arity-min arity)))
      (if (and (eqv? min (procedure-arity-max arity))
	       (< min (length options)))
	  (list-ref options min)
	  (car options))))
  (cond ((procedure-arity? thing)
	 (do-procedure-arity-dispatch thing))
	((generic-procedure? thing)
	 (do-procedure-arity-dispatch (generic-procedure-arity thing)))
	((procedure? thing)
	 (do-procedure-arity-dispatch (procedure-arity thing)))
	(else
	 (error "Unknown arity of object" thing))))

(define (compute-toplevel-operator generic)
  ((procedure-arity-dispatch
    generic toplevel-operator toplevel-operator-1 toplevel-operator-2)
   generic))

(define (toplevel-operator generic)
  (lambda args
    (let ((handler (apply generic args)))
      (if handler
	  (apply handler args)
	  (error "No applicable methods" generic args)))))

(define (toplevel-operator-1 generic)
  (lambda (arg)
    (let ((handler (generic arg)))
      (if handler
	  (handler arg)
	  (error "No applicable methods" generic arg)))))

(define (toplevel-operator-2 generic)
  (lambda (arg1 arg2)
    (let ((handler (generic arg1 arg2)))
      (if handler
	  (handler arg1 arg2)
	  (error "No applicable methods" generic arg1 arg2)))))

(define (compute-internal-generic arity name)
  (let* ((answer (make-generic-procedure arity name))
	 (record (make-method-record '()))
	 (method (make-method (list <object>)
                   ((procedure-arity-dispatch
		     arity bottom-method-procedure
		     bottom-method-procedure-1 bottom-method-procedure-2)
		    record))))
    (add-method answer method)
    (set-operator-record! method record)
    answer))

(define-structure method-record
  tree)

(define (bottom-method-procedure method-record)
  (lambda args
    (search-tree method-record args)))

(define (bottom-method-procedure-1 method-record)
  (lambda (arg)
    (search-tree-1 method-record arg)))

(define (bottom-method-procedure-2 method-record)
  (lambda (arg1 arg2)
    (search-tree-2 method-record arg1 arg2)))

(define-integrable (search-tree method-record args)
  (let per-arg ((tree (method-record-tree method-record))
		(args args))
    (if (null? args)
	tree
	(find-branch tree (car args)
	  (lambda (branch)
	    (per-arg branch (cdr args)))))))

(define-integrable (search-tree-1 method-record arg)
  (find-branch (method-record-tree method-record) arg branch-found))

(define-integrable (search-tree-2 method-record arg1 arg2)
  (find-branch (method-record-tree method-record) arg1
    (lambda (branch)
      (find-branch branch arg2 branch-found))))

(define-integrable (find-branch tree item win)
  (let loop ((tree tree))
    (and (pair? tree)
	 (or (and ((caar tree) item) (win (cdar tree)))
	     (loop (cdr tree))))))

(define-integrable (branch-found branch)
  branch)

(define (defhandler-axch operator handler . argument-guards)
  (let* ((generic (get-operator-record operator))
	 (specializers (map desired-specializer argument-guards))
	 (maybe-target-method
	  (find (lambda (method)
		  (specializers=? (method-specializers method)
				  specializers))
		(generic-procedure-methods generic)))
	 (target-method
	  (if maybe-target-method
	      maybe-target-method
	      (add-intermediate-search-method generic specializers)))
	 (method-record (get-operator-record target-method)))
    (set-method-record-tree! method-record
      (bind-in-tree (map desired-guard argument-guards) handler
		    (method-record-tree method-record))))
  operator)

(define (add-intermediate-search-method generic specializers)
  (let* ((record (make-method-record '()))
	 (method
	  (make-chained-method specializers
	    ((procedure-arity-dispatch generic
	       intermediate-method-procedure
	       intermediate-method-procedure-1
	       intermediate-method-procedure-2)
	     record))))
    (add-method generic method)
    (set-operator-record! method record)
    method))

(define (intermediate-method-procedure method-record)
  (lambda (call-next-method)
    (lambda args
      (or (search-tree method-record args)
	  (apply call-next-method args)))))

(define (intermediate-method-procedure-1 method-record)
  (lambda (call-next-method)
    (lambda (arg)
      (or (search-tree-1 method-record arg) (call-next-method arg)))))

(define (intermediate-method-procedure-2 method-record)
  (lambda (call-next-method)
    (lambda (arg1 arg2)
      (or (search-tree-2 method-record arg1 arg2)
	  (call-next-method arg1 arg2)))))

(define (desired-specializer guard)
  (cond ((specializer? guard) guard)
	((procedure? guard) <object>)
	((guard? guard) (guard-specializer guard))
	(else
	 (error "Unsupported guard type" guard))))

(define (desired-guard guard)
  (cond ((specializer? guard) any?)
	((procedure? guard) guard)
	((guard? guard) (guard-procedure guard))
	(else
	 (error "Unsupported guard type" guard))))

(define-structure (guard (constructor guard))
  specializer
  procedure)

#;
(define (make-generic-operator arity #!optional name default-operation)
  (let ((answer (make-generic-operator-axch arity name)))
    (if (not (default-object? default-operation))
	(apply defhandler-axch answer default-operation (make-list arity <object>)))
    answer))
#;
(define defhandler defhandler-axch)