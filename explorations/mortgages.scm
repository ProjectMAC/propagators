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

;;; A abortive attempt at a multidirectional mortgage calculator, both
;;; for the fun of it and because I am interested in having that
;;; program.

(define (mortgage-term amount rate payment)
  (if (<= amount 0)
      0
      (let ((next-amount (* rate (- amount payment))))
	(if (>= next-amount amount)
	    'infinite
	    (+ 1 (mortgage-term next-amount rate payment))))))

;;; Assuming the interest is applied before the payment, the formula
;;; for balance after n cycles is
;;; 
;;; Ar^n - Pr^(n-1) - ... - P = Ar^n - P(r^n - 1)/(r - 1),
;;; 
;;; where A is the initial balance, P is the payment, and r is 1 + the
;;; unit interest rate (i.e. 5% per month is r=1.05).  (check it!)
;;; For a mortgage to be exactly repaid with n payments, this
;;; residual balance must be exactly zero.  This condition suffices
;;; to compute the payment from the principal or vice versa, given
;;; the rate and the term.
(define (mortgage<->payment mortgage-amt interest-rate term payment)
  (identity-constraint
   (c:* mortgage-amt (p:expt interest-rate term))
   (c:* payment
	(p:/ (p:- (p:expt interest-rate term) 1)
	     (p:- interest-rate 1)))))
