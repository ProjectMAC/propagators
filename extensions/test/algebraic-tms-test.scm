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

(in-test-group
 algebraic-tms
 (define-test (smoke)
   (interaction
    (initialize-scheduler)
    (define-cell bill (make-tms (supported 3 '(bill))))
    (define-cell bill-cons (e:cons nothing bill))
    (define-cell answer)
    (c:== bill-cons answer)
    (define-cell fred (make-tms (supported 4 '(fred))))
    (define-cell fred-cons (e:cons fred nothing))
    (define-cell george (make-tms (supported #t '(george))))
    (conditional-wire george fred-cons answer)
    (define-cell the-pair? (e:pair? answer))
    (define-cell the-car (e:car answer))
    (define-cell the-cdr (e:cdr answer))
    (run)
    ; (pp (content answer))
    (content the-pair?)
    (produces #(tms (#(supported #t ()))))
    (content the-car)
    (produces #(tms (#(supported 4 (fred george)))))
    (content the-cdr)
    (produces #(tms (#(supported 3 (bill)))))))

 (define-test (contradictions)
   (check
    (generic-match
     #(effectful
       #(algebraic-tms
	 #(tms
	   (#(supported (#(*the-nothing*) . #(*the-nothing*)) (joe))
	    #(supported (#(*the-nothing*) . #(*the-nothing*)) (george))))
	 (car . #(tms (#(supported 3 (bill joe)) #(supported 4 (fred george)))))
	 (cdr . #(tms ())))
       #(nogood-effect ((george fred bill joe))))
     (merge (->algebraic-tms
	     (make-tms (supported
			(cons (make-tms (supported 4 '(fred))) nothing)
			'(george))))
	    (->algebraic-tms
	     (make-tms (supported
			(cons (make-tms (supported 3 '(bill))) nothing)
			'(joe)))))))))
