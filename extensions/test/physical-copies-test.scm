;;; ----------------------------------------------------------------------
;;; Copyright 2009-2010 Alexey Radul.
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

(in-test-group
 physical-copies

 (define-test (direct-repeat)
   (interaction
    (initialize-scheduler)
    
    (define-macro-propagator (compose f g compose-out)
      ((constant
	(named-macro-propagator (composition x answer)
	  (let-cell intermediate
	    (direct-call-site g (list x intermediate))
	    (direct-call-site f (list intermediate answer)))))
       compose-out))
    (define-cell compose-cell)
    (add-content compose-cell compose)

    (define-macro-propagator (double x out)
      (adder x x out))
    (define-cell double-cell)
    (add-content double-cell double)

    (define-macro-propagator (square x out)
      (multiplier x x out))
    (define-cell square-cell)
    (add-content square-cell square)

    (define-cell square-double)
    (direct-call-site
     compose-cell (list square-cell double-cell square-double))

    (define-cell x)
    (define-cell answer)

    (direct-call-site square-double (list x answer))

    (add-content x 4)
    (run)
    (content answer)
    (produces 64)

    (define-cell double-square)
    (direct-call-site
     compose-cell (list double-cell square-cell double-square))

    (define-cell x2)
    (define-cell answer2)

    (direct-call-site double-square (list x2 answer2))

    (add-content x2 4)
    (run)
    (content answer2)
    (produces 32)

    (define-compound-propagator (repeat f n repeat-out)
      (let-cells (recur? not-recur? f-again n-again f-n-1 one n-1 out-again)
	((constant 1) one)
	(=? n one not-recur?)
	(inverter not-recur? recur?)
	(switch not-recur? f repeat-out)
	(switch recur? f f-again)
	(switch recur? n n-again)
	(switch recur? out-again repeat-out)
	(subtractor n-again one n-1)
	(direct-call-site repeat-cell (list f-again n-1 f-n-1))
	(direct-call-site compose-cell (list f-n-1 f-again out-again))))
    (define-cell repeat-cell)
    (add-content repeat-cell repeat)

    (define-cell n)
    (define-cell n-double)
    (direct-call-site repeat-cell (list double-cell n n-double))

    (define-cell x3)
    (define-cell answer3)
    (direct-call-site n-double (list x3 answer3))

    (add-content x3 1)
    (add-content n 4)
    (run)
    (content answer3)
    (produces 16)
    ))

 (define-test (repeat)
   (interaction
    (initialize-scheduler)
    
    (define-macro-propagator (compose f g compose-out)
      ((constant
	(named-macro-propagator (composition x answer)
	  (let-cell intermediate
	    (call-site g (list x intermediate))
	    (call-site f (list intermediate answer)))))
       compose-out))
    (define-cell compose-cell)
    (add-content compose-cell compose)

    (define-macro-propagator (double x out)
      (adder x x out))
    (define-cell double-cell)
    (add-content double-cell double)

    (define-macro-propagator (square x out)
      (multiplier x x out))
    (define-cell square-cell)
    (add-content square-cell square)

    (define-cell square-double)
    (call-site
     compose-cell (list square-cell double-cell square-double))

    (define-cell x)
    (define-cell answer)

    (call-site square-double (list x answer))

    (add-content x 4)
    (run)
    (content answer)
    (produces 64)

    (define-cell double-square)
    (call-site
     compose-cell (list double-cell square-cell double-square))

    (define-cell x2)
    (define-cell answer2)

    (call-site double-square (list x2 answer2))

    (add-content x2 4)
    (run)
    (content answer2)
    (produces 32)

    (define-compound-propagator (repeat f n repeat-out)
      (let-cells (recur? not-recur? f-again n-again f-n-1 one n-1 out-again)
	((constant 1) one)
	(=? n one not-recur?)
	(inverter not-recur? recur?)
	(switch not-recur? f repeat-out)
	(switch recur? f f-again)
	(switch recur? n n-again)
	(switch recur? out-again repeat-out)
	(subtractor n-again one n-1)
	(call-site repeat-cell (list f-again n-1 f-n-1))
	(call-site compose-cell (list f-n-1 f-again out-again))))
    (define-cell repeat-cell)
    (add-content repeat-cell repeat)

    (define-cell n)
    (define-cell n-double)
    (call-site repeat-cell (list double-cell n n-double))

    (define-cell x3)
    (define-cell answer3)
    (call-site n-double (list x3 answer3))

    (add-content x3 1)
    (add-content n 4)
    (run)
    (content answer3)
    (produces 16)
    ))
)
