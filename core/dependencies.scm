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

(interactive-example

(initialize-scheduler)
(define barometer-height (make-cell))
(define barometer-shadow (make-cell))
(define building-height (make-cell))
(define building-shadow (make-cell))
(similar-triangles barometer-shadow barometer-height
                   building-shadow building-height)

(add-content building-shadow
 (supported (make-interval 54.9 55.1) '(shadows)))
(add-content barometer-height
 (supported (make-interval 0.3 0.32) '(shadows)))
(add-content barometer-shadow
 (supported (make-interval 0.36 0.37) '(shadows)))
(run)
(content building-height)
=> #(supported #(interval 44.514 48.978) (shadows))

(define fall-time (make-cell))
(fall-duration fall-time building-height)

(add-content fall-time
 (supported (make-interval 2.9 3.3) '(lousy-fall-time)))
(run)
(content building-height)
=> #(supported #(interval 44.514 48.978) (shadows))

(add-content fall-time
 (supported (make-interval 2.9 3.1) '(better-fall-time)))
(run)
(content building-height)
=> #(supported #(interval 44.514 47.243)
            (better-fall-time shadows))

(add-content building-height (supported 45 '(superintendent)))
(run)
(content building-height)
=> #(supported 45 (superintendent))

(content barometer-height)
=> #(supported #(interval .3 .30328)
            (superintendent better-fall-time shadows))

(content barometer-shadow)
=> #(supported #(interval .366 .37)
            (better-fall-time superintendent shadows))

(content building-shadow)
=> #(supported #(interval 54.9 55.1) (shadows))

(content fall-time)
=> #(supported #(interval 3.0255 3.0322)
            (shadows superintendent))
)


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

(interactive-example

(initialize-scheduler)
(define barometer-height (make-cell))
(define barometer-shadow (make-cell))
(define building-height (make-cell))
(define building-shadow (make-cell))
(similar-triangles barometer-shadow barometer-height
                   building-shadow building-height)

(add-content building-shadow
 (make-tms (supported (make-interval 54.9 55.1) '(shadows))))
(add-content barometer-height
 (make-tms (supported (make-interval 0.3 0.32) '(shadows))))
(add-content barometer-shadow
 (make-tms (supported (make-interval 0.36 0.37) '(shadows))))
(run)
(content building-height)
=> #(tms (#(supported #(interval 44.514 48.978) (shadows))))

(define fall-time (make-cell))
(fall-duration fall-time building-height)

(add-content fall-time
 (make-tms (supported (make-interval 2.9 3.1) '(fall-time))))
(run)
(content building-height)
=> #(tms (#(supported #(interval 44.514 47.243)
                   (shadows fall-time))
       #(supported #(interval 44.514 48.978)
                   (shadows))))

(tms-query (content building-height))
=> #(supported #(interval 44.514 47.243) (shadows fall-time))

(kick-out! 'fall-time)
(run)
(tms-query (content building-height))
=> #(supported #(interval 44.514 48.978) (shadows))

(kick-out! 'shadows)
(run)
(tms-query (content building-height))
=> #(*the-nothing*)

(bring-in! 'fall-time)
(run)
(tms-query (content building-height))
=> #(supported #(interval 41.163 47.243) (fall-time))

(content building-height)
=> #(tms (#(supported #(interval 41.163 47.243)
                   (fall-time))
       #(supported #(interval 44.514 47.243)
                   (shadows fall-time))
       #(supported #(interval 44.514 48.978)
                   (shadows))))

(add-content building-height (supported 45 '(superintendent)))

(run)
(content building-height)
=> #(tms (#(supported 45 (superintendent))
       #(supported #(interval 41.163 47.243)
                   (fall-time))
       #(supported #(interval 44.514 47.243)
                   (shadows fall-time))
       #(supported #(interval 44.514 48.978)
                   (shadows))))

(tms-query (content building-height))
=> #(supported 45 (superintendent))

(bring-in! 'shadows)
(run)
(tms-query (content building-height))
=> #(supported 45 (superintendent))

(content barometer-height)
=> #(tms (#(supported #(interval .3 .30328)
                   (fall-time superintendent shadows))
       #(supported #(interval .29401 .30328)
                   (superintendent shadows))
       #(supported #(interval .3 .31839)
                   (fall-time shadows))
       #(supported #(interval .3 .32) (shadows))))


(tms-query (content barometer-height))
=> #(supported #(interval .3 .30328)
            (fall-time superintendent shadows))

(kick-out! 'fall-time)
(run)
(tms-query (content barometer-height))
=> #(supported #(interval .3 .30328) (superintendent shadows))

(bring-in! 'fall-time)
(run)
(tms-query (content barometer-height))
=> #(supported #(interval .3 .30328) (superintendent shadows))

(content barometer-height)
=> #(tms (#(supported #(interval .3 .30328)
                   (superintendent shadows))
       #(supported #(interval .3 .31839)
                   (fall-time shadows))
       #(supported #(interval .3 .32) (shadows))))
)


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

(interactive-example

;;; Restore the state we had in the preceding example
(initialize-scheduler)
(define barometer-height (make-cell))
(define barometer-shadow (make-cell))
(define building-height (make-cell))
(define building-shadow (make-cell))
(similar-triangles barometer-shadow barometer-height
                   building-shadow building-height)

(add-content building-shadow
 (make-tms (supported (make-interval 54.9 55.1) '(shadows))))
(add-content barometer-height
 (make-tms (supported (make-interval 0.3 0.32) '(shadows))))
(add-content barometer-shadow
 (make-tms (supported (make-interval 0.36 0.37) '(shadows))))

(define fall-time (make-cell))
(fall-duration fall-time building-height)

(add-content fall-time
 (make-tms (supported (make-interval 2.9 3.1) '(fall-time))))
(run)
(tms-query (content building-height))

(kick-out! 'fall-time)
(run)
(tms-query (content building-height))

(bring-in! 'fall-time)
(kick-out! 'shadows)
(run)
(tms-query (content building-height))

(add-content building-height (supported 45 '(superintendent)))
(run)
(bring-in! 'shadows)
(run)
(tms-query (content building-height))

(tms-query (content barometer-height))
(kick-out! 'fall-time)
(run)
(tms-query (content barometer-height))
(bring-in! 'fall-time)
(run)
(tms-query (content barometer-height))
;;; That was a long story!
(add-content building-height
  (supported (make-interval 46. 50.) '(pressure)))
(run)
=> (contradiction (superintendent pressure))

(tms-query (content building-height))
=> #(supported #(*the-contradiction*) (superintendent pressure))

(tms-query (content barometer-height))
=> #(supported #(interval .3 .30328) (superintendent shadows))

(kick-out! 'superintendent)
(run)
(tms-query (content building-height))
=> #(supported #(interval 46. 47.243) (fall-time pressure))

(tms-query (content barometer-height))
=> #(supported #(interval .30054 .31839)
            (pressure fall-time shadows))

(bring-in! 'superintendent)
(kick-out! 'pressure)
(run)
(tms-query (content building-height))
=> #(supported 45 (superintendent))
(tms-query (content barometer-height))
=> #(supported #(interval .3 .30328) (superintendent shadows))
)


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

(interactive-example

(define (multiple-dwelling)
  (let ((baker    (make-cell))  (cooper (make-cell))
        (fletcher (make-cell))  (miller (make-cell))
        (smith    (make-cell))  (floors '(1 2 3 4 5)))
    (one-of floors baker)       (one-of floors cooper)
    (one-of floors fletcher)    (one-of floors miller)
    (one-of floors smith)
    (require-distinct
     (list baker cooper fletcher miller smith))
    (let ((b=5  (make-cell))    (c=1 (make-cell))
          (f=5  (make-cell))    (f=1 (make-cell))
          (m>c  (make-cell))    (sf  (make-cell))
          (fc   (make-cell))    (one (make-cell))
          (five (make-cell))    (s-f (make-cell))
          (as-f (make-cell))    (f-c (make-cell))
          (af-c (make-cell)))
      ((constant 1) one)        ((constant 5) five)
      (=? five baker b=5)       (forbid b=5)
      (=? one cooper c=1)       (forbid c=1)
      (=? five fletcher f=5)    (forbid f=5)
      (=? one fletcher f=1)     (forbid f=1)
      (>? miller cooper m>c)    (require m>c)
      (subtractor smith fletcher s-f)
      (absolute-value s-f as-f)
      (=? one as-f sf)          (forbid sf)
      (subtractor fletcher cooper f-c)
      (absolute-value f-c af-c)
      (=? one af-c fc)          (forbid fc)
      (list baker cooper fletcher miller smith))))

(initialize-scheduler)
(define answers (multiple-dwelling))
(run)
(map v&s-value (map tms-query (map content answers)))
=> (3 2 4 5 1)

*number-of-calls-to-fail*
=> 63
)


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
