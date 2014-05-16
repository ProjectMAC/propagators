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

(define (hypothetical-printer state object)
  (with-current-unparser-state state
    (lambda (port)
      (write `(hypothetical
	       ,(hash object)
	       ,(hypothetical-sign object)
	       ,(if (premise-in? object) 'in 'out)
	       ,@(name-stack (hypothetical-cell object)))
	  port))))

(define-structure
  (hypothetical (type vector) (named 'hypothetical)
                (constructor %make-hypothetical)
                ;;(print-procedure #f)
		(print-procedure hypothetical-printer)
		(safe-accessors #t))
  index
  sign
  cell)

(define *hypothetical-count* 0)

(define initialize-scheduler
  (let ((initialize-scheduler initialize-scheduler))
    (lambda ()
      (initialize-scheduler)
      (set! *hypothetical-count* 0))))

(define with-independent-scheduler
  (let ((with-independent-scheduler with-independent-scheduler))
    (lambda args
      (fluid-let ((*hypothetical-count* 0)) ; TODO Is this right?
	(apply with-independent-scheduler args)))))

(define (make-hypothetical sign cell)
  (set! *hypothetical-count* (+ *hypothetical-count* 1))
  (%make-hypothetical *hypothetical-count* sign cell))

(define (premise<? p1 p2)
  (cond ((and (symbol? p1) (symbol? p2))
         (symbol<? p1 p2))
        ((symbol? p1) p2)
        ((symbol? p2) p1)
        (else (< (hypothetical-index p1) (hypothetical-index p2)))))

;; Made by initial agent.
;;(define *premise-outness* (make-eq-hash-table))  

;; (define (premise-in? premise)
;;   (not (hash-table/get *premise-outness* premise #f)))

;; (define (mark-premise-in! premise)
;;   (hash-table/remove! *premise-outness* premise))

;; (define (mark-premise-out! premise)
;;   (hash-table/put! *premise-outness* premise #t))



(define *premise-nogoods* (make-eq-hash-table))

(define (premise-nogoods premise)
  (hash-table/get *premise-nogoods* premise '()))

(define (set-premise-nogoods! premise nogoods)
  (hash-table/put! *premise-nogoods* premise nogoods))


;;; defined in agent.scm
;;; (define *worldview-number* 0)

(define (reset-premise-info!)
  (set! *worldview-number* 0)
  ;; (set! *premise-outness* (make-eq-hash-table))
  (set! *premise-nogoods* (make-eq-hash-table)))

;;; We also need to arrange for the premise states to be reset for
;;; every new example.  Better creativity having failed me, I will
;;; hang that action onto the initialize-scheduler procedure.
;;; TODO Can one do better than redefining initialize-scheduler?
(define initialize-scheduler
  (let ((initialize-scheduler initialize-scheduler))
    (lambda ()
      (initialize-scheduler)
      (reset-premise-info!))))

(define with-independent-scheduler
  (let ((with-independent-scheduler with-independent-scheduler))
    (lambda args
      (fluid-let ((*worldview-number* *worldview-number*)
		  ;;(*premise-outness* #f)
		  (*premise-nogoods* #f))
	(apply with-independent-scheduler args)))))

(define (disbelieving-func premise thunk)
  (let ((old-belief (premise-in? premise)))
    (kick-out! premise)
    (let ((answer (thunk)))
      (if old-belief
	  (bring-in! premise)
	  (kick-out! premise))
      answer)))

;; (disbelieving premise body)
;;   Syntax that executes the given body in a dynamic environment
;;   where the given premise is not believed.
(define-syntax disbelieving
  (syntax-rules ()
    ((_ premise body ...)
     (disbelieving-func premise (lambda () body ...)))))
