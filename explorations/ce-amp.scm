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
     (= output-impedance
	(the resistance Rc)))
    
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

;;; Is this another way to write the same thing as the preceding form?
(define (ce-amplifier +rail -rail sigin sigout)
  (let-nodes (en bn cn)
    (let-cells (input-impedance output-impedance maximum-output-swing gain)
      (let ((Rb1 (named resistor 'Rb1)) ; This means Rb1 can be used many times
	    (Rb2 (named resistor 'Rb2))
	    (Rc  (named resistor 'Rc))
	    (Re  (named resistor 'Re))
	    (Cin (named capacitor 'Cin))
	    (Cout (named capacitor 'Cout))
	    (Q   (named NPN-bjt 'Q)))
	(Rb1 +rail bn)
	(Rb2 bn -rail)
	(Rc  +rail cn)
	(Re  en -rail)
	(Cin sigin bn)
	(Cout cn sigout)
	(Q NPN-bjt)
	(= gain (/ (the resistance Rc) (the resistance Re)))
	(= input-impedance (parallel (the resistance Rb1)
				     (the resistance Rb2)))
	(= output-impedance ...)
	(voltage-divider-slice Rb1 Rb2)
	))))

(define (ce-amplifier +rail -rail sigin sigout)
  (let-nodes (en bn cn)
    (let-cells (input-impedance output-impedance maximum-output-swing gain)
      (named
       (Rb1  (resistor  +rail bn))
       (Rb2  (resistor  bn -rail))
       (Rc   (resistor  +rail cn))
       (Re   (resistor  en -rail))
       (Cin  (capacitor sigin bn))
       (Cout (capacitor cn sigout))
       (Q    (NPN-bjt en bn cn)))
      (= gain (/ (the resistance Rc) (the resistance Re)))
      (= input-impedance (parallel (the resistance Rb1)
				   (the resistance Rb2)))
      (= output-impedance ...)
      (voltage-divider-slice Rb1 Rb2)
      )))

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

;;; Yet another theory.
(define (ce-amplifier)
  (let ((Rb1 (resistor))
	(Rb2 (resistor))
	(Rc  (resistor))
	(Re  (resistor))
	(Cin (capacitor))
	(Cout (capacitor))
	(Q (NPN-bjt))
	(+rail (make-cell))
	(-rail (make-cell)))
    (let ((+rail-node (node (the top Rb1) (the top Rc) (wire +rail)))
	  (-rail-node (node (the bottom Rb2) (the bottom Re) (wire -rail)))
	  (en (node (the top Re) (the emitter Q)))
	  (cn (node (the bottom Rc) (the top Cout) (the collector Q)))
	  (bn (node (the bottom Rb1) (the top Rb2) (the base Q)
		    (the bottom Cin)))
	  (sigin (the top Cin))
	  (sigout (the bottom Cout)))
      (let ((gain (/ (the resistance Rc) (the resistance Re)))
	    (input-impedance (parallel (the resistance Rb1)
				       (the resistance Rb2)))
	    (output-impedance ...)
	    (power (sum (map (the power) (list Rb1 Rb2 Rc Re Cin Cout Q)))))
	(voltage-divider-slice Rb1 Rb2)
	(inspectable-object
	 Rb1 Rb2 Rc Re Cin Cout Q +rail -rail sigin sigout
	 gain input-impedance output-impedance power ; Also nodes?
	 )))))

(define (breadboard)
  (let ((VCC (bias-voltage-source))
	(vin (signal-voltage-source))
	(vout (signal-voltage-probe))
	(amp (ce-amplifier)))
    (let ((gnd (node (the bottom VCC) (the bottom vin) (the bottom vout)
		     (the -rail amp)))
	  (+V (node (the top VCC) (the +rail amp)))
	  (in (node (the top vin) (the sigin amp)))
	  (out (node (the top vout) (the sigout amp)))))))

(define (ce-amplifier)
  (let ((+rail-node (node))
	(-rail-node (node))
	(en (node))
	(cn (node))
	(bn (node)))
    (let ((Rb1 (resistor (wire +rail-node) (wire bn)))
	  (Rb2 (resistor bn -rail-node))
	  (Rc  (resistor +rail-node cn))
	  (Re  (resistor en -rail-node))
	  (Cin (capacitor sigin bn))
	  (Cout (capacitor cn sigout))
	  (Q   (NPN-bjt en bn cn))))))

;;; It seems that there is no good way to avoid naming the terminals.
;;; The nodes are not like cells --- they desperately need to know how
;;; many things are attached to them.