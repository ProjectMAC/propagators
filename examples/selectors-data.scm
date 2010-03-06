(define-structure trip-segment
  start
  end
  time
  cost
  annoyance
  method)

(define (distance-est segment)
  ...)

(define (nearest-airport place)
  ...)

;; ditto nearest-station, nearest-stop

(define (same-city? segment)
  ;; Really same-subway-network?
  )

