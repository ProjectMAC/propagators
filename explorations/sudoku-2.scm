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

(load "../../propagator/sets")

(define (singleton-set? thing)
  (and (set? thing)
       (= 1 (length (set->list thing)))))

(define (one-choice? thing)
  (or (integer? thing)
      (and (tms? thing)
	   (not (nothing? (tms-query thing)))
	   (let ((content (v&s-value (tms-query thing))))
	     (or (integer? content)
		 (singleton-set? content))))))

(define (the-one-choice thing)
  (if (integer? thing)
      thing
      (let ((content (v&s-value (tms-query thing))))
	(cond ((singleton-set? content)
	       (car (set->list content)))
	      ((integer? content)
	       content)
	      (else
	       (error "Huh? the-one-choice" thing))))))

(define (one-choice thing)
  thing)

(define (add-set-split! cell size grain)
  (call-with-values
      (lambda ()
	(partition (lambda (n)
		     (< (modulo n (* 2 grain)) grain))
		   (iota size 1)))
    (lambda (in out)
      (one-of (make-set in) (make-set out) cell))))

(define (add-guesser! cell size)
  (let loop ((grain 1))
    (if (>= grain size)
	'done
	(begin (add-set-split! cell size grain)
	       (loop (* 2 grain)))))
  ((constant (make-set (iota size 1))) cell))

----------------------------------------------------------------------

(define (all-different . cells)
  (require-distinct cells))

