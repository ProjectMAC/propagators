;;; ----------------------------------------------------------------------
;;; Copyright 2009-2010 Alexey Radul.
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

(declare (usual-integrations make-cell))

(define (multiple-dwelling)
  (let ((floors '(1 2 3 4 5)))
    (let-cells (baker cooper fletcher miller smith
		      b=5 c=1 f=5 f=1 m>c sf fc one five s-f as-f f-c af-c)
     (one-of floors baker)       (one-of floors cooper)
     (one-of floors fletcher)    (one-of floors miller)
     (one-of floors smith)
     (require-distinct
      (list baker cooper fletcher miller smith))
     ((constant 1) one)        ((constant 5) five)
     (=? five baker b=5)       (forbid b=5)
     (=? one cooper c=1)       (forbid c=1)
     (=? five fletcher f=5)    (forbid f=5)
     (=? one fletcher f=1)     (forbid f=1)
     (>? miller cooper m>c)    (require m>c)
     (subtractor smith fletcher s-f)
     (absolute-value s-f as-f)
     (=? one as-f sf)          (forbid sf)
     (subtractor fletcher cooper f-c)
     (absolute-value f-c af-c)
     (=? one af-c fc)          (forbid fc)
     (list baker cooper fletcher miller smith))))
