;;; Some thoughts about an electrical circuit language over
;;; propagators.

(define (capacitor t1 t2)

  (let-cells (capacitance)
	     
    (two-terminal-device t1 t2
      (lambda (v i)
        (time-domain
	 (lambda (t)
	   (= (i t)
	      (* (the capacitance)
		 ((D v) t)))))

	(frequency-domain
	 (lambda (s)
	   (= (i s)
	      (* s
		 (the capacitance)
		 (v s)))))

	(bias (= i 0))

	(incremental (= v 0))))))
  



(define (ce-amplifier +rail -rail sigin sigout)
  (circuit (en bn cn)
	   (input-impedance
	    output-impedance
	    maximum-output-swing
	    gain)
    (approximation
     (= gain
	(/ (the resistance Rc)
	   (the resistance Re)))
     (= input-impedance
	(parallel (the resistance Rb1)
		  (the resistance Rb2)))
     (= output-impedance ...))
    
    (hint
     (s1 (slice voltage-divider Rb1 Rb2)))

    (parts
     (Rb1  (resistor  +rail bn))
     (Rb2  (resistor  bn -rail))
     (Rc   (resistor  +rail cn))
     (Re   (resistor  en -rail))
     (Cin  (capacitor sigin bn))
     (Cout (capacitor cn sigout))
     (Q    (NPN-bjt en bn cn))
     )
    ))

(define (breadboard)
  (circuit (+V gnd in out) ()
    (parts
     (VCC (bias-voltage-source +V gnd))
     (vin (signal-voltage-source in gnd))
     (vout (signal-voltage-probe out gnd))
     (amp (ce-amplifier +V gnd in out))
     )))

#|
(define-circuit test (breadboard))

(add-content (the resistance Rb1 amp test) (& 51000 ohm))
(add-content (the resistance Rb2 amp test) (& 10000 ohm))
(add-content (the resistance Rb1 amp test) (& 1000 ohm))
(add-content (the capacitance Cin amp test) (& 10e-6 farad))
(add-content (the capacitance Cout amp test) (& 10e-6 farad))

(add-content (the input-impedance amp test)
	     (lambda (z)
	       (> (magnitude z) (& 5000 ohm))))

(add-content (the gain amp test) 5)


(add-content (the strength VCC test) (& 15 volt))
(add-content (the incremental strength vin test) (& 0.1 volt))

(run)

(content (the resistance Rc amp test))
;;; Should be about (& 5000 ohm)

(content (the incremental voltage vout test))
(content (the power Q amp test))

|#

