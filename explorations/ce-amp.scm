;;; ----------------------------------------------------------------------
;;; Copyright 2010 Alexey Radul and Gerald Jay Sussman
;;; ----------------------------------------------------------------------
;;; This file is part of Propagator Network Prototype.
;;; 
;;; Propagator Network Prototype is free software; you can
;;; redistribute it and/or modify it under the terms of the GNU
;;; General Public License as published by the Free Software
;;; Foundation, either version 3 of the License, or (at your option)
;;; any later version.
;;; 
;;; Propagator Network Prototype is distributed in the hope that it
;;; will be useful, but WITHOUT ANY WARRANTY; without even the implied
;;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;;; See the GNU General Public License for more details.
;;; 
;;; You should have received a copy of the GNU General Public License
;;; along with Propagator Network Prototype.  If not, see
;;; <http://www.gnu.org/licenses/>.
;;; ----------------------------------------------------------------------

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
(define (ce-amplifier #!optional sigin sigout +rail -rail)
  (if (default-object? +rail)
      (set! +rail (make-cell)))
  (if (default-object? -rail)
      (set! -rail (make-cell)))
  (if (default-object? sigin)
      (set! sigin (make-cell)))
  (if (default-object? sigout)
      (set! sigout (make-cell)))
  (let-cells ((Rb1 (resistor))
	      (Rb2 (resistor))
	      (Rc  (resistor))
	      (Re  (resistor))
	      (Cin (capacitor sigin))
	      (Cout (capacitor sigout))
	      (Q (NPN-bjt)))
    (let-cells ((+rail-node (node (the t1 Rb1) (the t1 Rc) (wire +rail)))
		(-rail-node (node (the t2 Rb2) (the t2 Re) (wire -rail)))
		(en (node (the t1 Re) (the emitter Q)))
		(cn (node (the t2 Rc) (the t2 Cout) (the collector Q)))
		(bn (node (the t2 Rb1) (the t1 Rb2) (the base Q)
			  (the t2 Cin))))
      (let-cells ((gain (ce:/ (the resistance Rc) (the resistance Re)))
		  (input-impedance (ce:parallel (the resistance Rb1)
						(the resistance Rb2)))
		  (output-impedance (the resistance Rc))
		  (power (sum (map (lambda (x) (the power x))
				   (list Rb1 Rb2 Rc Re Cin Cout Q)))))
	(voltage-divider-slice Rb1 Rb2)
	(e:inspectable-object
	 Rb1 Rb2 Rc Re Cin Cout Q +rail -rail sigin sigout
	 gain input-impedance output-impedance power ; Also nodes?
	 )))))

(define (breadboard)
  (let ((VCC (bias-voltage-source))
	(vin (signal-voltage-source))
	(vout (signal-voltage-probe))
	(amp (ce-amplifier)))
    (let ((gnd (node (the t2 VCC) (the t2 vin) (the t2 vout)
		     (the -rail amp)))
	  (+V (node (the t1 VCC) (the +rail amp)))
	  (in (node (the t1 vin) (the sigin amp)))
	  (out (node (the t1 vout) (the sigout amp))))
      (e:inspectable-object VCC vin vout amp gnd +V in out))))

