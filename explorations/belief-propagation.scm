;;; ----------------------------------------------------------------------
;;; Copyright 2010 Alexey Radul.
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

(define-structure message
  alist)

;;; TODO Not really slotful: imposes invariant that the alist is
;;; an alist; thus order-independent.
(slotful-information-type message? make-message message-alist)

(define (message-get message point)
  (cdr (assoc point (message-alist message))))

(define (message->alist message)
  (message-alist message))

(define (product numbers)
  (apply * numbers))

(define (sum numbers)
  (apply + numbers))

(define (pointwise-product support . messages)
  (make-message
   (map (lambda (point)
	  (cons point (product (map (lambda (message)
				      (message-get message point))
				    messages))))
	support)))

(propagatify pointwise-product)

(define (normalize-message message)
  (let ((constant (sum (map cdr (message-alist message)))))
    (make-message
     (map (lambda (pair)
	    (cons (car pair)
		  (/ (cdr pair) constant)))
	  (message-alist message)))))

(propagatify normalize-message)

(define-macro-propagator (variable support marginal factor-terminals)
  (for-each
   (lambda (terminal)
     (let ((other-terminals (delq terminal factor-terminals)))
       (apply p:pointwise-product
	      `(,support ,@(map terminal-variable other-terminals)
			 ,(terminal-factor terminal)))))
   factor-terminals)
  (p:normalize-message
   (apply e:pointwise-product
	  support (map terminal-variable factor-terminals))
   marginal))

(define (pointwise-sum-product factor support . messages)
  (define (sum-product points-chosen messages-left)
    (if (null? messages-left)
	(apply factor (reverse points-chosen))
	(sum (map (lambda (point-value)
		    (* (cdr point-value)
		       (sum-product (cons (car point-value) points-chosen)
				    (cdr messages-left))))
		  (message->alist (car messages))))))
  (make-message
   (map (lambda (point)
	  (cons point (sum-product (list point) messages)))
	support)))

(propagatify pointwise-sum-product)

(define-macro-propagator (factor-props factor terminals)
  ;; Ugh.  The factor comes in as a lisp procedure, because 
  ;; currying it the way I want is easier in lisp.
  (define (crunch-the-factor index factor)
    (define (splice lst index value)
      (append
       (take lst index)
       (list value)
       (drop lst index)))
    (define (fixed-factor . values) 
      (let ((other-terminal-values (except-last-pair values))
	    (value-at-index (car (last-pair values))))
	(apply factor (splice other-terminal-values index value-at-index))))
    (let-cell factor-cell
      (add-content factor-cell fixed-factor)
      factor-cell))
  (for-each
   (lambda (index)
     (let* ((terminal (list-ref terminals index))
	    (other-terminals (delq terminal terminals)))
       (apply p:pointwise-sum-product
	      `(,(crunch-the-factor index factor)
		,(terminal-support terminal)
		,@(map terminal-factor other-terminals)
		,(terminal-variable terminal)))))
   (iota (length terminals))))

(define-structure terminal
  support
  variable
  factor)

;;; Here lives the burglary-earthquake example

(define-structure (node (constructor %make-node))
  support
  marginal
  terminals)

(define (make-node num-terminals)
  (let-cells (support marginal)
    (%make-node
     support marginal
     (map (lambda (index)
	    (let-cells (variable factor)
	      (make-terminal support variable factor)))
	  (iota num-terminals)))))

(define (get-terminal node index)
  (list-ref (node-terminals node) index))

(define (variable-at-node node)
  (variable (node-support node) (node-marginal node) (node-terminals node)))

(define (conditional-probability-table alist . terminals)
  (define (normalize-cpt alist)
    ;; This is the place where we assume that the output node is
    ;; Boolean, and the given cpt lists the probability of it being
    ;; true.
    (apply
     append
     (map (lambda (row)
	    (let ((non-output-values (car row))
		  (prob-output-true (cdr row)))
	      `(((,@non-output-values #t) . ,prob-output-true)
		((,@non-output-values #f) . ,(- 1 prob-output-true)))))
	  alist)))
  (let ((nalist (normalize-cpt alist)))
    (define (factor . values)
      (force-assoc values nalist))
    (factor-props factor terminals)))

(define (build-burglary-network)
  (let ((burglary (make-node 2))
	(earthquake (make-node 2))
	(alarm (make-node 3))
	(john-calls (make-node 1))
	(mary-calls (make-node 1)))
    (let ((nodes (list burglary earthquake alarm john-calls mary-calls)))
      (define (boolean-support node)
	(add-content (node-support node) (list #t #f)))
      (for-each boolean-support nodes)
      (for-each variable-at-node nodes)
      (conditional-probability-table
       '((() . .001))
       (get-terminal burglary 0))
      (conditional-probability-table
       '((() . .002))
       (get-terminal earthquake 0))
      (conditional-probability-table
       '(((#t #t) . .95)
	 ((#t #f) . .94)
	 ((#f #t) . .29)
	 ((#f #f) . .001))
       (get-terminal burglary 1)
       (get-terminal earthquake 1)
       (get-terminal alarm 0))
      (conditional-probability-table
       '(((#t) . .90)
	 ((#f) . .05))
       (get-terminal alarm 1)
       (get-terminal john-calls 0))
      (conditional-probability-table
       '(((#t) . .70)
	 ((#f) . .01))
       (get-terminal alarm 2)
       (get-terminal mary-calls 0))
      nodes)))

(define (burglary-marginals evidence)
  (initialize-scheduler)
  (let ((nodes (build-burglary-network)))
    (run)
    (for-each pp (map content (map node-marginal nodes)))
    nodes))
