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

(declare (usual-integrations make-cell cell?))


(define (for-each-distinct-pair proc lst)
  (if (not (null? lst))
      (let loop ((first (car lst)) (rest (cdr lst)))
        (for-each (lambda (other-element)
                    (proc first other-element))
                  rest)
        (if (not (null? rest))
            (loop (car rest) (cdr rest))))))

(define (sort-by lst compute-key)
  (map cdr
       (sort (map (lambda (thing)
                    (cons (compute-key thing) thing))
                  lst)
             (lambda (pair1 pair2)
               (< (car pair1) (car pair2))))))

(define (listify object)
  (cond ((null? object) object)
        ((pair? object) object)
        (else (list object))))

(define (walker->mapper walker)
  (lambda (proc . rest)
    (let ((result '()))
      (apply
       walker
       (lambda args
	 (let ((value (apply proc args)))
	   (set! result (cons value result))))
       rest)
      (reverse result))))

(define (identity x) x)

(define (ignore-first x y) y)

(define (default-equal? x y)
  (if (and (number? x) (number? y))
      (close-enuf? x y 1e-10)
      (equal? x y)))

(define (close-enuf? h1 h2 #!optional tolerance scale)
  (if (default-object? tolerance)
      (set! tolerance *machine-epsilon*))
  (if (default-object? scale)
      (set! scale 1.0))
  (<= (magnitude (- h1 h2))
      (* tolerance
         (+ (* 0.5
               (+ (magnitude h1) (magnitude h2)))
            scale))))

(define *machine-epsilon*
  (let loop ((e 1.0))
     (if (= 1.0 (+ e 1.0))
         (* 2 e)
         (loop (/ e 2)))))

(define (string-replace string pattern replacement)
  (let loop ((string string)
	     (first-occurrence (string-search-forward pattern string)))
    (if first-occurrence
	(let ((next-string
	       (string-append
		(string-head string first-occurrence)
		replacement
		(string-tail string (+ first-occurrence (string-length pattern))))))
	  (loop next-string
		(substring-search-forward
		 pattern next-string
		 (+ first-occurrence (string-length replacement)) (string-length next-string))))
	string)))

(define (maybe-warn-low-memory)
  (let ((mem (gc-flip)))
    (if (< mem 500000)
	(begin (warn (string-append "The available heap looks kind of small at " (write-to-string mem) " words"))
	       (warn "Are you running Scheme with the default heap size?")
	       (warn "Try, say, --heap 6000 if you run out of memory")))))

(define (name thing)
  (let ((name-property (eq-get thing 'name)))
    (if name-property
	(name name-property)
	thing)))

(define (name! thing name)
  (eq-put! thing 'name name))

(define make-generic-operator
  (let ((make-generic-operator make-generic-operator))
    (named-lambda (make-generic-operator arity #!optional name default-operation)
      (let ((answer (make-generic-operator arity name default-operation)))
	(if (default-object? name)
	    answer
	    (name! answer name))))))
