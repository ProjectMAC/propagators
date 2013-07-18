;;; ----------------------------------------------------------------------
;;; Copyright 2009-2010 Alexey Radul.
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

(define-method generic-match ((pattern <vector>) (object rtd:effectful))
  (generic-match
   pattern
   (vector 'effectful (effectful-info object)
	   (effectful-effects object))))

;;; Test slotful structure

(define-structure (kons (constructor kons))
  kar
  kdr)
(declare-type-tester kons? rtd:kons)

(slotful-information-type kons? kons kons-kar kons-kdr)

(define-method generic-match ((pattern <vector>) (object rtd:kons))
  (generic-match
   pattern
   (vector 'kons (kons-kar object) (kons-kdr object))))

(define-method generic-match ((pattern <vector>) (object rtd:%interval))
  (generic-match
   pattern
   (vector 'interval (interval-low object) (interval-high object))))

(define-method generic-match ((pattern <vector>) (object rtd:nogood-effect))
  (generic-match
   pattern
   (vector 'nogood-effect (nogood-effect-nogood object))))

(define-method generic-match ((pattern <vector>) (object <vector>))
  ;; Account for v&ses and tmses, as well as standard vectors.
  (define (match-vectors pattern object)
    (and (= (vector-length pattern) (vector-length object))
         (reduce boolean/and #t (map generic-match
				(vector->list pattern)
				(vector->list object)))))
  (define (match-v&s pattern object)
    ;; vector-ref because the patterns are often explicit vectors
    ;; (rather than v&s objects) which are too short, so they don't
    ;; pass the checks performed by the safe accessors.
    (and (generic-match (vector-ref pattern 1) (v&s-value object))
         (generic-match (sort (vector-ref pattern 2) premise<?)
                        (v&s-support object))
         ;; Ignore the informants
         ))
  (define (match-tms pattern object)
    ;; TODO Canonicalize the order of appearance of v&ses.
    (generic-match (tms-values pattern)
                   (tms-values object)))
  (cond ((or (< (vector-length pattern) 1)
             (< (vector-length object) 1))
         (match-vectors pattern object))
        ((and (eq? (vector-ref pattern 0) 'supported)
              (eq? (vector-ref object 0) 'supported))
         (match-v&s pattern object))
        ((and (eq? (vector-ref pattern 0) 'tms)
              (eq? (vector-ref object 0) 'tms))
         (match-tms pattern object))
        (else (match-vectors pattern object))))
