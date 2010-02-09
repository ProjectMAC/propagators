;;; ----------------------------------------------------------------------
;;; Copyright 2009 Massachusetts Institute of Technology.
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

(declare (usual-integrations make-cell))

(define (->significant-figures places number)
  (define (round-down? digit-trail)
    (or (null? digit-trail)
	(memq (car digit-trail) '(#\0 #\1 #\2 #\3 #\4))
	(and (eq? (car digit-trail) #\.)
	     (or (null? (cdr digit-trail))
		 (memq (cadr digit-trail) '(#\0 #\1 #\2 #\3 #\4))))))
  (define (decimal-increment reversed-digit-list)
    (cond ((null? reversed-digit-list)
	   '(#\1))
	  ((eq? (car reversed-digit-list) #\.)
	   (cons (car reversed-digit-list)
		 (decimal-increment (cdr reversed-digit-list))))
	  ((eq? (car reversed-digit-list) #\9)
	   (cons #\0 (decimal-increment (cdr reversed-digit-list))))
	  (else 
	   (cons (integer->char (+ 1 (char->integer (car reversed-digit-list))))
		 (cdr reversed-digit-list)))))
  (let ((digits (string->list (number->string number))))
    (let loop ((result '())
	       (more-digits digits)
	       (places places)
	       (zeros-matter? #f))
      (cond ((null? more-digits)
	     (string->number (list->string (reverse result))))
	    ;; TODO This relies on being after the decimal point
	    ((= places 0)
	     (string->number
	      (list->string
	       (reverse
		(if (round-down? more-digits)
		    result
		    (decimal-increment result))))))
	    ((eq? #\. (car more-digits))
	     (loop (cons (car more-digits) result)
		   (cdr more-digits)
		   places
		   zeros-matter?))
	    ((eq? #\0 (car more-digits))
	     (loop (cons (car more-digits) result)
		   (cdr more-digits)
		   (if zeros-matter? (- places 1) places)
		   zeros-matter?))
	    (else
	     (loop (cons (car more-digits) result)
		   (cdr more-digits)
		   (- places 1)
		   #t))))))

(define-method generic-match ((pattern <vector>) (object <vector>))
  (reduce boolean/and #t (map generic-match
			      (vector->list pattern)
			      (vector->list object))))

(define-method generic-match ((pattern <pair>) (object <pair>))
  (and (generic-match (car pattern) (car object))
       (generic-match (cdr pattern) (cdr object))))

(define-method generic-match ((pattern <inexact>) (object <inexact>))
  (or (= pattern object)
      (= pattern (->significant-figures 5 object))))