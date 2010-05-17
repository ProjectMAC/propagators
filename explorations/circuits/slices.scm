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

(define-macro-propagator (terminal-equivalence ok? t1 t2)
  (conditional-wire ok? (ce:current t1) (ce:current t2))
  (conditional-wire ok? (ce:potential t1) (ce:potential t2)))

(define-macro-propagator (exact-voltage-divider-slice R1 node R2)
  ;; TODO Need to verify that (the t2 R1) and (the t1 R2) have a node
  ;; in common, and are the only terminals on that node
  (let-cells ((Requiv (resistor)))
    (c:+ (the resistance R1)
	 (the resistance R2)
	 (the resistance Requiv))
    (terminal-equivalence #t (the t1 R1) (the t1 Requiv))
    (terminal-equivalence #t (the t2 R2) (the t2 Requiv))))

(define (collect-premises thing)
  (cond ((tms? thing)
	 (delete-duplicates
	  (apply append (map v&s-support (tms-values thing))) eq?))
	((layered? thing)
	 (delete-duplicates
	  (apply append (map collect-premises
			     (map cdr (layered-alist thing)))) eq?))
	(else '())))

(define (premise-overrider premised)
  (let ((premises (filter kcl-premise? (collect-premises premised))))
    (if (null? premises)
	nothing
	(begin
	  (assert (= 1 (length premises)))
	  (pp (map kcl-premise-name premises))
	  (kick-out! (car premises))
	  #t))))
(name! premise-overrider 'premise-overrider)

(define p:override-premise (function->propagator-constructor premise-overrider))
(define e:override-premise (functionalize p:override-premise))

(define-macro-propagator (approximate-voltage-divider-slice R1 center R2 bottom)
  (let ((center-terminals (the-terminals center)))
    (assert (memq (the t2 R1) center-terminals))
    (assert (memq (the t1 R2) center-terminals))
    (let-cells ((Requiv (resistor))
		(leak (leakage-current))
		(fresh-t1)
		(fresh-t2)
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
      (let-cells ((new-center (apply node fresh-t1
				     (delq (the t1 R2)
					   (delq (the t2 R1)
						 center-terminals))))
		  (new-bottom (apply node fresh-t2 (the-terminals bottom))))
	(terminal-equivalence go? (the t1 leak) fresh-t1)
	(terminal-equivalence go? (the t2 leak) fresh-t2)))))

