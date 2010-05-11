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

(define (cell-merge cell1 cell2)
  (effectful->
   (make-effectful
    cell1
    (list (make-cell-join-effect cell1 cell2 #t)))))

(defhandler merge cell-merge cell? cell?)

(define-structure cell-join-effect
  cell1
  cell2
  control)

(define (execute-cell-join effect)
  (let ((cell1 (cell-join-effect-cell1 effect))
	(cell2 (cell-join-effect-cell2 effect))
	(control-info (cell-join-effect-control effect)))
    (let ((control (the-bridge-control cell1 cell2)))
      (add-content control control-info))))

(defhandler execute-effect
  execute-cell-join
  cell-join-effect?)

(define (the-bridge-control cell1 cell2)
  (let ((candidate (eq-get cell1 cell2)))
    (or candidate
	(let ((control (make-named-cell 'bridge-control)))
	  ;; TODO Think about whether this really needs to be
	  ;; symmetric
	  (switch control cell1 cell2)
	  (switch control cell2 cell1)
	  (eq-put! cell1 cell2 control)
	  (eq-put! cell2 cell1 control)
	  control))))

(defhandler generic-attach-support
  (lambda (effect)
    (lambda (support)
      (make-cell-join-effect
       (cell-join-effect-cell1 effect)
       (cell-join-effect-cell2 effect)
       (generic-flatten
	(make-tms
	 (supported
	  (cell-join-effect-control effect)
	  support))))))
  cell-join-effect?)

(define-macro-propagator (p:carry-cons a-cell d-cell output)
  ((constant (cons a-cell d-cell))
   output))
(define e:carry-cons (functionalize p:carry-cons))

(define-macro-propagator (p:carry-car pair-cell output)
  (p:carry-cons output nothing pair-cell))
(define e:carry-car (functionalize p:carry-car))

(define-macro-propagator (p:carry-cdr pair-cell output)
  (p:carry-cons nothing output pair-cell))
(define e:carry-cdr (functionalize p:carry-cdr))

(define effectful->
  (let ((effectful-> effectful->))
    (lambda (effect)
      (effectful->
       (make-effectful
	(effectful-info effect)
	(filter (lambda (effect)
		  (not (boring-cell-join? effect)))
		(effectful-effects effect)))))))

(define (boring-cell-join? effect)
  (and (cell-join-effect? effect)
       (let ((cell1 (cell-join-effect-cell1 effect))
	     (cell2 (cell-join-effect-cell2 effect))
	     (control-info (cell-join-effect-control effect)))
	 (or (eq? cell1 cell2)
	     (let ((candidate (eq-get cell1 cell2)))
	       (and candidate
		    (implies? (content candidate)
			      control-info)))))))
