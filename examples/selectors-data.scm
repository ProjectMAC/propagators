;;; Trip segments in general

(define-structure
  (trip-segment
   (constructor make-trip-segment)
   (constructor make-trip-segment-by-start  (start))
   (constructor make-trip-segment-by-end    (end))
   (constructor make-trip-segment-by-time   (time))
   (constructor make-trip-segment-by-cost   (cost))
   (constructor make-trip-segment-by-pain   (pain))
   (constructor make-trip-segment-by-method (method))
   (keyword-constructor make-trip-segment-key))
  (start  nothing read-only #t)
  (end    nothing read-only #t)
  (time   nothing read-only #t)
  (cost   nothing read-only #t)
  (pain   nothing read-only #t)
  (method nothing read-only #t))

(propagatify trip-segment-start)
(propagatify trip-segment-end)
(propagatify trip-segment-time)
(propagatify trip-segment-cost)
(propagatify trip-segment-pain)
(propagatify trip-segment-method)

(propagatify make-trip-segment-by-start)
(propagatify make-trip-segment-by-end)
(propagatify make-trip-segment-by-time)
(propagatify make-trip-segment-by-cost)
(propagatify make-trip-segment-by-pain)
(propagatify make-trip-segment-by-method)

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
		(eq? cost-answer   (trip-segment-cost trip-segment2))
		(eq? pain-answer   (trip-segment-pain trip-segment2))
		(eq? method-answer (trip-segment-method trip-segment2)))
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

;;; Stub data for particular jobs
(define (force-assoc item alist)
  (let ((binding (assoc item alist)))
    (if binding
	(cdr binding)
	(error "Expand the list!" item (map car alist)))))

(define (distance-est-f trip-segment)
  ;;; Ha!
  (if (eq? (trip-segment-start trip-segment)
	   (trip-segment-end trip-segment))
      (& 0 meter)
      (force-assoc (list (trip-segment-start trip-segment)
			 (trip-segment-end   trip-segment))
		   `(((home met) . ,(& 400 kilo meter))
		     ((met home) . ,(& 400 kilo meter))
		     ((home logan) . ,(& 8 kilo meter))
		     ((logan home) . ,(& 8 kilo meter))
		     ((logan laguardia) . ,(& 400 kilo meter))
		     ((laguardia logan) . ,(& 400 kilo meter))
		     ((laguardia met) . ,(& 5 kilo meter))
		     ((met laguardia) . ,(& 5 kilo meter))
		     ((home south-station) . ,(& 6 kilo meter))
		     ((south-station home) . ,(& 6 kilo meter))
		     ((south-station-under south-station) . ,(& 100 meter))
		     ((south-station south-station-under) . ,(& 100 meter))
		     ((south-station penn-station) . ,(& 400 kilo meter))
		     ((penn-station south-station) . ,(& 400 kilo meter))
		     ((penn-station met) . ,(& 1 kilo meter))
		     ((met penn-station) . ,(& 1 kilo meter))
		     ((penn-station 34th-street) . ,(& 100 meter))
		     ((34th-street penn-station) . ,(& 100 meter))
		     ((home beaconsfield) . ,(& 100 meter))
		     ((beaconsfield home) . ,(& 100 meter))
		     ((beaconsfield airport) . ,(& 8 kilo meter))
		     ((airport beaconsfield) . ,(& 8 kilo meter))
		     ((airport logan) . ,(& 500 meter))
		     ((logan airport) . ,(& 500 meter))
		     ((laguardia laguardia-airport) . ,(& 500 meter))
		     ((laguardia-airport laguardia) . ,(& 500 meter))
		     ((laguardia-airport 57th-street) . ,(& 5 kilo meter))
		     ((57th-street laguardia-airport) . ,(& 5 kilo meter))
		     ((57th-street met) . ,(& 1 kilo meter))
		     ((met 57th-street) . ,(& 1 kilo meter))
		     )))
  )

(define (time-est trip-segment speed)
  (cond ((nothing? (trip-segment-start trip-segment))
	 nothing)
	((nothing? (trip-segment-end trip-segment))
	 nothing)
	(else
	 (make-estimate (/ (distance-est-f trip-segment) speed)))))
(propagatify time-est)

(define (same-city-f? trip-segment)
  ;; Really same-subway-network?
  (eq? (trip-segment-start trip-segment)
       (trip-segment-end trip-segment)))

(define same-city
  (function->propagator-constructor (nary-unpacking same-city-f?)))

(define (pick-airport place)
  (force-assoc place '((home . logan)
		       (logan . logan)
		       (south-station . logan)
		       (beaconsfield . logan)
		       (airport . logan)
		       (laguardia . laguardia)
		       (penn-station . laguardia)
		       (laguardia-airport . laguardia)
		       (57th-street . laguardia)
		       (met . laguardia))))
;; ditto pick-station, pick-stop
(propagatify pick-airport)

(define (airport-lookup segment)
  (force-assoc
   (cons (trip-segment-start segment)
	 (trip-segment-end segment))
   `(((logan . laguardia) .
      ,(make-trip-segment 'logan 'laguardia
	(& 4 hour) (& 432 dollar) (& 215 crap) 'fly))
     ;; TODO What's the right way to denote that one should not take
     ;; a plane to get from logan to logan?
     ((logan . logan) .
      ,(make-trip-segment 'logan 'logan
	(& 1 hour) (& 0 dollar) (& 0 crap) 'fly))
     ((laguardia . laguardia) .
      ,(make-trip-segment 'laguardia 'laguardia
	(& 1 hour) (& 0 dollar) (& 0 crap) 'fly))
     )))
(propagatify airport-lookup)

(define (pick-station place)
  (force-assoc place '((home . south-station)
		       (logan . south-station)
		       (south-station . south-station)
		       (beaconsfield . south-station)
		       (airport . south-station)
		       (laguardia . penn-station)
		       (penn-station . penn-station)
		       (laguardia-airport . penn-station)
		       (57th-street . penn-station)
		       (met . penn-station))))
(propagatify pick-station)

(define (station-lookup segment)
  (force-assoc
   (cons (trip-segment-start segment)
	 (trip-segment-end segment))
   `(((south-station . penn-station) .
      ,(make-trip-segment 'south-station 'penn-station
	(& 5 hour) (& 80 dollar) (& 25 crap) 'take-the-train))
     ;; TODO What's the right way to denote that one should not take
     ;; an intercity train to get from penn-station to penn-station?
     ((penn-station . penn-station) .
      ,(make-trip-segment 'penn-station 'penn-station
	(& 10 hour) (& 0 dollar) (& 0 crap) 'take-the-train))
     ((south-station . south-station) .
      ,(make-trip-segment 'south-station 'south-station
	(& 10 hour) (& 0 dollar) (& 0 crap) 'take-the-train))
     )))
(propagatify station-lookup)

(define (pick-stop place)
  (force-assoc place '((home . beaconsfield)
		       (beaconsfield . beaconsfield)
		       (logan . airport)
		       (airport . airport)
		       (south-station . south-station-under)
		       (south-station-under . south-station-under)
		       (laguardia . laguardia-airport)
		       (laguardia-airport . laguardia-airport)
		       (penn-station . 34th-street)
		       (34th-street . 34th-street)
		       (met . 57th-street) ;; Cheating; there are many, of course
		       (57th-street . 57th-street))))
(propagatify pick-stop)

(define (stop-lookup segment)
  (force-assoc
   (cons (trip-segment-start segment)
	 (trip-segment-end segment))
   `(((beaconsfield . airport) .
      ,(make-trip-segment 'beaconsfield 'airport
	(& 2 hour) (& 1.70 dollar) (& 15 crap) 'subway))
     ((beaconsfield . south-station-under) .
      ,(make-trip-segment 'beaconsfield 'south-station-under
	(& 1 hour) (& 1.70 dollar) (& 15 crap) 'subway))
     ((laguardia-airport . 57th-street) .
      ,(make-trip-segment 'laguardia-airport '57th-street
	(& 1 hour) (& 5 dollar) (& 20 crap) 'subway))
     ((34th-street . 57th-street) .
      ,(make-trip-segment '34th-street '57th-street
	(& 0.5 hour) (& 5 dollar) (& 10 crap) 'subway))
     ;; TODO How do I represent impossibility?
     ((beaconsfield . 57th-street) . 
      ,(make-trip-segment 'beaconsfield '57th-street
        (& (expt 10 10) hour) (& 0 dollar) (& 0 crap) 'subway))
     ((beaconsfield . 34th-street) . 
      ,(make-trip-segment 'beaconsfield '34th-street
        (& (expt 10 10) hour) (& 0 dollar) (& 0 crap) 'subway))
     ;; TODO How do I represent stupidity?
     ((beaconsfield . beaconsfield) .
      ,(make-trip-segment 'beaconsfield 'beaconsfield
	(& 1 hour) (& 0 dollar) (& 0 crap) 'subway))
     ((airport . airport) .
      ,(make-trip-segment 'airport 'airport
	(& 1 hour) (& 0 dollar) (& 0 crap) 'subway))
     ((south-station-under . south-station-under) .
      ,(make-trip-segment 'south-station-under 'south-station-under
	(& 1 hour) (& 0 dollar) (& 0 crap) 'subway))
     ((laguardia-airport . laguardia-airport) .
      ,(make-trip-segment 'laguardia-airport 'laguardia-airport
	(& 1 hour) (& 0 dollar) (& 0 crap) 'subway))
     ((57th-street . 57th-street) .
      ,(make-trip-segment '57th-street '57th-street
	(& 1 hour) (& 0 dollar) (& 0 crap) 'subway))
     ((34th-street . 34th-street) .
      ,(make-trip-segment '34th-street '34th-street
	(& 1 hour) (& 0 dollar) (& 0 crap) 'subway))
     )))
(propagatify stop-lookup)

;;; Hack for numerical estimates.  I should really do this with
;;; premises and proper truth maintenance

(define-structure estimate
  value)

(define (the-estimate thing)
  (if (estimate? thing)
      (estimate-value thing)
      thing))

(defhandler merge
  (lambda (estimate1 estimate2)
    (if (= (estimate-value estimate1)
	   (estimate-value estimate1))
	estimate1			; Redundant estimate
	estimate2			; Assume new one is better
	))
  estimate? estimate?)

(define (maybe-units? thing)
  ;; In case Mechanics isn't around
  (define (with-units? x)
    (and (pair? x)
	 (eq? (car x) '*with-units*)))
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

(defhandler generic-+
  (lambda (estimate1 estimate2)
    (make-estimate (generic-+ (estimate-value estimate1)
			      (estimate-value estimate2))))
  estimate? estimate?)

(defhandler generic-+
  (lambda (estimate value)
    (make-estimate (generic-+ (estimate-value estimate) value)))
  estimate? maybe-units?)

(defhandler generic-+
  (lambda (value estimate)
    (make-estimate (generic-+ value (estimate-value estimate))))
  maybe-units? estimate?)

(define (tag-not-estimate thing)
  (cond ((estimate? thing) (estimate-value thing))
	((trip-segment? thing)
	 (apply make-trip-segment
		(map tag-not-estimate
		     (map (lambda (accessor) (accessor thing))
			  (list trip-segment-start
				trip-segment-end
				trip-segment-time
				trip-segment-cost
				trip-segment-pain
				trip-segment-method)))))
	(else thing)))
(propagatify tag-not-estimate)

;; TODO What a hack!  My critic uses the estimate structure with a
;; number inside to have a overridable "method to elaborate" cell.
;; This also relies on consistent list indexing to work.
(define method-index the-estimate)

(define (find-best-method method-estimates)
  (let lp ((best-time #f)
	   (best-answer #f)
	   (current 0)
	   (to-check method-estimates))
    (cond ((null? to-check) best-answer)
	  ((or (nothing? (car to-check)) (nothing? (trip-segment-time (car to-check))))
	   (lp best-time best-answer (+ current 1) (cdr to-check)))
	  ((or (not best-time)
	       (unitable-<?
		(the-estimate (trip-segment-time (car to-check)))
		best-time))
	   (lp (the-estimate (trip-segment-time (car to-check)))
	       current
	       (+ current 1)
	       (cdr to-check)))
	  (else
	   (lp best-time best-answer (+ current 1) (cdr to-check))))))

(define (strip-units thing)
  (if (with-units? thing)
      (cadr thing)
      thing))

(define (unitable-<? thing1 thing2)
  (< (strip-units thing1) (strip-units thing2)))

(define (eql? const)
  (lambda (x)
    (eqv? x const)))

(defhandler merge
  (lambda (content increment) 'go-deep)
  (eql? 'go-fast) (eql? 'go-deep))

(defhandler merge
  (lambda (content increment) 'go-deep)
  (eql? 'go-deep) (eql? 'go-fast))

(define (deep-only go-command)
  (if (eq? 'go-deep go-command)
      go-command
      nothing))
(propagatify deep-only)
