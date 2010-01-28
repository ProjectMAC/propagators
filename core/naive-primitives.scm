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

(declare (usual-integrations make-cell))


(define adder (function->propagator-constructor (handling-nothings +)))
(define subtractor (function->propagator-constructor (handling-nothings -)))
(define multiplier (function->propagator-constructor (handling-nothings *)))
(define divider (function->propagator-constructor (handling-nothings /)))

(define absolute-value
  (function->propagator-constructor (handling-nothings abs)))
(define squarer
  (function->propagator-constructor (handling-nothings square)))
(define sqrter
  (function->propagator-constructor (handling-nothings sqrt)))

(define =? (function->propagator-constructor (handling-nothings =)))
(define <? (function->propagator-constructor (handling-nothings <)))
(define >? (function->propagator-constructor (handling-nothings >)))
(define <=? (function->propagator-constructor (handling-nothings <=)))
(define >=? (function->propagator-constructor (handling-nothings >=)))

(define inverter
  (function->propagator-constructor (handling-nothings not)))
(define conjoiner
  (function->propagator-constructor (handling-nothings boolean/and)))
(define disjoiner
  (function->propagator-constructor (handling-nothings boolean/or)))
