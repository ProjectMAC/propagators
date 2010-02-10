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
 small-networks


 (define-test (one-heron-step)
   (interaction
    (initialize-scheduler)
    (define-cell x)
    (define-cell guess)
    (define-cell better-guess)

    (heron-step x guess better-guess)

    (add-content x 2)
    (add-content guess 1.4)
    (run)
    (content better-guess)
    (produces 1.4142857142857141)
    ))

 (define-test (sqrt)
   (interaction
    (initialize-scheduler)
    (define-cell x)
    (define-cell answer)

    (sqrt-network x answer)

    (add-content x 2)
    (run)
    (content answer)
    (produces 1.4142135623746899)
    ))

 (define-test (multiple-dwelling)
   (interaction
    (initialize-scheduler)
    (define answers (multiple-dwelling))
    (run)
    (map v&s-value (map tms-query (map content answers)))
    (produces '(3 2 4 5 1))

    *number-of-calls-to-fail*
    (produces 63)
    ))
 
 )
