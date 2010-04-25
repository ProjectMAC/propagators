(define (node . terminals)
  ((constant 0) (reduce ce:+ (e:constant 0) (map ce:current terminals)))
  (let-cell potential
    (apply c:== potential (map ce:potential terminals))
    (e:inspectable-object potential)))

(define (two-terminal-device #!optional t1 t2 power vic)
  (if (default-object? t1)
      (set! t1 (make-cell)))
  (if (default-object? t2)
      (set! t2 (make-cell)))
  (if (default-object? vic)
      (set! vic (make-cell)))
  (if (default-object? power)
      (set! power (make-cell)))
  (let-cells ((et1 (ce:potential t1))
	      (current (ce:current t1))
	      (et2 (ce:potential t2))
	      (it2 (ce:current t2)))
    (c:+ current it2 (e:constant 0))
    (let-cells ((voltage (ce:+ et2 %% et1)))
      (c:* current voltage power)
      (ce:append-inspectable-object
       (vic voltage current)
       t1 t2 power voltage current))))

(define (resistor #!optional t1 t2 resistance power)
  (if (default-object? resistance)
      (set! resistance (make-cell)))
  (two-terminal-device t1 t2 power
    ;; TODO Properly propagatify this?
    (lambda (v i)
      (c:* i resistance v)
      (e:inspectable-object resistance))))

(define (voltage-source #!optional t1 t2 strength power)
  (if (default-object? strength)
      (set! strength (make-cell)))
  (two-terminal-device t1 t2 power
    (lambda (v i)
      (c:== strength v)
      (e:inspectable-object strength))))
