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

(declare (usual-integrations))

(define fib-cl
  (let-cells (in-n fib-n one two recur not-recur
		   n-again n-1 n-2 fib-n-1 fib-n-2)
    (define fib-cl
      (make-closure
       (list in-n fib-n)
       (list one two recur not-recur n-again n-1 n-2 fib-n-1 fib-n-2)
       '()))

    ((vc:const 1) one)
    ((vc:const 2) two)
    (vc:<? in-n two not-recur)
    (vc:inverter not-recur recur)
    (vc:switch not-recur one fib-n)
    (vc:switch recur in-n n-again)
    (vc:subtractor n-again one n-1)
    (static-call-site fib-cl (list n-1 fib-n-1))
    (vc:subtractor n-again two n-2)
    (static-call-site fib-cl (list n-2 fib-n-2))
    (vc:adder fib-n-1 fib-n-2 fib-n)
    fib-cl))

(define quot-rem-cl
  (let-cells (dividend divisor quot rem)
    (vc:quotient dividend divisor quot)
    (vc:remainder dividend divisor rem)
    (make-closure (list dividend divisor quot rem) '() '())))

(define euclid-cl
  (let-cells (a b gcd zero recur not-recur
		a-again b-again a-mod-b a-quot-b gcd-again)
    (define euclid-cl
      (make-closure 
       (list a b gcd)
       (list zero recur not-recur a-again b-again a-mod-b a-quot-b gcd-again)
       '()))
    ((vc:const 0) zero)
    (vc:=? b zero not-recur)
    (vc:inverter not-recur recur)
    (vc:switch not-recur a gcd)
    (vc:switch recur a a-again)
    (vc:switch recur b b-again)
    (static-call-site quot-rem-cl (list a-again b-again a-quot-b a-mod-b))
    (static-call-site euclid-cl (list b-again a-mod-b gcd-again))
    (vc:switch recur gcd-again gcd)
    euclid-cl))
