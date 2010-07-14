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
       (lambda ()
	 (lambda (n out)
	   ((p:constant
	     (make-closure
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
#;
 (define-test (repeat)
   (interaction
    (initialize-scheduler)
    )))
