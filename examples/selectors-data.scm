(define-structure
  (trip-segment (constructor make-trip-segment)
		(keyword-constructor make-trip-segment-key))
  (start  nothing read-only #t)
  (end    nothing read-only #t)
  (time   nothing read-only #t)
  (cost   nothing read-only #t)
  (pain   nothing read-only #t)
  (method nothing read-only #t))

(define (trip-segment-merge trip-segment1 trip-segment2)
  (let ((start-answer  (merge (trip-segment-start trip-segment1)
			      (trip-segment-start trip-segment2)))
	(end-answer    (merge (trip-segment-end trip-segment1)
			      (trip-segment-end trip-segment2)))
	(time-answer   (merge (trip-segment-time trip-segment1)
			      (trip-segment-time trip-segment2)))
	(cost-answer   (merge (trip-segment-cost trip-segment1)
			      (trip-segment-cost trip-segment2)))
	(pain-answer   (merge (trip-segment-pain trip-segment1)
			      (trip-segment-pain trip-segment2)))
	(method-answer (merge (trip-segment-method trip-segment1)
			      (trip-segment-method trip-segment2))))
    (cond ((and (eq? start-answer  (trip-segment-start trip-segment1))
		(eq? end-answer    (trip-segment-end trip-segment1))
		(eq? time-answer   (trip-segment-time trip-segment1))
		(eq? cost-answer   (trip-segment-cost trip-segment1))
		(eq? pain-answer   (trip-segment-pain trip-segment1))
		(eq? method-answer (trip-segment-method trip-segment1)))
	   trip-segment1)
	  ((and (eq? start-answer  (trip-segment-start trip-segment2))
		(eq? end-answer    (trip-segment-end trip-segment2))
		(eq? time-answer   (trip-segment-time trip-segment2))
		(eq? cost-answer   (trip-segment-cost trip-segment1))
		(eq? pain-answer   (trip-segment-pain trip-segment1))
		(eq? method-answer (trip-segment-method trip-segment1)))
	   trip-segment2)
	  (else
	   (make-trip-segment start-answer end-answer time-answer
			      cost-answer pain-answer method-answer)))))

(defhandler merge trip-segment-merge trip-segment? trip-segment?)

(defhandler contradictory?
  (lambda (trip-segment)
    (or (contradictory? (trip-segment-start  trip-segment))
	(contradictory? (trip-segment-end    trip-segment))
	(contradictory? (trip-segment-time   trip-segment))
	(contradictory? (trip-segment-cost   trip-segment))
	(contradictory? (trip-segment-pain   trip-segment))
	(contradictory? (trip-segment-method trip-segment))))
  trip-segment?)

(define (distance-est-f trip-segment)
  ;;; Ha!
  (cdr (assoc (list (trip-segment-start trip-segment)
		    (trip-segment-end   trip-segment))
	      `(((home met) . ,(& 400 kilo meter)))))
  )

(define (time-est-f trip-segment speed)
  (make-trip-segment-key 'time
    ((access / generic-environment) (distance-est-f trip-segment) speed)))

(define time-est (function->propagator-constructor (nary-unpacking time-est-f)))

(define (nearest-airport-f place)
  ...)

;; ditto nearest-station, nearest-stop

(define (same-city-f? trip-segment)
  ;; Really same-subway-network?
  (eq? (trip-segment-start trip-segment)
       (trip-segment-end trip-segment)))

(define same-city (function->propagator-constructor (nary-unpacking same-city-f?)))
