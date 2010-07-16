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

;;; Propagator cells, in message-accepter style
(define (make-cell)
  (let ((neighbors '()) (content nothing))
    (define (add-content increment)
      (let ((info+effects (->effectful (merge content increment))))
        (let ((effects (effectful-effects info+effects))
	      (new-content (effectful-info info+effects)))
	  (cond ((eq? new-content content) 'ok)
		((contradictory? new-content)
		 (error "Ack! Inconsistency!" me increment)
		 'this-is-not-a-tail-call)
		(else 
		 (set! content new-content)
		 (eq-adjoin! content 'visited-cells me)
		 (alert-propagators neighbors)))
	  (for-each execute-effect effects))))
    (define (new-neighbor! new-neighbor)
      (if (not (memq new-neighbor neighbors))
          (begin
            (set! neighbors (cons new-neighbor neighbors))
            (alert-propagators new-neighbor))))
    (define (me message)
      (cond ((eq? message 'content) content)
            ((eq? message 'add-content) add-content)
            ((eq? message 'neighbors) neighbors)
            ((eq? message 'new-neighbor!) new-neighbor!)
            (else (error "Unknown message" message))))
    (eq-put! me 'cell #t)
    (network-register me)
    me))

(define (content cell)
  (cell 'content))

(define (add-content cell increment)
  ((cell 'add-content) increment))

(define (neighbors cell)
  (cell 'neighbors))

(define (new-neighbor! cell neighbor)
  ((cell 'new-neighbor!) neighbor))

(define (cell? thing)
  (eq-get thing 'cell))

(define (make-named-cell name)
  (name! (make-cell) name))

(define (ensure-cell thing)
  (if (cell? thing)
      thing
      ;; TODO Retain forward reference to e:constant?  Copy the code?
      (e:constant thing)))

;;; Propagators

(define (propagator neighbors to-do)
  (for-each (lambda (cell)
              (new-neighbor! cell to-do))
            (listify neighbors))
  (eq-put! to-do 'propagator #t)
  (network-register to-do)
  (alert-propagator to-do)
  to-do)

(define (propagator? thing)
  (eq-get thing 'propagator))

(define (function->propagator-constructor f)
  (lambda cells
    (let ((output (ensure-cell (car (last-pair cells))))
          (inputs (map ensure-cell (except-last-pair cells))))
      (propagator inputs                ; The output isn't a neighbor!
        (lambda ()
          (add-content output
            (apply f (map content inputs))))))))

(define (propagator-constructor? thing)
  (or (eq-get thing 'propagator-constructor)
      (and (procedure? thing)
	   (not (cell? thing))
	   (not (propagator? thing))
	   (warn "Imputing propagator-contructor-hood" thing)
	   #t)))

(define (propagator-contructor! thing)
  (eq-put! thing 'propagator-contructor #t))

;;; This version has additional metadata to allow the propagator
;;; network to be effectively traversed (see extensions/draw.scm)
(define (function->propagator-constructor f)
  (lambda cells
    (let ((output (ensure-cell (car (last-pair cells))))
          (inputs (map ensure-cell (except-last-pair cells))))
      (let ((the-propagator
             (lambda ()
               (add-content output (apply f (map content inputs))))))
        (eq-adjoin! output 'shadow-connections the-propagator)
        (eq-label! the-propagator 'name f 'inputs inputs 'outputs (list output))
        (propagator inputs the-propagator)))))

;;; Propagators that defer the construction of their bodies, as one
;;; mechanism of abstraction.
(define (one-shot-propagator neighbors action)
  (let ((done? #f) (neighbors (map ensure-cell (listify neighbors))))
    (define (test)
      (if done?
          'ok
          (if (every nothing? (map content neighbors))
              'ok
              (begin (set! done? #t)
		     (in-network-group (network-group-of test)
		      (lambda ()
			;; The act of expansion makes the compound
			;; itself uninteresting
			(network-unregister test)
			(action)))))))
    (eq-clone! action test)
    (propagator neighbors test)))

(define (delayed-propagator-constructor prop-ctor)
  (lambda args
    ;; TODO Can I autodetect "inputs" that should not trigger
    ;; construction?
    (let ((args (map ensure-cell args)))
      (one-shot-propagator args
        (apply eq-label!
	  (lambda ()
	    (apply prop-ctor args))
	  (compute-aggregate-metadata prop-ctor args))))))

;;;; Merging

;;; My original thought was that merge answers the question:
;;; 
;;; "What is the least-commitment information structure that captures
;;; all the knowledge in these two information structures?"
;;; 
;;; That was a pretty good place to start, but it turns out not to be
;;; quite adequate.  What's the problem with it, you might ask?  The
;;; problem is that this question cannot have any side-effects.  But
;;; side-effects appear necessary: when merging two TMSes, one must
;;; check the result for consistency, and maybe signal a nogood set if
;;; one discovers a supported contradiction.  Worse, the
;;; carrying-cells strategy for compound data means that you might
;;; have to merge cells, and the only way to do that is to attach
;;; identity propagators between them, which is most definitely an
;;; effect.
;;; 
;;; After long thought, I understand that the real question that a
;;; cell asks (whether or not "merge" is a good name for the function
;;; that computes the answer) is:
;;; 
;;; "What do I need to do to the network in order to make it reflect
;;; the discovery that these two information structures are about the
;;; same object?"
;;; 
;;; In the common case, the answer to this question is going to amount
;;; to just an answer to the previous question, namely "You must
;;; record that that object is best described by this information
;;; structure, which is the least-commitment information structure
;;; that captures all the knowledge in the given information
;;; structures."  (That "you must record" is the set! in add-content).
;;; Also consistent with the simpler idea is the answer "These two
;;; information structures cannot describe the same object."  (This is
;;; the contradictory? test in add-content.)  However, this refined
;;; question provides the opening for more nuanced answers.  For
;;; example, with TMSes, it becomes possible to answer "The object is
;;; described by the following information structure, and you should
;;; record the following nogood set."  Or, with carrying cells, the
;;; answer can be "The object is described by the following
;;; information structure, and you should identify these two cells."
;;; 
;;; The advantage of thinking about it this way is that merge can be a
;;; pure function, which is allowed to return requests for these
;;; effects in addition to refined information structures.  Then places
;;; where merge is called recursively have a chance to intercept and
;;; modify these requests for effects (for example noting that they
;;; must be considered conditional on certain premises), and only 
;;; add-content actually executes the effects that come to it.

;;; Basic merging

(define (merge info1 info2)
  (if (eq? info1 info2)
      info1
      (let ((answer (generic-merge info1 info2)))
	(cond ((effectful? answer) answer)
	      ((equivalent? answer info1) info1)
	      ((equivalent? answer info2) info2)
	      (else answer)))))

(define generic-merge
  (make-generic-operator 2 'merge
   (lambda (content increment)
     (if (default-equal? content increment)
         content
         the-contradiction))))

(set-operator-record! merge (get-operator-record generic-merge))

(define nothing #(*the-nothing*))

(define (nothing? thing)
  (eq? thing nothing))

(define the-contradiction #(*the-contradiction*))

(define contradictory?
  (make-generic-operator 1 'contradictory?
   (lambda (thing) (eq? thing the-contradiction))))

(defhandler merge
 (lambda (content increment) content)
 any? nothing?)

(defhandler merge
 (lambda (content increment) increment)
 nothing? any?)

(define (implies? v1 v2)
  ;; This is right on the assumption that trivial effects are squeezed
  ;; out (for example by using effectful->).
  (eq? v1 (merge v1 v2)))

(define (equivalent? info1 info2)
  (or (eqv? info1 info2)
      (generic-equivalent? info1 info2)))

(define generic-equivalent?
  (make-generic-operator 2 'equivalent? eqv?))

(set-operator-record! equivalent? (get-operator-record generic-equivalent?))

;;; Data structure to represent a merge that may have effects.
(define execute-effect 
  (make-generic-operator 1 'execute-effect (lambda (effect) (effect))))

(define-structure effectful
  info
  effects)

(define (effectful-return info)
  (make-effectful info '()))

(define (->effectful thing)
  (if (effectful? thing)
      thing
      (effectful-return thing)))

(define (effectful-> effectful)
  (if (null? (effectful-effects effectful))
      (effectful-info effectful)
      effectful))

(define (effectful-flatten effectful)
  (let ((subeffectful (->effectful (effectful-info effectful))))
    (let ((subinfo (effectful-info subeffectful))
	  (subeffects (effectful-effects subeffectful))
	  (effects (effectful-effects effectful)))
      (make-effectful subinfo (append subeffects effects)))))

(define-method generic-match ((pattern <vector>) (object rtd:effectful))
  (generic-match
   pattern
   (vector 'effectful (effectful-info object)
	   (effectful-effects object))))

(define (effectful-merge e1 e2)
  (let ((e1 (->effectful e1))
	(e2 (->effectful e2)))
    (let ((info-merge (->effectful (merge (effectful-info e1)
					  (effectful-info e2)))))
      (effectful->
       (make-effectful
	(effectful-info info-merge)
	(append (effectful-effects e1)
		(effectful-effects info-merge)
		(effectful-effects e2)))))))

;;; This is the n-ary merge
(define (merge* infos-list)
  (fold-left effectful-merge nothing infos-list))

(define (effectful-bind effectful func)
  (let ((effectful (->effectful effectful)))
    (effectful->
     (effectful-flatten
      (make-effectful
       (->effectful (func (effectful-info effectful)))
       (effectful-effects effectful))))))

(define (effectful-list-bind effectfuls func)
  (let ((effectfuls (map ->effectful effectfuls)))
    (effectful->
     (effectful-flatten
      (make-effectful
       (->effectful (func (map effectful-info effectfuls)))
       (apply append (map effectful-effects effectfuls)))))))
