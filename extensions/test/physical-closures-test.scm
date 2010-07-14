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
 physical-closures

 (define-test (double)
   (interaction
    (initialize-scheduler)
    (define-cell double
      (make-closure
       'double
       (lambda ()
	 (lambda (x out)
	   (p:+ x x out)))
       '()))

    (define-cell x 2)
    (define-cell out)
    (application double x out)
    (run)
    (content out)
    (produces 4)

    ;; Stable under kicks:
    (alert-all-propagators!)
    (run)
    (content out)
    (produces 4)
    ))

 (define-test (addn)
   (interaction
    (initialize-scheduler)
    (define-cell addn
      (make-closure
       'addn
       (lambda ()
	 (lambda (n out)
	   ((p:constant
	     (make-closure
	      'addn-internal
	      (lambda (n)
		(lambda (x out)
		  (p:+ n x out)))
	      (list n)))
	    out)))
       '()))

    (define-cell n 5)
    (define-cell add5)
    (application addn n add5)

    (define-cell x 3)
    (define-cell out)
    (application add5 x out)
    
    (run)
    (content out)
    (produces 8)
    
    ;; Stable under kicks:
    (alert-all-propagators!)
    (run)
    (content out)
    (produces 8)
    ))

 (define-test (merge-addn)
   (interaction
    (initialize-scheduler)
    
    (define-cell addn
      (make-closure
       'addn
       (lambda ()
	 (lambda (n out)
	   ((p:constant
	     (make-closure
	      'addn-internal
	      (lambda (n)
		(lambda (x out)
		  (p:+ n x out)))
	      (list n)))
	    out)))
       '()))

    (define-cell n1 (make-interval 3 5))
    (define-cell n2 (make-interval 4 7))
    (define-cell add5)
    (application addn n1 add5)
    (application addn n2 add5)
    
    (define-cell x 3)
    (define-cell out)
    (application add5 x out)
    
    (run)
    (content out)
    (produces #(interval 7 8))

    (add-content n2 (make-interval 5 9))
    (run)
    (content out)
    (produces 8)
    ))

 (define-test (compose)
   (interaction
    (initialize-scheduler)
    (define-cell double
      (make-closure
       'double
       (lambda ()
	 (lambda (x out)
	   (p:+ x x out)))
       '()))
    (define-cell square
      (make-closure
       'double
       (lambda ()
	 (lambda (x out)
	   (p:* x x out)))
       '()))
    (define-cell compose
      (make-closure
       'compose
       (lambda ()
	 (lambda (f g out)
	   ((constant
	     (make-closure
	      'compose-inner
	      (lambda (f g)
		(lambda (x out)
		  (let-cell gx
		    (application g x gx)
		    (application f gx out))))
	      (list f g)))
	    out)))
       '()))
    (define-cell double-square)
    (application compose double square double-square)
    (define-cell square-double)
    (application compose square double square-double)
    (define-cell x 2)
    (define-cell 2x^2)
    (application double-square x 2x^2)
    (define-cell 4x^2)
    (application square-double x 4x^2)
    (run)
    (content 2x^2)
    (produces 8)
    (content 4x^2)
    (produces 16)
    
    ;; Stable under kicks:
    (alert-all-propagators!)
    (run)
    (content 2x^2)
    (produces 8)
    (content 4x^2)
    (produces 16)
    ))
#;
 (define-test (repeat)
   (interaction
    (initialize-scheduler)
    )))
