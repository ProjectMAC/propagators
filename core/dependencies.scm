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




(define (v&s-merge v&s1 v&s2)
  (let* ((v&s1-value (v&s-value v&s1))
         (v&s2-value (v&s-value v&s2))
         (value-merge (merge v&s1-value v&s2-value)))
    (cond ((eq? value-merge v&s1-value)
           (if (implies? v&s2-value value-merge)
               ;; Confirmation of existing information
               (if (more-informative-support? v&s2 v&s1)
                   v&s2
                   v&s1)
               ;; New information is not interesting
               v&s1))
          ((eq? value-merge v&s2-value)
           ;; New information overrides old information
           v&s2)
          (else
           ;; Interesting merge, need both provenances
           (supported value-merge
                      (merge-supports v&s1 v&s2))))))

(defhandler merge v&s-merge v&s? v&s?)

(define (implies? v1 v2)
  (eq? v1 (merge v1 v2)))

(defhandler contradictory?
 (lambda (v&s) (contradictory? (v&s-value v&s)))
 v&s?)

(load-compiled "supported-values")(process-examples)




(define (tms-merge tms1 tms2)
  (let ((candidate (tms-assimilate tms1 tms2)))
    (let ((consequence (strongest-consequence candidate)))
      (tms-assimilate candidate consequence))))

;; Not quite this, because we will redefine tms-merge
;; in the next section.  See generic-primitives-3.scm
;; for the real story.
#;
(defhandler merge tms-merge tms? tms?)

(define (tms-assimilate tms stuff)
  (cond ((nothing? stuff) tms)
        ((v&s? stuff) (tms-assimilate-one tms stuff))
        ((tms? stuff)
         (fold-left tms-assimilate-one
                    tms
                    (tms-values stuff)))
        (else (error "This should never happen"))))

(define (subsumes? v&s1 v&s2)
  (and (implies? (v&s-value v&s1) (v&s-value v&s2))
       (lset<= eq? (v&s-support v&s1) (v&s-support v&s2))))

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
    (fold-left merge nothing relevant-v&ss)))

(define (v&s-believed? v&s)
  (all-premises-in? (v&s-support v&s)))

(define (all-premises-in? premise-list)
   (every premise-in? premise-list))

(define (tms-query tms)
  (let ((answer (strongest-consequence tms)))
    (let ((better-tms (tms-assimilate tms answer)))
      (if (not (eq? tms better-tms))
          (set-tms-values! tms (tms-values better-tms)))
      answer)))

(define (kick-out! premise)
  (if (premise-in? premise) (alert-all-propagators!))
  (mark-premise-out! premise))
(define (bring-in! premise)
  (if (not (premise-in? premise)) (alert-all-propagators!))
  (mark-premise-in! premise))

(load-compiled "truth-maintenance")(process-examples)




(define (tms-merge tms1 tms2)
  (let ((candidate (tms-assimilate tms1 tms2)))
    (let ((consequence (strongest-consequence candidate)))
      (check-consistent! consequence)   ; **
      (tms-assimilate candidate consequence))))

;; Not quite this, because we are redefining tms-merge.
;; See generic-primitives-3.scm for the real story.
#;
(defhandler merge tms-merge tms? tms?)

(define (tms-query tms)
  (let ((answer (strongest-consequence tms)))
    (let ((better-tms (tms-assimilate tms answer)))
      (if (not (eq? tms better-tms))
          (set-tms-values! tms (tms-values better-tms)))
      (check-consistent! answer)        ; **
      answer)))

(define (check-consistent! v&s)
  (if (contradictory? v&s)
      (process-nogood! (v&s-support v&s))))

(define (process-nogood! nogood)
  (abort-process `(contradiction ,nogood)))
(process-examples)




(define (binary-amb cell)
  (let ((true-premise (make-hypothetical))
        (false-premise (make-hypothetical)))
    (define (amb-choose)
      (let ((reasons-against-true
             (filter all-premises-in?
               (premise-nogoods true-premise)))
            (reasons-against-false
             (filter all-premises-in?
               (premise-nogoods false-premise))))
        (cond ((null? reasons-against-true)
               (kick-out! false-premise)
               (bring-in! true-premise))
              ((null? reasons-against-false)
               (kick-out! true-premise)
               (bring-in! false-premise))
              (else                     ; this amb must fail.
               (kick-out! true-premise)
               (kick-out! false-premise)
               (process-contradictions
                (pairwise-resolve reasons-against-true
                                  reasons-against-false))))))
    (eq-label! amb-choose 'name 'amb-choose 'outputs (list cell))
    ((constant (make-tms
                (list (supported #t (list true-premise))
                      (supported #f (list false-premise)))))
     cell)
    ;; The cell is a spiritual neighbor...\footnotemark
    (propagator cell amb-choose)))

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

(define (process-one-contradiction nogood)
  (let ((hyps (filter hypothetical? nogood)))
    (if (null? hyps)
        (abort-process `(contradiction ,nogood))
        (begin
          (kick-out! (car hyps))
          (for-each (lambda (premise)
                      (assimilate-nogood! premise nogood))
                    nogood)))))

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
              (lset-difference eq? set subsumed) item))))))

(define (process-nogood! nogood)
  (set! *number-of-calls-to-fail*
        (+ *number-of-calls-to-fail* 1))
  (process-one-contradiction nogood))

(define (require cell)
  ((constant #t) cell))

(define (forbid cell)
  ((constant #f) cell))

(define (require-distinct cells)
  (for-each-distinct-pair
   (lambda (c1 c2)
     (let-cells (p) (=? c1 c2 p) (forbid p)) #;
     (let ((p (make-cell))) (=? c1 c2 p) (forbid p)))
   cells))

(define (one-of values output-cell)
  (let ((cells
         (map (lambda (value)
                (let ((cell (make-cell)))
                  ((constant value) cell)
                  cell))
              values)))
    (one-of-the-cells cells output-cell)))

(define (one-of-the-cells input-cells output-cell)
  (cond ((= (length input-cells) 2)
         (let ((p (make-cell)))
           (conditional p
             (car input-cells) (cadr input-cells)
             output-cell)
           (binary-amb p)))
        ((> (length input-cells) 2)
         (let ((link (make-cell)) (p (make-cell)))
           (one-of-the-cells (cdr input-cells) link)
           (conditional
            p (car input-cells) link output-cell)
           (binary-amb p)))
        (else
         (error "Inadequate choices for one-of-the-cells"
                input-cells output-cell))))

;;; This is a forward reference to conditionals.scm, but it is more
;;; convenient to copy the code than to load that file here.  These
;;; definitions are needed to execute the example in this section.
(define switch
  (function->propagator-constructor
   (nary-unpacking
    (lambda (predicate consequent)
      (if predicate consequent nothing)))))

(define (conditional p if-true if-false output)
  (let ((not-p (make-cell)))
    (inverter p not-p)
    (switch p if-true output)
    (switch not-p if-false output)))(process-examples)
