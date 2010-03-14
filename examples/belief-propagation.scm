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

(define-propagator-macro (variable support factor-terminals)
  (for-each
   (lambda (terminal)
     (let ((other-terminals (delq terminal factor-terminals)))
       (apply p:pointwise-product
	      `(,support ,@(map terminal-variable other-terminals)
			 ,(terminal-factor terminal)))))
   factor-terminals))

(define (pointwise-sum-poduct factor support . messages)
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

(propagatify pointwise-sum-poduct)

(define-propagator-macro (factor-props factor terminals)
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
