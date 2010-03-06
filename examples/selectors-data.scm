(define-structure
  (trip-segment (constructor make-segment)
		(keyword-constructor make-segment-key))
  start
  end
  time
  cost
  pain
  method)

(define (segment-merge segment1 segment2)
  (let ((start-answer  (merge (segment-start segment1)  (segment-start segment2)))
	(end-answer    (merge (segment-end segment1)    (segment-end segment2)))
	(time-answer   (merge (segment-time segment1)   (segment-time segment2)))
	(cost-answer   (merge (segment-cost segment1)   (segment-cost segment2)))
	(pain-answer   (merge (segment-pain segment1)   (segment-pain segment2)))
	(method-answer (merge (segment-method segment1) (segment-method segment2))))
    (cond ((and (eq? start-answer  (segment-start segment1))
		(eq? end-answer    (segment-end segment1))
		(eq? time-answer   (segment-time segment1))
		(eq? cost-answer   (segment-cost segment1))
		(eq? pain-answer   (segment-pain segment1))
		(eq? method-answer (segment-method segment1)))
	   segment1)
	  ((and (eq? start-answer  (segment-start segment2))
		(eq? end-answer    (segment-end segment2))
		(eq? time-answer   (segment-time segment2))
		(eq? cost-answer   (segment-cost segment1))
		(eq? pain-answer   (segment-pain segment1))
		(eq? method-answer (segment-method segment1)))
	   segment2)
	  (else
	   (make-segment start-answer end-answer time-answer
			 cost-answer pain-answer method-answer)))))

(defhandler merge segment-merge segment? segment?)

(defhandler contradictory?
  (lambda (segment) (or (contradictory? (segment-start  segment))
			(contradictory? (segment-end    segment))
			(contradictory? (segment-time   segment))
			(contradictory? (segment-cost   segment))
			(contradictory? (segment-pain   segment))
			(contradictory? (segment-method segment))))
  segment?)

(define (distance-est segment)
  ...)

(define (nearest-airport place)
  ...)

;; ditto nearest-station, nearest-stop

(define (same-city? segment)
  ;; Really same-subway-network?
  )

