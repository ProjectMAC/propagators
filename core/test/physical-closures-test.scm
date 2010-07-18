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
       (lambda (x out)
	 (p:+ x x out))
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
       (lambda (n out)
	 ((p:constant
	   (make-closure
	    'addn-internal
	    (lambda (x out)
	      (p:+ n x out))
	    (list n)))
	  out))
       '()))

    (define-cell n 5)
    (define-cell add5)
    (application addn n add5)

    (define-cell x 3)
    (define-cell output)
    (application add5 x output)
    
    (run)
    (content output)
    (produces 8)
    
    ;; Stable under kicks:
    (alert-all-propagators!)
    (run)
    (content output)
    (produces 8)
    ))

 (define-test (merge-addn)
   (interaction
    (initialize-scheduler)
    
    (define-cell addn
      (make-e:closure
       'addn
       (lambda (n)
	 (e:constant
	  (make-e:closure
	   'addn-internal
	   (lambda (x)
	     (e:+ n x))
	   (list n))))
       '()))

    (define-cell n1 (make-interval 3 5))
    (define-cell n2 (make-interval 4 7))
    (define-cell add5 (e:application addn n1))
    (application addn n2 add5)
    
    (define-cell output (e:application add5 3))
    
    (run)
    (content output)
    (produces #(interval 7 8))

    (add-content n2 (make-interval 5 9))
    (run)
    (content output)
    (produces 8)
    ))

 (define-test (compose)
   (interaction
    (initialize-scheduler)
    (define-cell double
      (make-e:closure
       'double
       (lambda (x)
	 (e:+ x x))
       '()))
    (define-cell square
      (make-e:closure
       'square
       (lambda (x)
	 (e:* x x))
       '()))
    (define-cell compose
      (make-e:closure
       'compose
       (lambda (f g)
	 (e:constant
	  (make-e:closure
	   'compose-inner
	   (lambda (x)
	     (e:application f (e:application g x)))
	   (list f g))))
       '()))
    (define-cell double-square (e:application compose double square))
    (define-cell square-double (e:application compose square double))
    
    (define-cell x 2)
    (define-cell 2x^2 (e:application double-square x))
    (define-cell 4x^2 (e:application square-double x))
    
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

 (define-test (repeat)
   (interaction
    (initialize-scheduler)
    (define-cell double
      (make-e:closure
       'double
       (lambda (x)
	 (e:+ x x))
       '()))
    (define-cell compose
      (make-e:closure
       'compose
       (lambda (f g)
	 (e:constant
	  (make-e:closure
	   'compose-inner
	   (lambda (x)
	     (e:application f (e:application g x)))
	   (list f g))))
       '()))
    (define-cell repeat
      (let-cell (repeat)
	((constant
	  (make-closure
	   'repeat
	   (lambda (f n out)
	     (let-cell (repeat? (e:> n 1))
	       (let-cell (done? (e:not repeat?))
		 (switch done? f out)
		 (let-cells ((n-1 (e:- n 1))
			     fn-1 f-again out-again n-1-again compose-again repeat-again)
		   (switch repeat? n-1 n-1-again)
		   (switch repeat? f f-again)
		   (switch repeat? out-again out)
		   (switch repeat? compose compose-again)
		   (switch repeat? repeat repeat-again)
		   (application compose-again fn-1 f-again out-again)
		   (application repeat-again f-again n-1-again fn-1)))))
	   (list compose repeat)))
	 repeat)
	repeat))

    (define-cell output
      (e:application
       (e:application repeat double 4) 2))

    (run)
    (content output)
    (produces 32)
    ))

  (define-test (tms-addn)
   (interaction
    (initialize-scheduler)
    
    (define-cell addn
      (make-closure
       'addn
       (lambda (n out)
	 ((p:constant
	   (make-closure
	    'addn-internal
	    (lambda (x out)
	      (p:+ n x out))
	    (list n)))
	  out))
       '()))

    (define-cell add5-fred (e:application addn (make-interval 3 5)))
    (define-cell bill (make-interval 4 7))
    (define-cell add5-bill (e:application addn bill))

    (define-cell add5)
    (p:switch (make-tms (supported #t '(fred))) add5-fred add5)
    (p:switch (make-tms (supported #t '(bill))) add5-bill add5)

    (define-cell output (e:application add5 (make-tms (supported 3 '(joe)))))
    
    (run)
    (tms-query (content output))
    (produces #(supported #(interval 7 8) (joe bill fred)))

    (kick-out! 'bill)
    (run)
    (tms-query (content output))
    (produces #(supported #(interval 6 8) (joe fred)))

    (kick-out! 'fred)
    (run)
    (tms-query (content output))
    (produces nothing)
    
    (bring-in! 'bill)
    (run)
    (tms-query (content output))
    (produces #(supported #(interval 7 10) (joe bill)))
    
    (add-content bill (make-tms (supported (make-interval 5 9) '(harry))))
    (run)
    (tms-query (content output))
    (produces #(supported #(interval 8 10) (harry joe bill)))
    ))

  (define-test (first-class-primitives)
    (initialize-scheduler)
    (define-cell output (e:application p:+ 3 4))
    (run)
    (check (= 7 (content output))))

  (define-test (first-class-e:primitives)
    (initialize-scheduler)
    (define-cell output (e:application e:+ 3 4))
    (run)
    (check (= 7 (content output))))

  (define-test (first-class-macro-primitives)
    (initialize-scheduler)
    (define-cell x)
    (define-cell output (e:application sum-constraint 3 x))
    (add-content output 7)
    (run)
    (check (= 4 (content x))))

  (define-test (first-class-primitives-tms)
    (interaction
     (initialize-scheduler)
     (define-cell bill-op p:+)
     (define-cell fred-op e:*)
     (define-cell the-op)
     (switch (make-tms (supported #t '(bill))) bill-op the-op)
     (switch (make-tms (supported #t '(fred))) fred-op the-op)
     (define-cell output (e:application the-op 3 4))
     (run)
     (produces '(contradiction (bill fred)))
     (check (equal? '(application) (map name (neighbors the-op))))

     (kick-out! 'bill)
     (run)
     (tms-query (content output))
     (produces #(supported 12 (fred)))
     (check (equal? '(equivalent-closures? application)
		    (map name (neighbors the-op))))

     (kick-out! 'fred)
     (bring-in! 'bill)
     (run)
     (tms-query (content output))
     (produces #(supported 7 (bill)))
     (check (equal? '(equivalent-closures? equivalent-closures? application)
		    (map name (neighbors the-op))))
     ))

  )
