;;; ----------------------------------------------------------------------
;;; Copyright 2013 Massachusetts Institute of Technology.
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

;;;; Deques

(declare (usual-integrations))

(define-record-type deque
    (deque:make-record front rear)
    deque?
  (front deque:front deque:set-front!)
  (rear  deque:rear  deque:set-rear!))

(define (deque:make)
  (deque:make-record #f #f))


(define-record-type triple
    (triple:make-record item reverse forward)
    triple?
  (item triple:item triple:set-item!)
  (reverse triple:reverse triple:set-reverse!)
  (forward triple:forward triple:set-forward!))

(define (triple:make item)
  (triple:make-record item #f #f))


(define (deque:empty? deque)
  (not (deque:front deque)))

(define (deque:add-to-front! deque item)
  (let ((new-entry (triple:make item)))
    (if (deque:empty? deque)
	(begin (deque:set-front! deque new-entry)
	       (deque:set-rear! deque new-entry))
	(begin
	  (triple:set-forward! new-entry (deque:front deque))
	  (triple:set-reverse! (deque:front deque) new-entry)
	  (deque:set-front! deque new-entry)))))

(define (deque:add-to-rear! deque item)
  (let ((new-entry (triple:make item)))
    (if (deque:empty? deque)
	(begin (deque:set-front! deque new-entry)
	       (deque:set-rear! deque new-entry))
	(begin
	  (triple:set-reverse! new-entry (deque:rear deque))
	  (triple:set-forward! (deque:rear deque) new-entry)
	  (deque:set-rear! deque new-entry)))))

(define deque:empty-value (list 'deque:empty-value))

(define (deque:empty-value? x)
  (eq? x deque:empty-value))

(define (deque:first deque)
  (if (deque:empty? deque)
      deque:empty-value
      (triple:item (deque:front deque))))

(define (deque:last deque)
  (if (deque:empty? deque)
      deque:empty-value
      (triple:item (deque:rear deque))))

(define (deque:remove-first! deque)
  (cond ((deque:empty? deque)
	 (error "Deque empty -- REMOVE-FIRST"))
	((eq? (deque:front deque) (deque:rear deque))
	 (deque:set-front! deque #f)
	 (deque:set-rear! deque #f))
	(else
	 (deque:set-front! deque
		(triple:forward (deque:front deque)))
	 (triple:set-reverse! (deque:front deque) #f))))

(define (deque:remove-last! deque)
  (cond ((deque:empty? deque)
	 (error "Deque empty -- REMOVE-LAST"))
	((eq? (deque:front deque) (deque:rear deque))
	 (deque:set-front! deque #f)
	 (deque:set-rear! deque #f))
	(else
	 (deque:set-rear! deque
                (triple:reverse (deque:rear deque)))
	 (triple:set-forward! (deque:rear deque) #f))))

;;; Is the object x in the deque?

(define (deque:in? x deque)
  (and (not (deque:empty? deque))
       (let lp ((triple (deque:front deque)))
         (and triple
              (or (eq? x (triple:item triple))
                  (lp (triple:forward triple)))))))


;;; Get a list of all items in the deque

(define (deque:all deque)
  (if (deque:empty? deque)
      '()
      (let lp ((triple (deque:rear deque)) (elts '()))
        (if (not triple)
	    elts
            (lp (triple:reverse triple)
		(cons (triple:item triple) elts))))))

#|
;;; Test cases

(define foo (deque:make))

(deque:add-to-front! foo 'b)

(deque:add-to-front! foo 'a)

(deque:add-to-rear! foo 'c)

(deque:add-to-rear! foo 'd)


(deque:front foo)
;Value #[triple 19]

(triple:item (deque:front foo))
;Value: a

(triple:forward (deque:front foo))
;Value #[triple 20]

(triple:reverse (deque:front foo))
;Value: #f


(triple:item (triple:forward (deque:front foo)))
;Value: b

(triple:forward (triple:forward (deque:front foo)))
;Value #[triple 21]

(triple:reverse (triple:forward (deque:front foo)))
;Value: #[triple 19]


(triple:item (triple:forward (triple:forward (deque:front foo))))
;Value: c

(triple:forward (triple:forward (triple:forward (deque:front foo))))
;Value: #[triple 22]

(triple:reverse (triple:forward (triple:forward (deque:front foo))))
;Value: #[triple 20]


(triple:item (triple:forward (triple:forward (triple:forward (deque:front foo)))))
;Value: d

(triple:forward (triple:forward (triple:forward (triple:forward (deque:front foo)))))
;Value: #f

(triple:reverse (triple:forward (triple:forward (triple:forward (deque:front foo)))))
;Value: #[triple 21]


(deque:rear foo)
;Value: #[triple 22]

;;; So structure looks good

(deque:all foo)
;Value: (a b c d)

(deque:in? 'b foo)
;Value: #t

(deque:in? 'e foo)
;Value: #f

(deque:first foo)
;Value: a

(deque:last foo)
;Value: d

(deque:remove-first! foo)

(deque:first foo)
;Value: b

(deque:remove-last! foo)

(deque:last foo)
;Value: c

(deque:all foo)
;Value (b c)

(deque:remove-last! foo)

(deque:all foo)
;Value (b)

(deque:first foo)
;Value: b

(deque:last foo)
;Value: b

(deque:remove-first! foo)

(deque:empty? foo)
;Value: #t

(deque:all foo)
;Value: ()

(deque:add-to-rear! foo 'e)

(deque:all foo)
;Value: (e)
|#


