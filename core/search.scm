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

(define *false-premise-starts-out* #t)

;;; If *avoid-false-true-flips* is set to #f, amb-choose maintains a
;;; stronger invariant than the one it is meant to maintain; namely,
;;; that the true-premise is always in if it can be, and the
;;; false-premise is in only if the true-premise is contradicted.
;;; Enforcing this stronger invariant has the disadvantage that it may
;;; cause additional flipping of the states of hypotheticals, which in
;;; turn is likely to cause significant additional (re-)computation.
(define *avoid-false-true-flips* #t)

(define (binary-amb cell #!optional bias)
  (let ((true-premise (make-hypothetical 'true cell))
        (false-premise (make-hypothetical 'false cell)))
    ;; The job of amb-choose is to maintain the invariant that at
    ;; least one of true-premise and false-premise is in.  This
    ;; invariant may be broken because the rest of the system very
    ;; vigorously maintains the invariant that no known nogood set is
    ;; ever fully in.  This is done by kicking some offending
    ;; hypothetical out, possibly breaking amb-choose's invariant.
    ;; (Note: true-premise and false-premise support contradictory
    ;; conclusions, so they will not both be in except momentarily).
    (define (amb-choose)
      (if (and *avoid-false-true-flips*
           (or (premise-in? true-premise)
           (premise-in? false-premise)))
      'ok ; the some-premise-is-in invariant holds
      (let ((reasons-against-true
         (filter (lambda (nogood)
               (and (all-premises-in? nogood)
                (not (member false-premise nogood))))
             (premise-nogoods true-premise)))
        (reasons-against-false
         (filter (lambda (nogood)
               (and (all-premises-in? nogood)
                (not (member true-premise nogood))))
             (premise-nogoods false-premise))))
        (cond ((or 
                (null? reasons-against-true)
                (not (or
                      *avoid-false-true-flips*
                      (ultimately-supported? false-premise)))) ; <-- make contradiction someone else's problem!
           (if *contradiction-wallp* 
               (pp `(asserting-true ,true-premise
                        ,false-premise
                        ,cell)))
           (kick-out! false-premise)
           (bring-in! true-premise))
          ((null? reasons-against-false)
           (if *contradiction-wallp* 
               (pp `(asserting-false ,true-premise
                         ,false-premise
                         ,cell)))
           (kick-out! true-premise)
           (bring-in! false-premise))
          (else         ; this amb must fail.
           (if *contradiction-wallp* 
               (pp `(amb-fail ,true-premise ,false-premise ,cell)))
           (kick-out! true-premise)
           (kick-out! false-premise)
           (process-contradictions
            (pairwise-resolve reasons-against-true
                      reasons-against-false)))))))

    (eq-put! true-premise 'opposite false-premise)
    (eq-put! false-premise 'opposite true-premise)
    (name! amb-choose 'amb-choose)
    ;; This only affects run order, and only in some experimental
    ;; schedulers
    (tag-slow! amb-choose)
    
    (if (default-object? bias)
        (if *false-premise-starts-out*
            ;; Let's have the false premise start unbelieved.
            (mark-premise-out! false-premise))
        (begin (eq-put! true-premise 'bias bias)
               (eq-put! false-premise 'bias (- 1.0 bias))
               (if (> bias 0.5)
                   (mark-premise-out! false-premise)
                   (mark-premise-out! true-premise))))
    
    ;; The cell is a spiritual neighbor...
    (propagator cell amb-choose)

    (let ((diagram
           (make-anonymous-i/o-diagram amb-choose '() (list cell))))
      ((constant (make-tms
                  (list (supported #t (list true-premise) (list diagram))
                        (supported #f (list false-premise) (list diagram)))))
       cell)
      (register-diagram diagram)
      diagram)))

(define (pairwise-resolve nogoods1 nogoods2)
  (append-map (lambda (nogood1)
                (map (lambda (nogood2)
                       (lset-union eq? nogood1 nogood2))
                     nogoods2))
              nogoods1))

(define (process-contradictions nogoods)
  (process-one-contradiction
   (car (sort-by nogoods
          (lambda (nogood)
            (length (filter hypothetical? nogood)))))))
;;; (... innit odd that the above doesn't sort but process-nogood! does??) ;;;

;;; 
(define (default-premise? premise) ;;;
  (eq-get premise 'default-premise))

(define *deferred-contradictions* '()) ;;;

(define (defer-contradiction nogood) ;;;
  (set! *deferred-contradictions*  
		(lset-adjoin equal? *deferred-contradictions* nogood)))

(define *defer-all-default-contradictions* #t) ;;;
(define *default-contradiction-second-pass* #f) ;;;

(define (process-deferred-contradictions) ;;; ; not well tested!
  (set! *deferred-contradictions*
        (filter all-premises-in? *deferred-contradictions*))
  (if (pair? *deferred-contradictions*) ;;; this branch not well tested
      (let ((nogood (car *deferred-contradictions*)))
        (if *contradiction-wallp* (pp 'handling-deferred-contradiction))
        (set! *deferred-contradictions* (cdr *deferred-contradictions*))
        (fluid-let ((*defer-all-default-contradictions* #f)
                    (*default-contradiction-second-pass* #t))
          (process-one-contradiction nogood))
        (run))
      *last-value-of-run*))
;; this may not be the last word? e.g. due to nogoods already
;; assimilated change of worldview or other effects may trigger amb
;; recomp which may fix contradictions without having to go through
;; this path... or may reenter deferral presumably idempotently...
;; not sure if perhaps the nogood effect alone on amb execution is
;; enough to drive endless ping-pong. may have such a case.
;; we shall see.

(define run ;;;
  (let ((run run))
    (lambda ()
      (run)
      (process-deferred-contradictions))))


(define (process-one-contradiction nogood)
  (if *contradiction-wallp* (pp `(nogood ,@nogood)))
  (let ((hyps (filter hypothetical? nogood))
        (cwd (any default-premise? nogood))) ;;;
    (if (or (null? hyps) (and cwd *defer-all-default-contradictions*)) ;;
        (if (and cwd (not *default-contradiction-second-pass*))
            (begin
              (if *contradiction-wallp* (pp `(contradiction-with-defaults ,nogood)))
              (defer-contradiction nogood)) ;;;
            (begin
              (if *contradiction-wallp* (pp 'nogood-aborted))
              (abort-process `(contradiction ,nogood))))
        (let ((culprit (choose-culprit hyps)))
          (if *contradiction-wallp*
              (pp `(kicking-out ,culprit)))
          (kick-out! culprit)
          (for-each (lambda (premise)
                      (assimilate-nogood! premise nogood))
                    nogood)))))

;;; (define choose-culprit car)
;;; If no biases are available this defaults to car

(define (choose-culprit hyps)
  (define (get-bias hyp)
    (or (eq-get hyp 'bias) 0.5))
  (if (null? hyps)
      (error "Hard to choose from nothing")
      (reduce (lambda (hyp1 hyp2)
                (if (< (get-bias hyp1) (get-bias hyp2))
                    hyp1 hyp2))
              #f hyps)))  

(define (assimilate-nogood! premise new-nogood)
  (let ((item (delq premise new-nogood))
        (set (premise-nogoods premise)))
    (if (any (lambda (old) (lset<= eq? old item)) set)
        #f
        (let ((subsumed
               (filter (lambda (old) (lset<= eq? item old))
                       set)))
          (set-premise-nogoods! premise
            (lset-adjoin eq?
              (lset-difference eq? set subsumed)
	      item))))))


(define *number-of-calls-to-fail* 0)

(define initialize-scheduler
  (let ((initialize-scheduler initialize-scheduler))
    (lambda ()
      (initialize-scheduler)
	  (set! *deferred-contradictions* '())
      (set! *number-of-calls-to-fail* 0))))

(define with-independent-scheduler
  (let ((with-independent-scheduler with-independent-scheduler))
    (lambda args
      (fluid-let ((*number-of-calls-to-fail* #f))
	(apply with-independent-scheduler args)))))


(define *contradiction-wallp* #f)

(define (process-nogood! nogood)
  (set! *number-of-calls-to-fail*
        (+ *number-of-calls-to-fail* 1))
  (process-one-contradiction (sort nogood premise<?)))


;;;;;;;;;;;;;;;;;;;;;


(define (hypothetical-support hyp)
  (filter all-premises-in?
          (premise-nogoods (eq-get hyp 'opposite))))

(define (default-hypothetical? hyp)
  (and 
   (hypothetical? hyp)
   (not *avoid-false-true-flips*)
   (eq? (hypothetical-sign hyp) 'true))) ; <-- hard-coded :P

(define (ultimately-supported? hyp #!optional include-defaults visited-hyps)
  (if (default-object? visited-hyps)
      (set! visited-hyps '()))

  (define (visited? hypothetical)
    (memq hypothetical visited-hyps))
  (define (visitable? support)
    (not (any visited? support)))

  (let ((next-support (filter visitable? 
                              (hypothetical-support hyp)))
        (self-support (and include-defaults (default-hypothetical? hyp))))
    (or
     self-support
     (any (lambda (support)
            (every (lambda (premise)
                     (or (not (hypothetical? premise))
                         (ultimately-supported? premise include-defaults
                                                (cons hyp visited-hyps))))
                   support))
          next-support))))

