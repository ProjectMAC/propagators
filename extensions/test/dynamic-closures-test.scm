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
 dynamic-closures

 (define-test (smoke)
   (interaction
    (initialize-scheduler)

    (define repl-frame (make-frame '()))
    (define-cell a)
    (define-cell b)
    (define-cell gcd-a-b)
    (define-cell euclid)
    (dynamic-call-site euclid (list a b gcd-a-b))
    (add-content a (alist->virtual-copies `((,repl-frame . ,(* 17 3)))))
    (add-content b (alist->virtual-copies `((,repl-frame . ,(* 17 5)))))
    (add-content euclid (alist->virtual-copies `((,repl-frame . ,euclid-cl))))
    (add-content gcd-a-b (alist->virtual-copies `((,repl-frame . ,nothing))))
    (run)
    (virtual-copies->alist (content gcd-a-b))
    (produces `((,repl-frame . 17)))))

 (define-test (closure-switching)
   (interaction
    (initialize-scheduler)
    
    (define repl-frame-a (make-frame '()))
    (define repl-frame-b (make-frame '()))
    (define-cell question)
    (define-cell answer)
    (define-cell closure)
    (dynamic-call-site closure (list question answer))
    (add-content question 
      (alist->virtual-copies
       `((,repl-frame-a . 4) (,repl-frame-b . 4))))
    (add-content answer 
      (alist->virtual-copies
       `((,repl-frame-a . ,nothing) (,repl-frame-b . ,nothing))))
    (add-content closure 
      (alist->virtual-copies
       `((,repl-frame-a . ,fact-cl) (,repl-frame-b . ,fib-cl))))
    (run)
    (virtual-copies->alist (content answer))
    (produces `((,repl-frame-a . 24) (,repl-frame-b . 5)))
    ))
 ;; TODO ((if mumble fact fib) 4) by tms premise?

 (define-test (lambda-smoke)
   (interaction
    (define-cell lambda-x)
    (let-cells (x x-out)
      (let-cells (y y-out)
	(adder x y y-out)
	(closure-emitter (list y y-out) '() x-out))
      (closure-emitter (list x x-out) '() lambda-x))
    (define-cell outer-x)
    (define-cell lambda-y)
    (dynamic-call-site lambda-x (list outer-x lambda-y))
    (define-cell outer-y)
    (define-cell answer)
    (dynamic-call-site lambda-y (list outer-y answer))
    (define repl-frame (make-frame '()))
    (add-content outer-x (alist->virtual-copies `((,repl-frame . 4))))
    (add-content outer-y (alist->virtual-copies `((,repl-frame . 3))))
    (for-each (lambda (cell)
		(add-content cell (alist->virtual-copies `((,repl-frame . ,nothing)))))
	      (list lambda-x lambda-y answer))
    (run)
    (virtual-copies->alist (content answer))
    (produces '())))

 )
