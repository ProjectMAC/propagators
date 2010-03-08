(define (choice-node . alternatives)
  (lambda (go? segment)
    (compound-propagator (list go?)	; Only expand if go? has something
      (eq-label!
       (lambda ()
	 (newline)
	 (pp `(planning a trip across 
			,(if (nothing? (content segment))
			     segment
			     (cons (trip-segment-start (content segment))
				   (trip-segment-end (content segment))))))
	 (let-cells (elaboree-method final-method)
	   (let ((opt-cells
		  (map (lambda (alternative)
			 (let-cells (opt-go? opt-segment)
			   (pass-through
			    (p:make-trip-segment-by-start
			     (p:trip-segment-start segment))
			    opt-segment)
			   (pass-through
			    (p:make-trip-segment-by-end
			     (p:trip-segment-end segment))
			    opt-segment)
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
       'name 'a-choice-node
       'inputs (list go? segment)
       'output (list segment)))))

(define plan-trip
  (delay (choice-node plan-air plan-train plan-subway plan-walk)))

(define (critic go? elaboree-method final-method . answers)
  ;; Choose the method that promises least pain
  (define (the-propagator)
    (newline)
    (for-each pp (map content answers))
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
		    (pp `(thinking about ,best-method-answer))
		    (pp best-method-answer)
		    (pp (content elaboree-method))
		    (pp (make-estimate best-method-index))
		    (add-content elaboree-method
				 (make-estimate best-method-index)))
		  (begin
		    (pp `(decided on ,best-method-answer))
		    (pp best-method-answer)
		    (add-content final-method best-method-index)))))))
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
	       (begin
		 (pp `(pushing to ,(method-index (content method))))
		 (add-content
		  (list-ref targets (method-index (content method)))
		  (content pushee)))))))
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

(define (split-node estimator segment-splitter . stages)
  (lambda (go? segment)
    (compound-propagator (list go?) ; Only expand if go? has something
      (eq-label!
       (lambda ()
	 (newline)
	 (pp `(expanding a split-node ,estimator
			 ,(if (nothing? (content segment))
			      segment
			      (cons (trip-segment-start (content segment))
				    (trip-segment-end (content segment))))))
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
       'name 'a-split-node
       'inputs (list go? segment)
       'outputs (list segment)))))

(define-macro-propagator (answer-compounder go? out . subanswers)
  (pass-through
   (p:make-trip-segment-by-start
    (p:trip-segment-start (car subanswers)))
   out)
  (pass-through
   (p:make-trip-segment-by-end
    (p:trip-segment-end (car (last-pair subanswers))))
   out)
  (pass-through
   (p:make-trip-segment-by-time
    (reduce p:+ (p:const 0) (map p:trip-segment-time subanswers)))
   out)
  (pass-through
   (p:make-trip-segment-by-cost
    (reduce p:+ (p:const 0) (map p:trip-segment-cost subanswers)))
   out)
  (pass-through
   (p:make-trip-segment-by-pain
    (reduce p:+ (p:const 0) (map p:trip-segment-pain subanswers)))
   out)
  ;; TODO Do the method correctly; incl the waypoints, etc.
  )

(define (forwarder go? subgo?)
  ;; If the "go" signal is suitably "go-deep", forward it.
  (pass-through (p:deep-only go?) subgo?))

;;; The actual specific planners
(define plan-walk
  (delay 
    (lambda (go? segment)
      (compound-propagator (list go?)
	(eq-label!
	 (lambda ()
	   ((constant (make-trip-segment-by-method 'just-walk)) segment)
	   (pass-through
	    (p:make-trip-segment-by-time
	     (p:time-est segment (p:const (& 3 (/ mile hour)))))
	    segment)
	   ;; TODO Fix this hack
	   (pass-through (p:tag-not-estimate segment) segment)
	   ;; Or more for food, etc if it takes a long time
	   ((constant (make-trip-segment-by-cost (& 0 dollar))) segment)
	   ;; Or: Some fixed function of time
	   ((constant (make-trip-segment-by-pain (& 0 crap))) segment))
	 'name 'plan-walk
	 'inputs (list go? segment)
	 'outputs (list segment))))))

(define-macro-propagator (fast-air-estimate segment)
  (let-cells (same-city? same-city-answer intercity-answer)
    (same-city segment same-city?)
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

(define ((splitter p:pick-waypoint) go? segment beginning middle end)
  (pass-through (p:make-trip-segment-by-start (p:trip-segment-start segment))
		beginning)
  (let-cell (first-waypoint)
    (pass-through (p:pick-waypoint (p:trip-segment-start segment))
		  first-waypoint)
    (pass-through (p:make-trip-segment-by-end first-waypoint) beginning)
    (pass-through (p:make-trip-segment-by-start first-waypoint) middle))
  (let-cell (last-waypoint)
    (pass-through (p:make-trip-segment-by-end last-waypoint) middle)
    (pass-through (p:make-trip-segment-by-start last-waypoint) end)
    (pass-through (p:pick-waypoint (p:trip-segment-end segment))
		  last-waypoint))
  (pass-through (p:make-trip-segment-by-end   (p:trip-segment-end   segment))
		end))

(define-macro-propagator (between-airports go? segment)
  (compound-propagator (list go?)
    (eq-label!
     (lambda ()
       ;; Complicated task-specific stuff stubbed...
       (pass-through (p:airport-lookup segment) segment))
     'name 'between-airports
     'inputs (list go? segment)
     'outputs (list segment))))

(define plan-air
  (delay (split-node fast-air-estimate (splitter p:pick-airport)
		     (force plan-trip) between-airports (force plan-trip))))

(define-macro-propagator (fast-train-estimate segment)
  (let-cells (same-city? same-city-answer intercity-answer)
    (same-city segment same-city?)
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
  (pass-through
   (p:make-trip-segment-by-time
    (p:+ (p:time-est segment (p:const (& 50 (/ mile hour))))
	 (p:const (& 2 hour))))
   segment)
  ((constant (make-trip-segment-by-cost (make-estimate (& 50 dollar))))
   segment)
  ((constant (make-trip-segment-by-pain (make-estimate (& 25 crap))))
   segment))

(define-macro-propagator (between-stations go? segment)
  (compound-propagator (list go?)
    (eq-label!
     (lambda ()
       ;; Complicated task-specific stuff stubbed...
       (pass-through (p:station-lookup segment) segment))
     'name 'between-stations
     'inputs (list go? segment)
     'outputs (list segment))))

(define plan-train
  (delay (split-node fast-train-estimate (splitter p:pick-station)
		     (force plan-trip) between-stations (force plan-trip))))

(define-macro-propagator (fast-subway-estimate segment)
  (let-cells (same-city? same-city-answer intercity-answer)
    (same-city segment same-city?)
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
  (compound-propagator (list go?)
    (eq-label!
     (lambda ()
       ;; Complicated task-specific stuff stubbed...
       (pass-through (p:stop-lookup segment) segment))
     'name 'between-stops
     'inputs (list go? segment)
     'outputs (list segment))))

(define plan-subway
  (delay (split-node fast-subway-estimate (splitter p:pick-stop)
		     (force plan-trip) between-stops (force plan-trip))))
;;; TODO How does one watch this search and adjust the fast estimates
;;; in light of backtracks caused by later refinements?

;;; Unit system hacking
(define dollar
  (if (lexical-unbound? (the-environment) 'ampere)
      'units-not-available
      ampere))
(define crap dollar)
