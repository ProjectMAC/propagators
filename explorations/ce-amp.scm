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

(define (resistor #!optional t1 t2 resistance power)
  (if (default-object? resistance)
      (set! resistance (make-cell)))
  (two-terminal-device t1 t2 power
    ;; TODO Properly propagatify this?
    (lambda (v i)
      (c:* i resistance v)
      (e:inspectable-object resistance))))

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
    (let-cells ((voltage (e:- et1 et2)))
      (c:* current voltage power)
      (ce:append-inspectable-object
       (vic voltage current)
       t1 t2 power voltage current))))

(define (voltage-source #!optional t1 t2 strength power)
  (if (default-object? strength)
      (set! strength (make-cell)))
  (two-terminal-device t1 t2 power
    (lambda (v i)
      (c:== strength v)
      (e:inspectable-object strength))))

(define-structure
  (element-descriptor
   (print-procedure
    (simple-unparser-method
     'e-d (lambda (ed)
	    (element-descriptor-alist ed)))))
  alist)

(define (make-element-descriptor-from . names)
  (name!
   (lambda items
     (make-element-descriptor (map cons names items)))
   `(make-element-descriptor-from ,@names)))

(define (element-descriptor-lookup name desc)
  (let ((mumble (assq name (element-descriptor-alist desc))))
    (if mumble
	(cdr mumble)
	nothing)))

(define (element-descriptor-get name)
  (name!
   (lambda (ed)
     (element-descriptor-lookup name ed))
   `(element-descriptor-get ,name)))

(define (append-element-descriptor ed1 ed2)
  (make-element-descriptor
   (append (element-descriptor-alist ed1)
	   (element-descriptor-alist ed2))))
(propagatify append-element-descriptor)

(define (filter-element-descriptor names)
  (name!
   (lambda (desc)
     (make-element-descriptor
      (filter (lambda (pair)
		(memq (car pair) names))
	      (element-descriptor-alist desc))))
   `(filter-for ,@names)))

(define (filter-out-element-descriptor names)
  (name!
   (lambda (desc)
     (make-element-descriptor
      (filter (lambda (pair)
		(not (memq (car pair) names)))
	      (element-descriptor-alist desc))))
   `(filter-out ,@names)))

(define (merge-element-descriptors ed1 ed2)
  (make-element-descriptor
   (merge-alist (element-descriptor-alist ed1)
		(element-descriptor-alist ed2))))

(define (element-descriptor-equal? ed1 ed2)
  (same-alist? (element-descriptor-alist ed1)
	       (element-descriptor-alist ed2)))

(define (same-alist? alist1 alist2)
  (lset= (lambda (pair1 pair2)
	   (and (eq? (car pair1) (car pair2))
		(equivalent? (cdr pair1) (cdr pair2))))
	 alist1 alist2))

(define (merge-alist alist1 alist2)
  (let ((keys (lset-union eq? (map car alist1) (map car alist2))))
    (define (get key alist)
      (let ((binding (assq key alist)))
	(if binding
	    (cdr binding)
	    nothing)))
    (map (lambda (key)
	   (cons key (merge (get key alist1) (get key alist2))))
	 keys)))

(defhandler merge
  (with-equality merge-element-descriptors element-descriptor-equal?)
  element-descriptor? element-descriptor?)

(define (function->unpacking->propagator-constructor f)
  (function->propagator-constructor
   (nary-unpacking f)))

(define-syntax e:inspectable-object
  (syntax-rules ()
    ((_ name ...)
     (e:inspectable-object-func (list 'name ...)
				(list name ...)))))

(define (e:inspectable-object-func names things)
  (let ((answer (make-named-cell 'cell)))
    (apply
     (function->propagator-constructor
      (apply make-element-descriptor-from names))
     (append things (list answer)))
    (for-each
     (lambda (name thing)
       ((function->unpacking->propagator-constructor
	 (element-descriptor-get name))
	answer thing))
     names things)
    answer))

(define-syntax ce:append-inspectable-object
  (syntax-rules ()
    ((_ sub-object name ...)
     (ce:append-inspectable-object-func
      (list 'name ...)
      sub-object
      (e:inspectable-object name ...)))))

(define (ce:append-inspectable-object-func names sub-object addition)
  (let ((answer (make-named-cell 'cell)))
    (p:append-element-descriptor sub-object addition answer)
    ((function->unpacking->propagator-constructor
      (filter-element-descriptor names))
     answer addition)
    ((function->unpacking->propagator-constructor
      (filter-out-element-descriptor names))
     answer sub-object)
    answer))

(define-syntax the
  (syntax-rules ()
    ((_ thing)
     thing)
    ((_ name form ...)
     (the-func 'name (the form ...)))))

(define (the-func name thing)
  (let ((answer (make-named-cell 'cell)))
    ((function->unpacking->propagator-constructor
      (element-descriptor-get name))
     thing answer)
    ((function->propagator-constructor
      (make-element-descriptor-from name))
     answer thing)
    answer))

(define (resistor-circuit)
  (let-cells ((R (resistor))
	      (V (voltage-source)))
    (let-cells ((n1 (node (the t1 V) (the t1 R)))
		(n2 (node (the t2 V) (the t2 R))))
      ((constant 6) (the strength V))
      ((constant 0) (the potential n2))
      (e:inspectable-object R V n1 n2))))

(define (node . terminals)
  ((constant 0) (reduce ce:+ (e:constant 0) (map ce:current terminals)))
  (let-cell potential
    (apply c:== potential (map ce:potential terminals))
    (e:inspectable-object potential)))

(define-structure
  (terminal
   (print-procedure
    (simple-unparser-method
     'terminal (lambda (terminal)
		 (list (terminal-potential terminal)
		       (terminal-current terminal)))))
   (constructor make-terminal)
   (constructor make-terminal-from-potential (potential))
   (constructor make-terminal-from-current (current)))
  (potential nothing)
  (current nothing))

(slotful-information-type
 terminal? make-terminal terminal-potential terminal-current)

(propagatify terminal-potential)
(propagatify terminal-current)

(propagatify make-terminal)
(propagatify make-terminal-from-potential)
(propagatify make-terminal-from-current)

(define (c:potential terminal potential)
  (p:terminal-potential terminal potential)
  (p:make-terminal-from-potential potential terminal))

(define ce:potential (functionalize c:potential))

(define (c:current terminal current)
  (p:terminal-current terminal current)
  (p:make-terminal-from-current current terminal))

(define ce:current (functionalize c:current))
