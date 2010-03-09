
(define-macro-propagator (fast-air-estimate segment)
  (let-cells (same-city? same-city-answer intercity-answer)
    (same-city segment same-city?)
    (conditional same-city? same-city-answer intercity-answer segment)
    (conditional-writer same-city? segment same-city-answer intercity-answer)
    (fast-incity-air-estimate same-city-answer)
    (fast-intercity-air-estimate intercity-answer)))
