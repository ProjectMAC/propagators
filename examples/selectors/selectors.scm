;;; ----------------------------------------------------------------------
;;; Copyright 2010 Alexey Radul.
;;; ----------------------------------------------------------------------
;;; This file is part of Propagator Network Prototype.
;;; 
;;; Propagator Network Prototype is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;; 
;;; Propagator Network Prototype is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;; 
;;; You should have received a copy of the GNU General Public License
;;; along with Propagator Network Prototype.  If not, see <http://www.gnu.org/licenses/>.
;;; ----------------------------------------------------------------------

(define (choice-node name . alternatives)
  (lambda (go? segment)
    (one-shot-propagator (list go?)	; Only expand if go? has something
      (eq-label!
       (lambda ()
	 (snewline)
	 (spp `(planning a trip 
			 ,@(if (nothing? (content segment))
			       '(unknown)
			       (trip-segment-endpoints (content segment)))))
	 (let-cells (elaboree-method final-method)
	   (let ((opt-cells
		  (map (lambda (alternative)
			 (let-cells (opt-go? opt-segment)
			   (p:make-trip-segment-by-start
			    (e:trip-segment-start segment) opt-segment)
			   (p:make-trip-segment-by-end
			    (e:trip-segment-end segment) opt-segment)
			   ((constant 'go-fast) opt-go?)
			   (alternative opt-go? opt-segment)
			   (list opt-go? opt-segment)))
		       (map force alternatives))))
	     (apply critic go? elaboree-method final-method
		    (map cadr opt-cells))
	     (apply push-selector go? go? elaboree-method
		    (map car opt-cells))
	     #;(apply push-selector go? segment elaboree-method
		    (map cadr opt-cells))
	     (apply pull-selector go? segment final-method
		    (map cadr opt-cells)))))
       'name name
       'inputs (list go? segment)
       'output (list segment)))))

(define plan-trip
  (delay (choice-node 'plan-trip plan-air plan-train plan-subway plan-walk)))

(define (critic go? elaboree-method final-method . answers)
  ;; Choose the method that promises least pain
  (define (the-propagator)
    (print-trip-segment-group (map content answers))
    (if (and (every trip-segment? (map content answers))
	     (every (lambda (ans)
		      (not (nothing? (trip-segment-time (content ans)))))
		    answers))
	(let* ((best-method-index (find-best-method (map content answers)))
	       (best-method-answer
		(content (list-ref answers best-method-index))))
	  (if best-method-index
	      (if (estimate? (trip-segment-time best-method-answer))
		  (begin
		    (spp `(thinking about ,(trip-segment-method
					    best-method-answer)))
		    (add-content elaboree-method
				 (make-estimate best-method-index)))
		  (begin
		    (spp `(decided to ,(trip-segment-method
					best-method-answer)))
		    (add-content final-method best-method-index)))))
	(spp 'waiting-for-more-estimates)))
  (let ((inputs (cons go? answers)))
    (eq-label! the-propagator
     'name 'critic 'inputs inputs
     'outputs (list elaboree-method final-method))
    (eq-adjoin! elaboree-method 'shadow-connections the-propagator)
    (eq-adjoin! final-method 'shadow-connections the-propagator)
    (propagator inputs the-propagator)))

(define (push-selector go? pushee method . targets)
  ;; Conditionally shove the contents of the pushee into the target
  ;; indicated by the method
  (let ((inputs (list go? pushee method))
	(the-propagator
	 (lambda ()
	   (if (not (nothing? (content method)))
	       (add-content
		(list-ref targets (method-index (content method)))
		(content pushee))))))
    (eq-label! the-propagator
     'name 'push-selector 'inputs inputs 'outputs targets)
    (for-each (lambda (target)
		(eq-adjoin! target 'shadow-connections push-selector))
	      targets)
    (propagator inputs the-propagator)))

(define (pull-selector go? pullee method . targets)
  ;; Conditionally shove the contents of the target indicated by the
  ;; method into the pullee (and tag it with the identity of the
  ;; method?)
  (let ((inputs `(,go? ,method ,@targets))
	(the-propagator
	 (lambda ()
	   (if (not (nothing? (content method)))
	       (add-content pullee
		 (content (list-ref targets (content method))))))))
    (eq-label! the-propagator
     'name 'pull-selector 'inputs inputs 'outputs (list pullee))
    (eq-adjoin! pullee 'shadow-connections the-propagator)
    (propagator inputs the-propagator)))

(define (split-node name estimator segment-splitter . stages)
  (lambda (go? segment)
    (one-shot-propagator (list go?) ; Only expand if go? has something
      (eq-label!
       (lambda ()
	 (estimator segment)
	 (let ((stage-cells
		(map (lambda (stage)
		       (let-cells (stage-go? stage-segment)
			 (forwarder go? stage-go?)
			 (stage stage-go? stage-segment)
			 (list stage-go? stage-segment)))
		     stages)))
	   (apply answer-compounder go? segment (map cadr stage-cells))
	   (apply segment-splitter go? segment (map cadr stage-cells))))
       'name name
       'inputs (list go? segment)
       'outputs (list segment)))))

(define-propagator-syntax (answer-compounder go? out . subanswers)
  (p:make-trip-segment-by-start (e:trip-segment-start (car subanswers)) out)
  (p:make-trip-segment-by-end
   (e:trip-segment-end (car (last-pair subanswers))) out)
  (p:make-trip-segment-by-time
   (reduce e:+ (e:constant 0) (map e:trip-segment-time subanswers)) out)
  (p:make-trip-segment-by-cost
   (reduce e:+ (e:constant 0) (map e:trip-segment-cost subanswers)) out)
  (p:make-trip-segment-by-pain
   (reduce e:+ (e:constant 0) (map e:trip-segment-pain subanswers)) out)
  ;; TODO Do the method correctly; incl the waypoints, etc.
  )

(define (forwarder go? subgo?)
  ;; If the "go" signal is suitably "go-deep", forward it.
  (p:deep-only go? subgo?))

;;; The actual specific planners
(define plan-walk
  (delay 
    (lambda (go? segment)
      (one-shot-propagator (list go?)
	(eq-label!
	 (lambda ()
	   ((constant (make-trip-segment-by-method 'just-walk)) segment)
	   (p:make-trip-segment-by-time
	    (e:time-est segment (e:constant (& 3 (/ mile hour))))
	    segment)
	   ;; TODO Fix this hack
	   (p:tag-not-estimate segment segment)
	   ;; Or more for food, etc if it takes a long time
	   ((constant (make-trip-segment-by-cost (& 0 dollar))) segment)
	   ;; Or: Some fixed function of time
	   ((constant (make-trip-segment-by-pain (& 0 crap))) segment))
	 'name 'plan-walk
	 'inputs (list go? segment)
	 'outputs (list segment))))))

(define-macro-propagator (fast-air-estimate segment)
  (let-cells (same-city? same-city-answer intercity-answer)
    (p:same-city? segment same-city?)
    (conditional same-city? same-city-answer intercity-answer segment)
    (conditional-writer same-city? segment same-city-answer intercity-answer)
    (fast-incity-air-estimate same-city-answer)
    (fast-intercity-air-estimate intercity-answer)))

(define-macro-propagator (fast-incity-air-estimate segment)
  ((constant (make-trip-segment-by-method 'fly))
   segment)
  ;; TODO notate impossibility
  ((constant (make-trip-segment-by-time
	      (make-estimate (& (expt 10 10) hour))))
   segment)
  ((constant (make-trip-segment-by-cost (make-estimate (& 500 dollar))))
   segment)
  ((constant (make-trip-segment-by-pain (make-estimate (& 200 crap))))
   segment))

(define-macro-propagator (fast-intercity-air-estimate segment)
  ((constant (make-trip-segment-by-method 'fly))
   segment)
  ((constant (make-trip-segment-by-time (make-estimate (& 7 hour))))
   segment)
  ((constant (make-trip-segment-by-cost (make-estimate (& 500 dollar))))
   segment)
  ((constant (make-trip-segment-by-pain (make-estimate (& 200 crap))))
   segment))

(define ((splitter e:pick-waypoint) go? segment beginning middle end)
  (p:make-trip-segment-by-start (e:trip-segment-start segment) beginning)
  (let-cell first-waypoint
    (pass-through (e:pick-waypoint (e:trip-segment-start segment))
		  first-waypoint)
    (p:make-trip-segment-by-end first-waypoint beginning)
    (p:make-trip-segment-by-start first-waypoint middle))
  (let-cell last-waypoint
    (p:make-trip-segment-by-end last-waypoint middle)
    (p:make-trip-segment-by-start last-waypoint end)
    (pass-through (e:pick-waypoint (e:trip-segment-end segment))
		  last-waypoint))
  (p:make-trip-segment-by-end   (e:trip-segment-end   segment) end))

(define-macro-propagator (between-airports go? segment)
  (one-shot-propagator (list go?)
    (eq-label!
     (lambda ()
       ;; Complicated task-specific stuff stubbed...
       (p:airport-lookup segment segment))
     'name 'between-airports
     'inputs (list go? segment)
     'outputs (list segment))))

(define plan-air
  (delay (split-node 'plan-air fast-air-estimate (splitter e:pick-airport)
		     (force plan-trip) between-airports (force plan-trip))))

(define-macro-propagator (fast-train-estimate segment)
  (let-cells (same-city? same-city-answer intercity-answer)
    (p:same-city? segment same-city?)
    (conditional same-city? same-city-answer intercity-answer segment)
    (conditional-writer same-city? segment same-city-answer intercity-answer)
    (fast-incity-train-estimate same-city-answer)
    (fast-intercity-train-estimate intercity-answer)))

(define-macro-propagator (fast-incity-train-estimate segment)
  ((constant (make-trip-segment-by-method 'take-the-train))
   segment)
  ;; TODO notate impossibility
  ((constant (make-trip-segment-by-time
	      (make-estimate (& (expt 10 10) hour))))
   segment)
  ((constant (make-trip-segment-by-cost (make-estimate (& 50 dollar))))
   segment)
  ((constant (make-trip-segment-by-pain (make-estimate (& 25 crap))))
   segment))

(define-macro-propagator (fast-intercity-train-estimate segment)
  ((constant (make-trip-segment-by-method 'take-the-train)) segment)
  ;; Plus two hours for to-from the station?
  ;; TODO Clean up which uses of time-est are actually estimates
  ;; and which are "hard"
  (p:make-trip-segment-by-time
   (e:+ (e:time-est segment (e:constant (& 50 (/ mile hour))))
	(e:constant (& 2 hour)))
   segment)
  ((constant (make-trip-segment-by-cost (make-estimate (& 50 dollar))))
   segment)
  ((constant (make-trip-segment-by-pain (make-estimate (& 25 crap))))
   segment))

(define-macro-propagator (between-stations go? segment)
  (one-shot-propagator (list go?)
    (eq-label!
     (lambda ()
       ;; Complicated task-specific stuff stubbed...
       (p:station-lookup segment segment))
     'name 'between-stations
     'inputs (list go? segment)
     'outputs (list segment))))

(define plan-train
  (delay (split-node 'plan-train fast-train-estimate (splitter e:pick-station)
		     (force plan-trip) between-stations (force plan-trip))))

(define-macro-propagator (fast-subway-estimate segment)
  (let-cells (same-city? same-city-answer intercity-answer)
    (p:same-city? segment same-city?)
    (conditional same-city? same-city-answer intercity-answer segment)
    (conditional-writer same-city? segment same-city-answer intercity-answer)
    (fast-incity-subway-estimate same-city-answer)
    (fast-intercity-subway-estimate intercity-answer)))

(define-macro-propagator (fast-incity-subway-estimate segment)
  ((constant (make-trip-segment-by-method 'subway))
   segment)
  ((constant (make-trip-segment-by-time (make-estimate (& 1 hour))))
   segment)
  ((constant (make-trip-segment-by-cost (make-estimate (& 2 dollar))))
   segment)
  ((constant (make-trip-segment-by-pain (make-estimate (& 25 crap))))
   segment))

(define-macro-propagator (fast-intercity-subway-estimate segment)
  ((constant (make-trip-segment-by-method 'subway))
   segment)
  ;; TODO notate impossibility
  ((constant (make-trip-segment-by-time
	      (make-estimate (& (expt 10 10) hour))))
   segment)
  ((constant (make-trip-segment-by-cost (make-estimate (& 2 dollar))))
   segment)
  ((constant (make-trip-segment-by-pain (make-estimate (& 25 crap))))
   segment))

(define-macro-propagator (between-stops go? segment)
  (one-shot-propagator (list go?)
    (eq-label!
     (lambda ()
       ;; Complicated task-specific stuff stubbed...
       (p:stop-lookup segment segment))
     'name 'between-stops
     'inputs (list go? segment)
     'outputs (list segment))))

(define plan-subway
  (delay (split-node 'plan-subway fast-subway-estimate (splitter e:pick-stop)
		     (force plan-trip) between-stops (force plan-trip))))
;;; TODO How does one watch this search and adjust the fast estimates
;;; in light of backtracks caused by later refinements?

;;; Unit system hacking
(define dollar
  (if (lexical-unbound? (the-environment) 'ampere)
      'units-not-available
      ampere))
(define crap 
  (if (lexical-unbound? (the-environment) 'kilogram)
      'units-not-available
      kilogram))
