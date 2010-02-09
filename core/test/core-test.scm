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

(in-test-group
 core

 (define-test (temperature1)
   (interaction
    (initialize-scheduler)
    (define-cell f)
    (define-cell c)

    (fahrenheit->celsius f c)

    (add-content f 77)
    (run)
    (content c)
    (produces 25)
    ))

 (define-test (temperature2)
   (interaction
    (initialize-scheduler)
    (define-cell f)
    (define-cell c)

    (fahrenheit-celsius f c)

    (add-content c 25)
    (run)
    (content f)
    (produces 77)

    (define-cell k)

    (celsius-kelvin c k)
    (run)
    (content k)
    (produces 298.15)
    ))

 (define-test (barometer-fall-time)
   (interaction
    (initialize-scheduler)
    (define-cell fall-time)
    (define-cell building-height)
    (fall-duration fall-time building-height)

    (add-content fall-time (make-interval 2.9 3.1))
    (run)
    (content building-height)
    (produces #(interval 41.163 47.243))
    ))

 (define-test (barometer)
   (interaction
    (initialize-scheduler)
    (define-cell barometer-height)
    (define-cell barometer-shadow)
    (define-cell building-height)
    (define-cell building-shadow)
    (similar-triangles barometer-shadow barometer-height
		       building-shadow building-height)

    (add-content building-shadow (make-interval 54.9 55.1))
    (add-content barometer-height (make-interval 0.3 0.32))
    (add-content barometer-shadow (make-interval 0.36 0.37))
    (run)
    (content building-height)
    (produces #(interval 44.514 48.978))

    (define-cell fall-time)
    (fall-duration fall-time building-height)

    (add-content fall-time (make-interval 2.9 3.1))
    (run)
    (content building-height)
    (produces #(interval 44.514 47.243))

    (content barometer-height)
    (produces #(interval .3 .31839))
    ;; Refining the (make-interval 0.3 0.32) we put in originally

    (content fall-time)
    (produces #(interval 3.0091 3.1))
    ;; Refining (make-interval 2.9 3.1)

    (add-content building-height (make-interval 45 45))
    (run)
    (content barometer-height)
    (produces #(interval .3 .30328))

    (content barometer-shadow)
    (produces #(interval .366 .37))

    (content building-shadow)
    (produces #(interval 54.9 55.1))

    (content fall-time)
    (produces #(interval 3.0255 3.0322))
    ))

 (define-test (barometer-reverse-fall-time)
   (interaction
    (initialize-scheduler)
    (define-cell fall-time)
    (define-cell building-height)
    (fall-duration fall-time building-height)

    (add-content fall-time (make-interval 2.9 3.1))
    (run)
    (content building-height)
    (produces #(interval 41.163 47.243))

    (add-content building-height 45)

    (run)
    (content fall-time)
    (produces #(interval 3.0255 3.0322))
    ))

 )
