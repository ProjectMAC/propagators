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

(define-structure
 (v&s (named 'supported) (type vector)
      (constructor supported) (print-procedure #f)
      (safe-accessors #t))
 value support)

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
			  (merge-supports v&s1 v&s2))))
	(map (attach-support-to-effect (merge-supports v&s1 v&s2))
	     value-effects))))))

;; TODO This wants to be a generic operation
(define ((attach-support-to-effect support) effect)
  (cond ((nogood-effect? effect)
	 (make-nogood-effect
	  (lset-union eq? (nogood-effect-nogood effect) support)))))

(defhandler merge v&s-merge v&s? v&s?)

(defhandler contradictory?
 (lambda (v&s) (contradictory? (v&s-value v&s)))
 v&s?)

(defhandler generic-unpack
  (lambda (v&s function)
    (supported
     (generic-bind (v&s-value v&s) function)
     (v&s-support v&s)))
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
      (merge-supports v&s (v&s-value v&s)))))
  (lambda (thing) (and (v&s? thing) (v&s? (v&s-value thing)))))

(define *flat-types-list* '())

(define (flat? thing)
  (apply boolean/or (map (lambda (type) (type thing)) *flat-types-list*)))

(define (specify-flat type)
  (if (memq type *flat-types-list*)
      'ok
      (set! *flat-types-list* (cons type *flat-types-list*))))

(specify-flat symbol?)
(specify-flat number?)
(specify-flat boolean?)
(specify-flat interval?)

(define (->v&s thing)
  (if (v&s? thing)
      thing
      (supported thing '())))

(defhandler merge (coercing ->v&s v&s-merge) v&s? flat?)
(defhandler merge (coercing ->v&s v&s-merge) flat? v&s?)
