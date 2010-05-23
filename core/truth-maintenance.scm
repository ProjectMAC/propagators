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

(define-structure
  (tms (type vector) (named 'tms)
       (constructor %make-tms) (print-procedure #f)
       (safe-accessors #t))
  values)

(define (make-tms arg)
  (%make-tms (listify arg)))

;; Will be replaced by tms-merge in contradictions.scm
(define (tms-merge tms1 tms2)
  (let ((candidate (tms-assimilate tms1 tms2)))
    (effectful-bind (strongest-consequence candidate)
      (lambda (consequence)
	(tms-assimilate candidate consequence)))))

(define (tms-assimilate tms stuff)
  (cond ((nothing? stuff) tms)
        ((v&s? stuff) (tms-assimilate-one tms stuff))
        ((tms? stuff)
         (fold-left tms-assimilate-one
                    tms
                    (tms-values stuff)))
        (else (error "This should never happen" stuff))))

(define (subsumes? v&s1 v&s2)
  (and (lset<= eq? (v&s-support v&s1) (v&s-support v&s2))
       (implies? (v&s-value v&s1) (v&s-value v&s2))))

(define (tms-assimilate-one tms v&s)
  (if (any (lambda (old-v&s) (subsumes? old-v&s v&s))
           (tms-values tms))
      tms
      (let ((subsumed
             (filter (lambda (old-v&s) (subsumes? v&s old-v&s))
                     (tms-values tms))))
        (make-tms
         (lset-adjoin eq?
           (lset-difference eq? (tms-values tms) subsumed)
           v&s)))))

(define (strongest-consequence tms)
  (let ((relevant-v&ss
         (filter v&s-believed? (tms-values tms))))
    (merge* relevant-v&ss)))

(define (v&s-believed? v&s)
  (all-premises-in? (v&s-support v&s)))

(define (all-premises-in? premise-list)
   (every premise-in? premise-list))

;; Will be replaced by tms-query in contradictions.scm
(define (tms-query tms)
  (let ((answer (strongest-consequence tms)))
    (let ((better-tms (tms-assimilate tms answer)))
      (if (not (eq? tms better-tms))
          (set-tms-values! tms (tms-values better-tms)))
      answer)))

(define (kick-out! premise)
  (if (premise-in? premise)
      (begin
	(set! *worldview-number* (+ *worldview-number* 1))
	(alert-all-propagators!)))
  (mark-premise-out! premise))

(define (bring-in! premise)
  (if (not (premise-in? premise))
      (begin
	(set! *worldview-number* (+ *worldview-number* 1))
	(alert-all-propagators!)))
  (mark-premise-in! premise))

(defhandler generic-unpack
  (lambda (tms function)
    (let ((relevant-information (tms-query tms)))
      (make-tms (list (generic-bind relevant-information function)))))
  tms? any?)

(defhandler generic-flatten
  (lambda (tms)
    (tms->
     (make-tms
      (append-map tms-values
		  (map ->tms
		       (map generic-flatten (tms-values tms)))))))
  tms?)

(defhandler generic-flatten
  (lambda (v&s)
    (generic-flatten
     (make-tms
      (generic-flatten
       (supported (tms-query (v&s-value v&s)) (v&s-support v&s))))))
  (lambda (thing) (and (v&s? thing) (tms? (v&s-value thing)))))

(define (->tms thing)
  (cond ((tms? thing) thing)
        ((nothing? thing) (make-tms '()))
        (else (make-tms (list (->v&s thing))))))

(define (the-tms-handler thing1 thing2)
  (tms-merge thing1 thing2))

(defhandler merge the-tms-handler tms? tms?)
(defhandler merge (coercing ->tms the-tms-handler) tms? v&s?)
(defhandler merge (coercing ->tms the-tms-handler) v&s? tms?)
(defhandler merge (coercing ->tms the-tms-handler) tms? flat?)
(defhandler merge (coercing ->tms the-tms-handler) flat? tms?)

(define (tms-> tms)
  (cond ((null? (tms-values tms))
	 nothing)
	((and (= 1 (length (tms-values tms)))
	      (v&s? (car (tms-values tms)))
	      (null? (v&s-support (car (tms-values tms)))))
	 (v&s-value (car (tms-values tms))))
	(else
	 tms)))
