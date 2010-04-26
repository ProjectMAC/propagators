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

(define-structure 
  (node-premise (type vector) (named 'node-premise)
                (print-procedure #f) (safe-accessors #t))
  name)

(define (node . terminals)
  (define name #!default)
  (if (and (not (null? terminals))
	   (not (cell? (car terminals))))
      (begin (set! name (car terminals))
	     (set! terminals (cdr terminals))))
  (let-cells (potential
	      (residual
	       (reduce ce:+ (e:constant 0) (map ce:current terminals)))
	      capped?)
    (add-content capped?
      (make-tms (supported #t (list (make-node-premise name)))))
    (apply c:== potential (map ce:potential terminals))
    (conditional-wire capped? residual (e:constant 0))
    (e:inspectable-object potential residual capped?)))

(define (two-terminal-device #!optional t1 t2 power vic)
  (if (default-object? t1)
      (set! t1 (make-cell)))
  (if (default-object? t2)
      (set! t2 (make-cell)))
  ;; TODO Flush this: vic is not (currently) supposed to be a cell
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

(define (voltage-source-vic #!optional strength)
  (if (default-object? strength)
      (set! strength (make-cell)))
  (lambda (v i)
    (c:== strength v)
    (e:inspectable-object strength)))

(define (short-circuit-vic v i)
  ((constant 0) v)
  (e:inspectable-object))

(define (voltage-source #!optional t1 t2 strength power)
  (two-terminal-device t1 t2 power (voltage-source-vic strength)))

(define (use-all . functions)
  (lambda args
    ;; TODO Fix this poor handling of the inspectable objects
    ;; produced by the various layer functions
    (car (map (lambda (f)
		(apply f args))
	      functions))))

(define (bias-voltage-source #!optional t1 t2 strength power)
  (two-terminal-device t1 t2 power
    (use-all
     (in-layer 'bias (voltage-source-vic strength))
     (in-layer 'incremental short-circuit-vic))))

(define (signal-voltage-source #!optional t1 t2 strength power)
  (two-terminal-device t1 t2 power
    (use-all
     (in-layer 'incremental (voltage-source-vic strength))
     (in-layer 'bias short-circuit-vic))))
