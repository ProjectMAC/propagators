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

;;; Some code snippets for God's-eye TMSes, lest I forget them.

(defhandler generic-flatten
  (lambda (v&s)
    (generic-flatten
     (make-tms (map (lambda (sub-v&s)
                      (generic-flatten
                       (supported sub-v&s (v&s-support v&s))))
                    (tms-values (v&s-value v&s))))))
  (lambda (thing) (and (v&s? thing) (tms? (v&s-value thing)))))


(defhandler generic-flatten
  (lambda (tms)
    (let ((candidates
           (apply append
                  (map tms-values
                       (map ->tms
                            (filter (lambda (x) (not (nothing? x)))
                                    (map generic-flatten (tms-values tms))))))))
      (if (null? candidates)
          nothing
          (make-tms candidates))))
  tms?)

;;; I am tempted to use this for the ant's-eye tms flatten, but it
;;; doesn't actually work, because TMSes given to flatten don't
;;; actually obey the TMS invariants.
(defhandler generic-flatten
  (lambda (tms)
    (let ((candidate (generic-flatten (tms-query tms))))
      (if (nothing? candidate)
          nothing
          (make-tms candidate))))
  tms?)

