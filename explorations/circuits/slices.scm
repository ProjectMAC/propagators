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

(declare (usual-integrations make-cell cell?))

(define-propagator (terminal-equivalence ok? t1 t2)
  (conditional-wire ok? (ce:current t1) (ce:current t2))
  (conditional-wire ok? (ce:potential t1) (ce:potential t2)))
(define terminal-equivalence p:terminal-equivalence)

(define-propagator (exact-voltage-divider-slice R1 node R2)
  ;; TODO Need to verify that (the t2 R1) and (the t1 R2) have a node
  ;; in common, and are the only terminals on that node
  (let-cells ((Requiv (resistor)))
    (c:+ (the resistance R1)
	 (the resistance R2)
	 (the resistance Requiv))
    (terminal-equivalence #t (the t1 R1) (the t1 Requiv))
    (terminal-equivalence #t (the t2 R2) (the t2 Requiv))))
(define exact-voltage-divider-slice p:exact-voltage-divider-slice)

(define (collect-premises thing)
  (cond ((tms? thing)
	 (delete-duplicates
	  (apply append (map v&s-support (tms-values thing))) eq?))
	((layered? thing)
	 (delete-duplicates
	  (apply append (map collect-premises
			     (map cdr (layered-alist thing)))) eq?))
	(else '())))

(define (override-premise premised)
  (let ((premises (filter kcl-premise? (collect-premises premised))))
    (if (null? premises)
	nothing
	(begin
	  (assert (= 1 (length premises)))
	  ; (pp (map kcl-premise-name premises))
	  (kick-out! (car premises))
	  #t))))
(propagatify-raw override-premise)

(define-propagator (approximate-voltage-divider-slice R1 center R2 bottom)
  (let ((center-terminals (the-terminals center)))
    (assert (memq (the t2 R1) center-terminals))
    (assert (memq (the t1 R2) center-terminals))
    (let-cells ((Requiv (resistor))
		(approximation-ok?
		 (e:< (e:abs (the residual center))
		      (e:abs (e:* 1e-2 (the current R1)))))
		(go?))
      (p:and (e:and (e:override-premise (the capped? center))
		    (e:override-premise (the capped? bottom)))
	     approximation-ok?
	     go?)
      (binary-amb approximation-ok?)
      ;; TODO Is this the right way to restore the node caps if the
      ;; approximation is wrong?  This is also assuming that no one
      ;; else is interested in these nodes' caps...
      (c:not go? (the capped? center))
      (c:not go? (the capped? bottom))
      (c:+ (the resistance R1)
	   (the resistance R2)
	   (the resistance Requiv))
      (terminal-equivalence go? (the t1 R1) (the t1 Requiv))
      (terminal-equivalence go? (the t2 R2) (the t2 Requiv))
      (let-cells* ((leak (leakage-current))
		   (fresh-t1)
		   (fresh-t2)
		   (new-center (apply node fresh-t1
				      (delq (the t1 R2)
					    (delq (the t2 R1)
						  center-terminals))))
		   (new-bottom (apply node fresh-t2 (the-terminals bottom))))
	(terminal-equivalence go? (the t1 leak) fresh-t1)
	(terminal-equivalence go? (the t2 leak) fresh-t2)))))
(define approximate-voltage-divider-slice p:approximate-voltage-divider-slice)

(define ((model-terminal-equivalence model)
	 ok? general-terminal model-terminal)
  (conditional-wire
   ok? ((ce:layered-get model) (ce:potential general-terminal))
   (ce:potential model-terminal))
  (conditional-wire
   ok? ((ce:layered-get model) (ce:current general-terminal))
   (ce:current model-terminal)))

(define ((model-exact-voltage-divider-slice model) R1 node R2)
  ;; TODO Need to verify that (the t2 R1) and (the t1 R2) have a node
  ;; in common, and are the only terminals on that node
  (let-cells ((Requiv (resistor)))
    (c:+ (the resistance R1)
	 (the resistance R2)
	 (the resistance Requiv))
    ((model-terminal-equivalence model) #t (the t1 R1) (the t1 Requiv))
    ((model-terminal-equivalence model) #t (the t2 R2) (the t2 Requiv))))
