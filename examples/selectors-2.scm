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

(define plan-trip
  (choice-node plan-air plan-train plan-subway plan-walk))

(define (critic go? method . answers)
  ;; Choose the method that promises least pain
  )

(define (push-selector go? pushee method . targets)
  ;; Conditionally shove the contents of the pushee into the target
  ;; indicated by the method
  )

(define (pull-selector go? pullee method . targets)
  ;; Conditionally shove the contents of the target indicated by the
  ;; method into the pullee (and tag it with the identity of the
  ;; method?)
  )

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
      (apply segment-splitter go? segment (map cadr stage-cells))
      )))

(define plan-air
  (split-node fast-air-estimate airport-splitter
	      plan-trip between-airports plan-trip))

(define plan-train
  (split-node fast-train-estimate station-splitter
	      plan-trip between-stations plan-trip))

(define plan-subway
  (split-node fast-subway-estimate stop-splitter
	      plan-trip between-stops plan-trip))

(define (answer-compounder go? out . subanswers)
  ...)

(define (forwarder go? subgo?)
  ;; If the "go" signal is suitably "deep-go", forward it.
  )

;;; The actual specific planners
(define (plan-walk go? segment)
  ((const (method 'just-walk)) segment)
  ((const (cost (& 0 dollars))) segment) ; Or more for food, etc if it takes a long time
  ; Time: 3 mph
  ; Annoyance: Some fixed function of time
  )

(define (fast-air-estimate segment)
  ((const (method 'fly)) segment)
  ((const (time (& 1 day))) segment)
  ((const (cost (& 500 dollars)) segment))
  ((const (annoyance (& 200 craps)) segment)))

(define (airport-splitter go? segment to by from)
  ; (start segment) -> (start to)
  ; (end segment) -> (end from)
  ; (the-airport (start segment)) -> (end to) (start by)
  ; (the-airport (end segment)) -> (end by) (start from)
  )

(define (between-airports go? segment)
  ; Complicated task-specific stuff...
  )

(define (fast-train-estimate segment)
  ; 50 mph + 2 hours, $50
  )

(define (between-stations go? segment)
  ; Complicated task-specific stuff...
  )

(define (fast-subway-estimate segment)
  ; 50 mph; fail if in different cities; $2
  )

(define (between-stops go? segment)
  ; Complicated task-specific stuff...
  )


;;; TODO How does one watch this search and adjust the fast estimates
;;; in light of backtracks caused by later refinements?
