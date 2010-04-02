;;; ----------------------------------------------------------------------
;;; Copyright 2010 Alexey Radul.
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

;;; This is "apply" for propagators, except it does not yet play well
;;; with nontrivial partial information structures.
(define (direct-call-site closure-cell arg-cells)
  (propagator closure-cell
    ;; TODO Hm.  There doesn't seem to be any good way to arrange this
    ;; metadata.  One of the reasons for ugly pictures coming out of
    ;; this is that the closure that gets called will generally add
    ;; its own metadata, so the picture ends up reflecting several
    ;; stages of elaboration: call sites, and the procedures that got
    ;; called, and, if the network were higher-order, the call-sites
    ;; and procedures those ended up expanding into, etc.  There is
    ;; also no hint which closure-constructed box came from which call
    ;; site.
    (eq-label!
     (lambda ()
       ;; TODO Deal with other partial information types!
       (if (nothing? (content closure-cell))
	   'ok
	   (let ((closure (content closure-cell)))
	     ;; Do I need to memoize this?  Not if I can rely on the
	     ;; closure-cell only poking me once (when the closure
	     ;; shows up).

	     ;; This assumes that the closure itself will be a compound
	     ;; propagator if appropriate
	     (apply closure arg-cells))))
     'name 'direct-call
     ;; TODO This i/o metadata is just a guess about how the closure
     ;; will act.
     'inputs (cons closure-cell (except-last-pair arg-cells))
     'outputs (last-pair arg-cells))))

;;; "lambda" for the propagator language is just a constant propagator
;;; that emits the desired Scheme closure into the needed cell.  That
;;; closure probably wants to be made with the named-macro-propagator
;;; macro from core/standard-propagators.scm, in order to collect
;;; the appropriate metadata.
