(define (plan-trip go? segment pain answer)
  (let-cells (air-go? air-input air-pain air-answer
	      train-go? train-input train-pain train-answer
	      bus-go? bus-input bus-pain bus-answer
	      method)
    (plan-air air-go? air-input air-pain air-answer)
    (plan-train train-go? train-input train-pain train-answer)
    (plan-bus bus-go? bus-input bus-pain bus-answer)
    (critic go? air-pain train-pain bus-pain method)
    (selector go? method air-go? train-go? bus-go?)
    (answerer go? method air-answer train-answer bus-answer answer)
    ))

(define (choice-node . alternatives)
  (lambda (go? segment)
    (let-cell method
      (let ((opt-cells
	     (map (lambda (alternative)
		    (let-cells (opt-go? opt-segment)
		      (alternative opt-go? opt-segment)
		      (list opt-go? opt-segment)))
		  alternatives)))
	(apply critic go? method (map cadr opt-cells))
	(apply push-selector go? go?     method (map car opt-cells))
	(apply push-selector go? segment method (map cadr opt-cells))
	(apply pull-selector go? segment method (map cadr opt-cells))))))
#;
(define plan-trip
  (choice-node plan-air plan-train plan-subway plan-walk))

(define (critic go? method . answers)
  ;; Choose the method that promises least pain
  ...)

(define (push-selector go? pushee method . targets)
  ;; Conditionally shove the contents of the pushee into the target
  ;; indicated by the method
  ...)

(define (pull-selector go? pullee method . targets)
  ;; Conditionally shove the contents of the target indicated by the
  ;; method into the pullee (and tag it with the identity of the
  ;; method?)
  ...)

(define (plan-air go? segment pain answer)
  (fast-air-estimate segment pain answer)
  (let-cells (to-air-input by-air-input from-air-input
	      to-air-pain by-air-pain from-air-pain
	      to-air-answer by-air-answer from-air-answer
	      to-air-go? by-air-go? from-air-go?)
    (forwarder go? to-air-go? by-air-go? from-air-go?)
    (summer go? to-air-pain by-air-pain from-air-pain pain)
    (compounder go? to-air-answer by-air-answer from-air-answer answer)

    (select-source-airport go? segment to-air-input by-air-input)
    (plan-trip to-air-go? to-air-input to-air-pain to-air-answer)

    (between-airports by-air-go? by-air-input by-air-pain by-air-answer)

    (select-dest-airport go? segment from-air-input by-air-input)
    (plan-trip from-air-go? from-air-input from-air-pain from-air-answer)
    ))

(define (split-node estimator segment-splitter . stages)
  (lambda (go? segment)
    (estimator segment)
    (let ((stage-cells
	   (map (lambda (stage)
		  (let-cells (stage-go? stage-segment)
		    (forwarder go? stage-go?)
		    (stage stage-go? stage-segment)
		    (list stage-go? stage-segment)))
		stages)))
      (apply answer-compounder go? segment (map cadr stage-cells))
      (apply segment-splitter go? segment (map cadr stage-cells)))))
#|
 (define plan-air
   (split-node fast-air-estimate (splitter p:pick-airport)
	       plan-trip between-airports plan-trip))

 (define plan-train
   (split-node fast-train-estimate (splitter p:pick-station)
	       plan-trip between-stations plan-trip))

 (define plan-subway
   (split-node fast-subway-estimate (splitter p:pick-subway)
	       plan-trip between-stops plan-trip))
|#
#;
(define plan-air
  (split-node fast-air-estimate (splitter p:pick-airport)
	      plan-walk between-airports plan-walk))

(define (answer-compounder go? out . subanswers)
  (pass-through
   (p:make-trip-segment-by-start (p:trip-segment-start (car subanswers)))
   out)
  (pass-through
   (p:make-trip-segment-by-end (p:trip-segment-end (car (last-pair subanswers))))
   out)
  (pass-through
   (p:make-trip-segment-by-time
    (apply p:+ (map p:trip-segment-time subanswers)))
   out)
  (pass-through
   (p:make-trip-segment-by-cost
    (apply p:+ (map p:trip-segment-cost subanswers)))
   out)
  (pass-through
   (p:make-trip-segment-by-pain
    (apply p:+ (map p:trip-segment-pain subanswers)))
   out)
  ;; TODO Do the method correctly; incl the waypoints, etc.
  )

(define (forwarder go? subgo?)
  ;; If the "go" signal is suitably "deep-go", forward it.
  (pass-through go? subgo?))

;;; The actual specific planners
(define (plan-walk go? segment)
  ((constant (make-trip-segment-key 'method 'just-walk)) segment)
  (time-est segment (p:const (& 3 (/ mile hour))) segment)
  ;; Or more for food, etc if it takes a long time
  ((constant (make-trip-segment-key 'cost (& 0 dollar))) segment)
  ;; Or: Some fixed function of time
  ((constant (make-trip-segment-key 'pain (& 0 crap))) segment))

(define (fast-air-estimate segment)
  ((constant (make-trip-segment-key 'method 'fly)) segment)
  ((constant (make-trip-segment-key 'time (& 1 day))) segment)
  ((constant (make-trip-segment-key 'cost (& 500 dollar))) segment)
  ((constant (make-trip-segment-key 'pain (& 200 crap))) segment))

(define ((splitter p:pick-waypoint) go? segment beginning middle end)
  (pass-through (p:make-trip-segment-by-start (p:trip-segment-start segment))
		beginning)
  (let-cell (first-waypoint)
    (pass-through (p:pick-waypoint (p:trip-segment-start segment)) first-waypoint)
    (pass-through (p:make-trip-segment-by-end first-waypoint) beginning)
    (pass-through (p:make-trip-segment-by-start first-waypoint) middle))
  (let-cell (last-waypoint)
    (pass-through (p:make-trip-segment-by-end last-waypoint) middle)
    (pass-through (p:make-trip-segment-by-start last-waypoint) end)
    (pass-through (p:pick-waypoint (p:trip-segment-end segment)) last-waypoint))
  (pass-through (p:make-trip-segment-by-end   (p:trip-segment-end   segment))
		end)) ;; Ditto stations, stops

(define (between-airports go? segment)
  ; Complicated task-specific stuff...
  ;; TODO Refinement of numbers, and of the method
  (plan-walk go? segment)
  )

(define (fast-train-estimate segment)
  ((constant (make-trip-segment-key 'method 'take-the-train)) segment)
  ;; Plus two hours for two-from the station?
  (time-est segment (& 50 (/ mile hour)) segment)
  ((constant (make-trip-segment-key 'cost (& 50 dollar))) segment)
  ((constant (make-trip-segment-key 'pain (& 25 crap))) segment))

(define (between-stations go? segment)
  ; Complicated task-specific stuff...
  ...)

(define (fast-subway-estimate segment)
  (let-cells (same-city? same-city-answer)
    (switch same-city? same-city-answer segment)
    ((constant (make-trip-segment-key 'method 'subway)) same-city-answer)
    ((constant (make-trip-segment-key 'time (& 1 hour))) same-city-answer)
    ((constant (make-trip-segment-key 'cost (& 2 dollar))) same-city-answer)
    ((constant (make-trip-segment-key 'pain (& 25 crap))) same-city-answer)
    (same-city segment same-city?)))

(define (between-stops go? segment)
  ; Complicated task-specific stuff...
  ...)

#|
 (initialize-scheduler)
 (define-cell walk-to-met)
 (define-cell go?)
 (add-content walk-to-met (make-trip-segment-key 'start 'home 'end 'met))
 (plan-walk go? walk-to-met)
 (run)
 (pp (content walk-to-met))

 (initialize-scheduler)
 (define-cell fly-to-met)
 (add-content fly-to-met (make-trip-segment-key 'start 'home 'end 'met))
 (fast-air-estimate fly-to-met)
 (run)
 (pp (content fly-to-met))

 (initialize-scheduler)
 (define-cell subway-to-met)
 (add-content subway-to-met (make-trip-segment-key 'start 'home 'end 'met))
 (fast-subway-estimate subway-to-met)
 (run)
 (pp (content subway-to-met))

 (initialize-scheduler)
 (define-cell go?)
 (define-cell fly-to-met)
 (define-cell beginning)
 (define-cell middle)
 (define-cell end)
 (add-content fly-to-met (make-trip-segment-key 'start 'home 'end 'met))
 (airport-splitter go? fly-to-met beginning middle end)
 (run)
 (map pp (map content (list fly-to-met beginning middle end)))

|#
;;; TODO How does one watch this search and adjust the fast estimates
;;; in light of backtracks caused by later refinements?

;;; Unit system hacking
(define dollar ampere)
(define crap ampere)