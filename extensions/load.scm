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

(define (self-relatively thunk)
  (if (current-eval-unit #f)
      (with-working-directory-pathname
       (directory-namestring (current-load-pathname))
       thunk)
      (thunk)))

(define (load-relative filename)
  (self-relatively (lambda () (load filename))))

(load-relative "../core/load.scm")

(define *virtual-copies* #f)

(define (maybe thing bool)
  (if bool
      (list thing)
      '()))

(for-each load-relative-compiled
 `(,@(maybe "environments" *virtual-copies*)
   ,@(maybe "closures" *virtual-copies*)
   "info-alist"
   "algebraic-tms"
   "electric-parts"
   "solve"
   "inequalities"
   "symbolics"
   "symbolics-ineq"
   "functional-reactivity"
   "test-utils"))

(for-each load-relative
 `(,@(maybe "physical-closures" (not *virtual-copies*))
   "carrying-cells"
   "physical-copies"
   ,@(maybe "example-closures" *virtual-copies*)
   "draw"
   "dot-writer"
   "graphml-writer"))

(maybe-warn-low-memory)
(initialize-scheduler)
