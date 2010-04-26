;;; ----------------------------------------------------------------------
;;; Copyright 2010 Alexey Radul and Gerald Jay Sussman
;;; ----------------------------------------------------------------------
;;; This file is part of Propagator Network Prototype.
;;; 
;;; Propagator Network Prototype is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;; 
;;; Propagator Network Prototype is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;; 
;;; You should have received a copy of the GNU General Public License
;;; along with Propagator Network Prototype.  If not, see <http://www.gnu.org/licenses/>.
;;; ----------------------------------------------------------------------

(define (resistor-circuit)
  (let-cells ((R (resistor))
	      (V (voltage-source)))
    (let-cells ((n1 (node 'n1 (the t1 V) (the t1 R)))
		(n2 (node 'n2 (the t2 V) (the t2 R))))
      ((constant 3) (the resistance R))
      ((constant 6) (the strength V))
      ((constant 0) (the potential n2))
      (e:inspectable-object R V n1 n2))))

#|
 (initialize-scheduler)
 ;Value: 0

 (define-cell test (resistor-circuit))
 ;Value: test

 (define-cell answer (the current R test))
 ;Value: answer

 (run)
 ;Value: done

 (content answer)
 ;Value: #(tms (#(supported 2 ()))) ; Doesn't depend on KCL!

 (define-cell source-current (the current V test))
 ;Value: source-current

 (run)
 ;Value: done

 (content source-current)
 ;Value 24: #(tms (#(supported -2 (#(node-premise n2))) #(supported -2 (#(node-premise n1)))))
|#

(define (assert p #!optional irritant)
  (if (not p)
      (error "Assertion failed" irritant)))

(define (terminal-equivalence ok? t1 t2)
  (conditional-wire ok? (ce:current t1) (ce:current t2))
  (conditional-wire ok? (ce:potential t1) (ce:potential t2)))

(define (voltage-divider-slice R1 node R2)
  ;; TODO Need to verify that (the t2 R1) and (the t1 R2) have a node
  ;; in common.
  (define (allow-discrepancy capped-cell)
    (let ((premises
	   (apply append
		  (map v&s-support
		       (tms-values (content capped-cell))))))
      (assert (= 1 (length premises)))
      (assert (node-premise? (car premises)))
      (kick-out! (car premises))))
  (let-cells ((Requiv (resistor))
	      (ok? (e:< (e:abs (the residual node))
			(e:abs (e:* 1e-2 (the current R1))))))
    (allow-discrepancy (the capped? node))
    ;; Maybe this should really be guessing the value of the output
    ;; current...  And applying this model if it's zero...
    (binary-amb ok?)
    ;; TODO This assumes that this slice is the only one interested in
    ;; fiddling with the node's cap.
    (c:not ok? (the capped? node))
    (c:+ (the resistance R1)
	 (the resistance R2)
	 (the resistance Requiv))
    (terminal-equivalence ok? (the t1 R1) (the t1 Requiv))
    (terminal-equivalence ok? (the t2 R2) (the t2 Requiv))))

(define (voltage-divider-circuit)
  (let-cells ((R1 (resistor))
	      (R2 (resistor))
	      (V (voltage-source)))
    (let-cells ((n1 (node (the t1 V) (the t1 R1)))
		(n2 (node (the t2 R1) (the t1 R2)))
		(n3 (node (the t2 V) (the t2 R2))))
      ((constant 2) (the resistance R1))
      ((constant 4) (the resistance R2))
      ((constant 6) (the strength V))
      ((constant 0) (the potential n3))
      (e:inspectable-object R1 R2 V n1 n2 n3))))

#|
 (initialize-scheduler)
 ;Value: 0

 (define-cell test (voltage-divider-circuit))
 ;Value: test

 (define-cell answer (the potential n2 test))
 ;Value: answer

 (run)
 ;Value: done

 (content answer)
 ;Value: #(*the-nothing*)

 (voltage-divider-slice (the R1 test) (the n2 test) (the R2 test))
 ;Value: #f

 (run)
 ;Value: done
 
 (content answer)
 ;Value 34: #(tms (#(supported 4 (#(hypothetical)))))
|#

(define (voltage-divider-circuit-2)
  (let-cells ((R1 (resistor))
	      (R2 (resistor))
	      (load (resistor))
	      (V (voltage-source)))
    (let-cells ((n1 (node (the t1 V) (the t1 R1)))
		(n2 (node (the t2 R1) (the t1 R2) (the t1 load)))
		(n3 (node (the t2 V) (the t2 R2) (the t2 load))))
      ((constant 2) (the resistance R1))
      ((constant 4) (the resistance R2))
      ((constant 1000) (the resistance load))
      ((constant 6) (the strength V))
      ((constant 0) (the potential n3))
      (e:inspectable-object R1 R2 load V n1 n2 n3))))

#|
 (initialize-scheduler)
 ;Value: 0

 (define-cell test (voltage-divider-circuit-2))
 ;Value: test

 (define-cell answer (the potential n2 test))
 ;Value: answer

 (run)
 ;Value: done

 (content answer)
 ;Value: #(*the-nothing*)

 (voltage-divider-slice (the R1 test) (the n2 test) (the R2 test))
 ;Value: #f

 (run)
 ;Value: done
 
 (content answer)
 ;Value 34: #(tms (#(supported 4 (#(hypothetical)))))

 (define-cell load-current (the current load test))

 (run)

 (content load-current)
 ;Value 36: #(tms (#(supported 1/250 (#(hypothetical)))))
|#

(define (resistor-circuit-2)
  (let-cells ((R (resistor))
	      (V (bias-voltage-source)))
    (let-cells ((n1 (node 'n1 (the t1 V) (the t1 R)))
		(n2 (node 'n2 (the t2 V) (the t2 R))))
      ((constant 3) (the resistance R))
      ((constant 6) (the strength V))
      ((constant 0) (the potential n2))
      (e:inspectable-object R V n1 n2))))

#|
 (initialize-scheduler)
 ;Value: 0

 (define-cell test (resistor-circuit-2))
 ;Value: test

 (define-cell answer (the current R test))
 ;Value: answer

 (run)
 ;Value: done

 (content answer)
 ;Value 334: #[layered 334 (bias . #(tms (#(supported 2 ())))) (incremental . #(tms (#(supported 0 ()))))]

 (define-cell source-current (the current V test))
 ;Value: source-current

 (run)
 ;Value: done

 (content source-current)
 ;Value 335: #[layered 335 (bias . #(tms (#(supported -2 (#(node-premise n2))) #(supported -2 (#(node-premise n1)))))) (incremental . #(tms (#(supported 0 (#(node-premise n2))) #(supported 0 (#(node-premise n1))))))]
|#

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
	      (Q (infinite-beta-bjt))
	      (+rail-w (short-circuit +rail))
	      (-rail-w (short-circuit -rail)))
    (let-cells ((+rail-node (node (the t1 Rb1) (the t1 Rc) (the t2 +rail-w)))
		(-rail-node (node (the t2 Rb2) (the t2 Re) (the t2 -rail-w)))
		(en (node (the t1 Re) (the emitter Q)))
		(cn (node (the t2 Rc) (the t2 Cout) (the collector Q)))
		(bn (node (the t2 Rb1) (the t1 Rb2) (the base Q)
			  (the t2 Cin))))
      (let-cells ((gain (ce:* (the resistance Re) %% (the resistance Rc)))
		  (input-impedance (ce:parallel (the resistance Rb1)
						(the resistance Rb2)))
		  (output-impedance (the resistance Rc))#;
		  (power (sum (map (lambda (x) (the power x))
				   (list Rb1 Rb2 Rc Re Cin Cout Q)))))
	#; (voltage-divider-slice Rb1 bn Rb2)
	(e:inspectable-object
	 Rb1 Rb2 Rc Re Cin Cout Q +rail -rail sigin sigout
	 gain input-impedance output-impedance #;power ; Also nodes?
	 )))))

(define (breadboard)
  (let ((VCC (bias-voltage-source))
	(vin (signal-voltage-source))
	(vout (open-circuit))
	(amp (ce-amplifier)))
    (let ((gnd (node (the t2 VCC) (the t2 vin) (the t2 vout)
		     (the -rail amp)))
	  (+V (node (the t1 VCC) (the +rail amp)))
	  (in (node (the t1 vin) (the sigin amp)))
	  (out (node (the t1 vout) (the sigout amp))))
      ((constant 0) (the potential gnd))
      (e:inspectable-object VCC vin vout amp gnd +V in out))))

(define (ce:parallel resistance1 resistance2)
  (ce:* (ce:+ resistance1 resistance2) %% (ce:* resistance1 resistance2)))

#|
 (initialize-scheduler)
 (define-cell test (breadboard))

 (add-content (the resistance Rb1 amp test) 51000)
 (add-content (the resistance Rb2 amp test) 10000)
 (add-content (the resistance Re amp test) 1000)
 (add-content (the capacitance Cin amp test) 10e-6)
 (add-content (the capacitance Cout amp test) 10e-6)
 #;
 (add-content (the input-impedance amp test)
	      (lambda (z)
		(> (magnitude z) (& 5000 ohm))))

 (define-cell Rc-resistance (the resistance Rc amp test))
 (add-content Rc-resistance 5000)

 (define-cell gain (the gain amp test))
 #; (add-content gain 5)


 (add-content (the strength VCC test) 15)
 (add-content (the strength vin test) 1/10)

 (define-cell output (the voltage vout test))
 (define-cell Q-power (the power Q amp test))
     
 (run)

 #; (content Rc-resistance)
 ;;; Should be about (& 5000 ohm)
 (content gain)
 ;;; Should be about 5

 (content output)
 (content Q-power)
|#
