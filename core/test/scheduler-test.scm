;;; ----------------------------------------------------------------------
;;; Copyright 2010 Alexey Radul
;;; ----------------------------------------------------------------------
;;; This file is part of Propagator Network Prototype.
;;; 
;;; Propagator Network Prototype is free software; you can
;;; redistribute it and/or modify it under the terms of the GNU
;;; General Public License as published by the Free Software
;;; Foundation, either version 3 of the License, or (at your option)
;;; any later version.
;;; 
;;; Propagator Network Prototype is distributed in the hope that it
;;; will be useful, but WITHOUT ANY WARRANTY; without even the implied
;;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;;; See the GNU General Public License for more details.
;;; 
;;; You should have received a copy of the GNU General Public License
;;; along with Propagator Network Prototype.  If not, see
;;; <http://www.gnu.org/licenses/>.
;;; ----------------------------------------------------------------------

(in-test-group
 scheduler

 (define-test (smoke)
   (let ((run-count 0))
     (define (run-me)
       (set! run-count (+ run-count 1)))
     (initialize-scheduler)
     (check (= 0 (length (all-propagators))))
     (check (= 0 run-count))
     (alert-propagators run-me)
     (check (= 1 (length (all-propagators))))
     (run)
     (check (= 1 run-count))
     (check (= 1 (length (all-propagators)))))))
