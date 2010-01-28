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

(process-examples)

(define generic-cons (make-generic-operator 2 'cons cons))
(define conser
  (function->propagator-constructor (nary-unpacking generic-cons)))

;; This was just an illustration in the text, I don't actually want to
;; run it.
#;
(if (foo?)
    (cons 1 2)
    (cons 3 4))
(process-examples)

(define conser (function->propagator-constructor cons))

(define carer (function->propagator-constructor car))

(define carer (function->propagator-constructor (nary-unpacking car)))

(define (pair-merge pair1 pair2)
  (let ((car-answer (merge (car pair1) (car pair2)))
        (cdr-answer (merge (cdr pair1) (cdr pair2))))
    (cond ((and (eq? (car pair1) car-answer)
                (eq? (cdr pair1) cdr-answer))
           pair1)
          ((and (eq? (car pair2) car-answer)
                (eq? (cdr pair2) cdr-answer))
           pair2)
          (else
           (cons car-answer cdr-answer)))))

(defhandler merge pair-merge pair? pair?)

(process-examples)

;;; This strategy is presented in the text as an alternative to the
;;; preceding.  I choose not to enable it by default.
#|
(define (conser a-cell d-cell output)
  (propagator ()                        ; That's right, no inputs.
    (lambda ()
      (add-content output
        (cons a-cell d-cell)))))

(define (carer cons-cell output)
  (propagator (list cons-cell)
    (lambda ()
      (add-content output
        (content (car (content cons-cell)))))))

(define (carer cons-cell output)
  (propagator (list cons-cell)
    (lambda ()
      (identity (car (content cons-cell)) output))))

(define (identity input output)
  (propagator (list input)
    (lambda ()
      (add-content output (content input)))))

(define (carer cons-cell output)
  (propagator (list cons-cell)
    (lambda ()
      (let* ((best-pair (tms-query (content cons-cell)))
             (transported-cell (car (v&s-value best-pair))))
        ((conditional-identity (v&s-support best-pair))
         transported-cell output)))))

(define ((conditional-identity support) input output)
  (propagator (list input)
    (lambda ()
      (if (all-premises-in? support)
          (add-content output
            (attach-support (tms-query (content input)) support))))))

(define (attach-support v&s more-support)
  (supported
   (v&s-value v&s)
   (lset-union eq? (v&s-support v&s) more-support)))

|#(process-examples)
(process-examples)
