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

(define *depends-wallp* #f)

(define (depends-printer state object)
  (with-current-unparser-state state
    (lambda (port)
      (display "#(value=" port)
      (write (v&s-value object) port)
      (display ", premises=" port)
      (write (v&s-support object) port)
      (display " informants=" port)
      (write
       (map (if *depends-wallp* name-stack name)
	    (v&s-informants object))
       port)
      (display ")" port))))

(define-structure
 (v&s (named 'supported) (type vector)
      (constructor %supported)
      (print-procedure depends-printer)
      (safe-accessors #t))
 value support informants)

(define *active-propagator* 'user)

(define (supported value depends #!optional informants)
  (%supported value depends
	      (if (default-object? informants)
		  (list *active-propagator*)
		  informants)))

;;; Aliases

(define make-dependent-value supported)
(define depends? v&s?)
(define depends-value v&s-value)
(define depends-premises v&s-support)
(define depends-informants v&s-informants)

(define contingent supported)
(define contingent? v&s?)
(define contingent-info v&s-value)
(define contingent-premises v&s-support)
(define contingent-informants v&s-informants)

(declare-coercion-target contingent
			 (lambda (thing)
			   (contingent thing '())))

(declare-coercion <symbol> ->contingent)
(declare-coercion <number> ->contingent)
(declare-coercion <boolean> ->contingent)
(declare-coercion rtd:%interval ->contingent)
(declare-coercion propagator-constructor? ->contingent)
(declare-coercion closure? ->contingent)
(declare-coercion pair? ->contingent)

(define (more-informative-support? v&s1 v&s2)
  (and (not (lset= eq? (v&s-support v&s1) (v&s-support v&s2)))
       (lset<= eq? (v&s-support v&s1) (v&s-support v&s2))))

(define (merge-supports . v&ss)
  (apply lset-union eq? (map v&s-support v&ss)))

(define (v&s-merge v&s1 v&s2)
  (let* ((v&s1-value (v&s-value v&s1))
         (v&s2-value (v&s-value v&s2))
         (value-merge+effects (->effectful (merge v&s1-value v&s2-value))))
    (let ((value-merge (effectful-info value-merge+effects))
	  (value-effects (effectful-effects value-merge+effects)))
      (effectful->
       (make-effectful
	(cond ((eq? value-merge v&s1-value)
	       (if (implies? v&s2-value value-merge)
		   ;; Confirmation of existing information
		   (if (more-informative-support? v&s2 v&s1)
		       v&s2
		       v&s1)
		   ;; New information is not interesting
		   v&s1))
	      ((eq? value-merge v&s2-value)
	       ;; New information overrides old information
	       v&s2)
	      (else
	       ;; Interesting merge, need both provenances
	       (supported value-merge
			  (merge-supports v&s1 v&s2)
			  (lset-union eq?
				      (v&s-informants v&s1)
				      (v&s-informants v&s2)))))
	(map (attach-support-to-effect (merge-supports v&s1 v&s2))
	     value-effects))))))

(define ((attach-support-to-effect support) effect)
  ((generic-attach-premises effect) support))

(define generic-attach-premises (make-generic-operator 1 'attach-support))

(defhandler generic-attach-premises
  (lambda (effect)
    (lambda (support)
      (make-cell-join-effect
       (cell-join-effect-cell1 effect)
       (cell-join-effect-cell2 effect)
       (generic-flatten ;; TODO Do I need to do this by flattening?
	(make-tms ;; TODO Get rid of this forward reference
	 (supported
	  (cell-join-effect-control effect)
	  support))))))
  cell-join-effect?)

(defhandler-coercing merge v&s-merge ->contingent)

(define (v&s-equivalent? v&s1 v&s2)
  (and (lset= eq? (v&s-support v&s1) (v&s-support v&s2))
       (equivalent? (v&s-value v&s1) (v&s-value v&s2))))

(defhandler equivalent? v&s-equivalent? v&s? v&s?)

(defhandler contradictory?
 (lambda (v&s) (contradictory? (v&s-value v&s)))
 v&s?)

(define (v&s-> v&s)
  (if (nothing? (v&s-value v&s))
      nothing
      v&s))

(define (v&s-binary-map v&s1 v&s2)
  (lambda (f)
    (v&s->
     (supported
      (f (v&s-value v&s1) (v&s-value v&s2))
      (merge-supports v&s1 v&s2)
      (lset-union eq?
		  (v&s-informants v&s1)
		  (v&s-informants v&s2))))))

(defhandler-coercing binary-map v&s-binary-map ->contingent)

(defhandler generic-unpack
  (lambda (v&s function)
    (supported
     (generic-bind (v&s-value v&s) function)
     (v&s-support v&s)
     (v&s-informants v&s)))
  v&s? any?)

;;; This particular predicate dispatch system doesn't actually do 
;;; predicate specificity computations.  However, defining the most
;;; general handler first has the desired effect.
(defhandler generic-flatten
  (lambda (v&s) v&s)
  v&s?)

(defhandler generic-flatten
  (lambda (v&s) nothing)
  (lambda (thing) (and (v&s? thing) (nothing? (v&s-value thing)))))

(defhandler generic-flatten
  (lambda (v&s)
    (generic-flatten
     (supported
      (v&s-value (v&s-value v&s))
      (merge-supports v&s (v&s-value v&s))
      (v&s-informants v&s))))
  (lambda (thing) (and (v&s? thing) (v&s? (v&s-value thing)))))
