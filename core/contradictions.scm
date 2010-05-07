;;; ----------------------------------------------------------------------
;;; Copyright 2009 Massachusetts Institute of Technology.
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

(define (tms-merge tms1 tms2)
  (let ((candidate (tms-assimilate tms1 tms2)))
    (let ((consequence (strongest-consequence candidate)))
      (check-consistent! consequence)   ; **
      (tms-assimilate candidate consequence))))

(define (tms-merge tms1 tms2)
  (let ((candidate (tms-assimilate tms1 tms2)))
    (effectful-bind (strongest-consequence candidate)
      (lambda (consequence)
	(if (not (contradictory? consequence))
	    (tms-assimilate candidate consequence)
	    (make-effectful
	     candidate
	     (make-nogood-effect
	      (list (v&s-support consequence)))))))))

(define (tms-query tms)
  (let ((answer (strongest-consequence tms)))
    (let ((better-tms (tms-assimilate tms answer)))
      (if (not (eq? tms better-tms))
          (set-tms-values! tms (tms-values better-tms)))
      (check-consistent! answer)        ; **
      answer)))

(define (check-consistent! v&s)
  (if (contradictory? v&s)
      (process-nogood! (v&s-support v&s))))

;; Will be replaced by process-nogood! in search.scm
(define (process-nogood! nogood)
  (abort-process `(contradiction ,nogood)))

(define-structure nogood-effect
  nogoods)

(defhandler execute-effect
  (lambda (nogood-effect)
    (map (lambda (nogood)
	   (if (all-premises-in? nogood)
	       (process-nogood! nogood)))
	 (nogood-effect-nogoods nogood-effect)))
  nogood-effect?)

(defhandler append-effects
  (lambda (nge1 nge2)
    (make-nogood-effect
     (append (nogood-effect-nogoods nge1)
	     (nogood-effect-nogoods nge2))))
  nogood-effect? nogood-effect?)

(define-method generic-match ((pattern <vector>) (object rtd:nogood-effect))
  (generic-match
   pattern
   (vector 'nogood-effect (nogood-effect-nogoods object))))
