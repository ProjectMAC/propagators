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

(define (physical-call-site closure-cell arg-cells)
  (propagator closure-cell
    (lambda ()
      (if (nothing? (content closure-cell))
	  'ok
	  (let ((closure (content closure-cell)))
	    ;; TODO Deal with other partial information types!

	    ;; Do I need to memoize this?  Not if I can rely on the
	    ;; closure-cell only poking me once (when the closure
	    ;; shows up).

	    ;; This assumes that the closure itself can handle not
	    ;; needing to expand too much if its inputs are nothing.
	    (apply closure arg-cells))))))

(define-macro-propagator (compose f g compose-out)
  ;; The physical-copies version of lambda is just a constant that
  ;; spits out the Scheme procedure that implements that wiring
  ;; diagram.
  ((constant
    (named-macro-propagator (composition x answer)
      (let-cell intermediate
	(physical-call-site g (list x intermediate))
	(physical-call-site f (list intermediate answer)))))
   compose-out))

(define-macro-propagator (double x out)
  (adder x x out))

(define-macro-propagator (square x out)
  (multiplier x x out))

(initialize-scheduler)
(define-cell compose-cell)
(add-content compose-cell compose)
(define-cell double-cell)
(add-content double-cell double)
(define-cell square-cell)
(add-content square-cell square)

(define-cell square-double)
(physical-call-site compose-cell (list square-cell double-cell square-double))

(define-cell x)
(define-cell answer)

(physical-call-site square-double (list x answer))

(add-content x 4)

(run)

(pp (content answer))

(define-cell double-square)
(physical-call-site compose-cell (list double-cell square-cell double-square))

(define-cell x2)
(define-cell answer2)

(physical-call-site double-square (list x2 answer2))

(add-content x2 4)

(run)

(pp (content answer2))

(define-macro-propagator (m-repeat f n repeat-out)
  (let-cells (recur? not-recur? f-again n-again f-n-1 one n-1 out-again)
    ((constant 1) one)
    (=? n one not-recur?)
    (inverter not-recur? recur?)
    (switch not-recur? f repeat-out)
    (switch recur? f f-again)
    (switch recur? n n-again)
    (switch recur? out-again repeat-out)
    (subtractor n-again one n-1)
    (physical-call-site repeat-cell (list f-again n-1 f-n-1))
    (physical-call-site compose-cell (list f-n-1 f-again out-again))))
(define repeat (compoundify-propagator-constructor m-repeat))
(define-cell repeat-cell)
(add-content repeat-cell repeat)

(define-cell n)
(define-cell n-double)
(physical-call-site repeat-cell (list double-cell n n-double))

(define-cell x3)
(define-cell answer3)
(physical-call-site n-double (list x3 answer3))

(add-content x3 1)
(add-content n 4)
(run)
(pp (content answer3))
