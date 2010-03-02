(define (plan-trip go? source destination method cost time annoyance)
  (let-cells (in-method in-cost in-time in-annoyance)
    (let-cells (air-go? train-go? bus-go?)
      ;; TODO Attach the premises somewhere
      (air-travel   air-go?   source destination in-method in-cost in-time in-annoyance)
      (train-travel train-go? source destination in-method in-cost in-time in-annoyance)
      (bus-travel   bus-go?   source destination in-method in-cost in-time in-annoyance)#;
      (car-travel      source destination in-method in-cost in-time in-annoyance)#;
      (subway-travel   source destination in-method in-cost in-time in-annoyance)#;
      (city-bus-travel source destination in-method in-cost in-time in-annoyance)#;
      (taxi-travel     source destination in-method in-cost in-time in-annoyance)#;
      (bicycle-travel  source destination in-method in-cost in-time in-annoyance)#;
      (walking-travel  source destination in-method in-cost in-time in-annoyance)
      (critic go? in-cost in-time in-annoyance air-go? train-go? bus-go?)
      (combiner go? in-method method in-cost cost in-time time in-annoyance annoyance)
      (go-inherit go? air-go? train-go? bus-go?))))

(define (air-travel go? source destination method cost time annoyance)
  ((const 'air) method)
  ((const 'about-100) cost)
  ((const 'about-a-day) time)
  ((const 'big) annoyance)
  
  )

;;; This is turning into a lazily expanded and-or tree (maybe dag if
;;; there are good opportunities for memoization), with instant
;;; estimates at each node.  The critics select which branch of an or
;;; looks the most promising to explore.  It also seems as though I
;;; want to segregate alternatives with premises in shared cells, and
;;; segregate conjuncts with separate cells.
