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

(declare (usual-integrations make-cell cell?))

(define-structure 
  (kcl-premise (type vector) (named 'kcl-premise)
	       (print-procedure #f) (safe-accessors #t))
  name)

(define (node . terminals)
  (define name #!default)
  (if (and (not (null? terminals))
	   (not (cell? (car terminals))))
      (begin (set! name (car terminals))
	     (set! terminals (cdr terminals))))
  (let-cells (potential
	      (residual (reduce ce:+ 0 (map ce:current terminals)))
	      capped?)
    (add-content capped?
      (make-tms (supported #t (list (make-kcl-premise name)))))
    (apply c:== potential (map ce:potential terminals))
    (conditional-wire capped? residual 0)
    (let-cell terminal-list
      (add-content terminal-list terminals)
      (e:inspectable-object potential residual capped? terminal-list))))

(define (assert p #!optional irritant)
  (if (not p)
      (error "Assertion failed" irritant)))

;;; Because the propagator machine doesn't support lists of cells very
;;; well, this is a horrible hack.  User beware.
(define (the-terminals node-cell)
  (content (the terminal-list node-cell)))

(define (two-terminal-device vic)
  (let-cells (t1 t2 power)
    (let-cells ((et1 (ce:potential t1))
		(current (ce:current t1))
		(et2 (ce:potential t2))
		(it2 (ce:current t2)))
      (c:+ current it2 0)
      (let-cells ((voltage (ce:+ et2 %% et1)))
	(c:* current voltage power)
	(ce:append-inspectable-object
	 (vic voltage current)
	 t1 t2 power voltage current)))))

(define-macro-propagator (resistor)
  (let-cell resistance
    (two-terminal-device
     ;; TODO Properly propagatify this?
     (lambda (v i)
       (c:* i resistance v)
       (e:inspectable-object resistance)))))

(define (voltage-source-vic)
  (let-cell strength
    (lambda (v i)
      (c:== strength v)
      (e:inspectable-object strength))))

(define (short-circuit-vic v i)
  ((constant 0) v)
  (e:inspectable-object))

(define (open-circuit-vic v i)
  ((constant 0) i)
  (e:inspectable-object))

;; TODO Is leakage-current the right name for this?  It's a "two
;; terminal device" that places no additional constraint on its
;; terminals.  That is, it's willing to let any current flow at any
;; voltage.  This object is equivalent to a voltage source of
;; unconstrained strength, and to a current source of unconstrained
;; strength.
(define-macro-propagator (leakage-current)
  (two-terminal-device (lambda (v i) (e:inspectable-object))))

(define-macro-propagator (voltage-source)
  (two-terminal-device (voltage-source-vic)))

(define (use-all . functions)
  (lambda args
    ;; TODO Fix this poor handling of the inspectable objects
    ;; produced by the various layer functions
    (car (map (lambda (f)
		(apply f args))
	      functions))))

(define-macro-propagator (bias-voltage-source)
  (two-terminal-device
    (use-all
     (in-layer 'bias (voltage-source-vic))
     (in-layer 'incremental short-circuit-vic))))

(define-macro-propagator (signal-voltage-source)
  (two-terminal-device
    (use-all
     (in-layer 'incremental (voltage-source-vic))
     (in-layer 'bias short-circuit-vic))))

(define-macro-propagator (short-circuit)
  (two-terminal-device short-circuit-vic))

(define-macro-propagator (open-circuit)
  (two-terminal-device open-circuit-vic))

(define-macro-propagator (capacitor)
  (two-terminal-device
    (use-all
     (in-layer 'bias open-circuit-vic)
     (in-layer 'incremental short-circuit-vic))))

(define-macro-propagator (inductor)
  (two-terminal-device
    (use-all
     (in-layer 'incremental open-circuit-vic)
     (in-layer 'bias short-circuit-vic))))

(define (three-terminal-device common control controlled vic)
  (let-cells (power
	      (e-common (ce:potential common))
	      (i-common (ce:current common))
	      (e-control (ce:potential control))
	      (i-control (ce:current control))
	      (e-controlled (ce:potential controlled))
	      (i-controlled (ce:current controlled)))
    (c:+ (ce:+ i-common i-control) i-controlled 0)
    (let-cells ((control-voltage (ce:+ e-common %% e-control))
		(controlled-voltage (ce:+ e-common %% e-controlled)))
      (c:+ (ce:* control-voltage i-control)
	   (ce:* controlled-voltage i-controlled)
	   power)
      (ce:append-inspectable-object
       (vic control-voltage i-control controlled-voltage i-controlled)
       common control controlled power))))

(define-macro-propagator (infinite-beta-bjt)
  (let-cells (emitter base collector)
   (three-terminal-device emitter base collector
     (lambda (control-voltage control-current
			      controlled-voltage controlled-current)
       ((in-layer 'bias (constant 0.6)) control-voltage)
       ((in-layer 'incremental (constant 0)) control-voltage)
       ((constant 0) control-current)
       (e:inspectable-object emitter base collector)))))
