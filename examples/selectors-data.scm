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
	      `(((home met) . ,(& 400 kilo meter))
		((home logan) . ,(& 8 kilo meter))
		((logan laguardia) . ,(& 400 kilo meter))
		((laguardia met) . ,(& 5 kilo meter))
		)))
  )

(define (time-est-f trip-segment speed)
  (cond ((nothing? (trip-segment-start trip-segment))
	 nothing)
	((nothing? (trip-segment-end trip-segment))
	 nothing)
	(else
	 (make-trip-segment-key 'time (/ (distance-est-f trip-segment) speed)))))

(define time-est (function->propagator-constructor (nary-unpacking time-est-f)))

(define (nearest-airport-f place)
  ...)

;; ditto nearest-station, nearest-stop

(define (same-city-f? trip-segment)
  ;; Really same-subway-network?
  (eq? (trip-segment-start trip-segment)
       (trip-segment-end trip-segment)))

(define same-city
  (function->propagator-constructor (nary-unpacking same-city-f?)))

(propagatify trip-segment-start)
(propagatify trip-segment-end)
(propagatify trip-segment-time)
(propagatify trip-segment-cost)
(propagatify trip-segment-pain)
(propagatify trip-segment-method)

(define (pick-airport place)
  (cdr (assoc place '((home . logan)
		      (met . laguardia)))))

(propagatify pick-airport)

(define (make-trip-segment-by-start place)
  (make-trip-segment-key 'start place))

(define (make-trip-segment-by-end place)
  (make-trip-segment-key 'end place))

(define (make-trip-segment-by-time time)
  (make-trip-segment-key 'time time))

(define (make-trip-segment-by-cost cost)
  (make-trip-segment-key 'cost cost))

(define (make-trip-segment-by-pain pain)
  (make-trip-segment-key 'pain pain))

(define (make-trip-segment-by-method method)
  (make-trip-segment-key 'method method))

(propagatify make-trip-segment-by-start)
(propagatify make-trip-segment-by-end)
(propagatify make-trip-segment-by-time)
(propagatify make-trip-segment-by-cost)
(propagatify make-trip-segment-by-pain)
(propagatify make-trip-segment-by-method)


;;; Hack for numerical estimates.  I should really do this with
;;; premises and proper truth maintenance

(define-structure estimate
  value)

(defhandler merge
  (lambda (estimate1 estimate2)
    (if (= (estimate-value estimate1)
	   (estimate-value estimate1))
	estimate1			; Redundant estimate
	estimate2			; Assume new one is better
	))
  estimate? estimate?)

(define (maybe-units? thing)
  (or (number? thing)
      (with-units? thing)))

;; Estimates always lose to "hard facts":
(defhandler merge
  (lambda (content increment)
    increment)
  estimate? maybe-units?)

(defhandler merge
  (lambda (content increment)
    content)
  maybe-units? estimate?)
