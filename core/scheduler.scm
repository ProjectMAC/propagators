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

;;;; Basic scheduling system

;;; This scheduler maintains a list of jobs that need to be run.  Each
;;; job is a thunk.  Jobs are run serially and are not preempted.
;;; When a job exits (normally) it is forgotten and the next job is
;;; run.  The jobs are permitted to schedule additional jobs,
;;; including rescheduling themselves.  Jobs are presumed idempotent,
;;; and specifically it is assumed acceptable not to count how many
;;; times a given job (by eq?-ness) was scheduled, but merely that it
;;; was scheduled.  When the scheduler runs out of jobs, it returns
;;; the symbol 'done to its caller.

;;; The scheduler supplies an escape mechanism: running the procedure
;;; abort-process, with a value, will terminate the entire job run,
;;; and return the supplied value to the scheduler's caller.
;;; Subsequent calls to the scheduler without first scheduling more
;;; jobs will also return that same value.  If abort-process is called
;;; outside the dynamic extent of a run, it deschedules any jobs that
;;; might be scheduled and saves the value for future reference as
;;; above.

;;; This scheduler is meant as a low-level support for the propagator
;;; network in this dissertation.  In that use case, the jobs would be
;;; propagators that the network knows need to be run.  Any cells in
;;; the network are invisible to the scheduler, but presumably help
;;; the network schedule more propagators to run (namely those that
;;; may be interested in the cell's goings on).

;;; The public interface is
;;;   (initialize-scheduler)      clear all scheduler state
;;;   (alert-propagators jobs)    schedule a list (or set) of jobs
;;;   (alert-all-propagators!)    reschedule all jobs ever scheduled
;;;   (run)                       run scheduled jobs until done
;;;   (abort-process x)           terminate the run returning x

(define *alerted-propagators*)
(define *alerted-propagator-list*)
(define *abort-process*)
(define *last-value-of-run*)
(define *propagators-ever-alerted*)
(define *propagators-ever-alerted-list*)

(define (initialize-scheduler)
  (clear-alerted-propagators!)
  (set! *abort-process* #f)
  (set! *last-value-of-run* 'done)
  (set! *propagators-ever-alerted* (make-eq-hash-table))
  (set! *propagators-ever-alerted-list*
        (list '*propagators-ever-alerted-list*))
  'ok)

(define (any-propagators-alerted?)
  (< 0 (hash-table/count *alerted-propagators*)))

(define (clear-alerted-propagators!)
  (set! *alerted-propagators* (make-strong-eq-hash-table))
  (set! *alerted-propagator-list* (list '*alerted-propagator-list*)))

;; Turning this off makes the order in which propagators are run vary
;; chaotically.  That is not supposed to cause trouble in principle,
;; but a reproducible run order can be valuable for debugging the
;; infrastructure.  The chaotic variation also causes variations in the 
;; *number-of-calls-to-fail* when doing dependency directed backtracking.
(define *reproducible-run-order* #t)

(define (order-preserving-insert thing table lst)
  (hash-table/lookup
   table
   thing
   (lambda (value) 'ok)
   (lambda ()
     (hash-table/put! table thing #t)
     (push! lst thing))))

(define (push! headed-list thing)
  (set-cdr! headed-list (cons thing (cdr headed-list))))

(define (ordered-key-list table lst)
  (if *reproducible-run-order*
      (list-copy (cdr lst))
      (hash-table/key-list table)))

(define (alert-propagators propagators)
  (for-each
   (lambda (propagator)
     (if (not (procedure? propagator))
         (error "Alerting a non-procedure" propagator))
     (order-preserving-insert
      propagator *propagators-ever-alerted* *propagators-ever-alerted-list*)
     (order-preserving-insert
      propagator *alerted-propagators* *alerted-propagator-list*))
   (listify propagators))
  #f)
(define alert-propagator alert-propagators)

(define (all-propagators)
  (ordered-key-list *propagators-ever-alerted*
		    *propagators-ever-alerted-list*))

(define (alert-all-propagators!)
  (alert-propagators (all-propagators)))

(define (the-alerted-propagators)
  (ordered-key-list *alerted-propagators*
                    *alerted-propagator-list*))

(define (with-process-abortion thunk)
  (call-with-current-continuation
   (lambda (k)
     (fluid-let ((*abort-process* k))
       (thunk)))))

(define termination-trace #f)

(define (abort-process value)
  (if termination-trace
      (ppc `(calling abort-process with ,value and ,*abort-process*)))
  (if *abort-process*
      ;; if the propagator is running
      (begin (clear-alerted-propagators!)
             (*abort-process* value))
      ;; if the user is setting up state
      (begin (clear-alerted-propagators!)
             (set! *last-value-of-run* value))))

(define (run-alerted)
  (let ((temp (the-alerted-propagators)))
    (clear-alerted-propagators!)
    (for-each (lambda (propagator)
                (propagator))
              temp))
  (if (any-propagators-alerted?)
      (run-alerted)
      'done))

(define (run)
  (if (any-propagators-alerted?)
      (set! *last-value-of-run* (with-process-abortion run-alerted)))
  *last-value-of-run*)
