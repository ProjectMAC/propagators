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
 dynamic-closures

 (define-test (smoke)
   (interaction
    (initialize-scheduler)

    (define repl-frame (make-frame '()))
    (define-cell a)
    (define-cell b)
    (define-cell gcd-a-b)
    (define-cell euclid-cell)
    (dynamic-call-site euclid-cell (list a b gcd-a-b))
    (add-content a (alist->virtual-copies `((,repl-frame . ,(* 17 3)))))
    (add-content b (alist->virtual-copies `((,repl-frame . ,(* 17 5)))))
    (add-content euclid-cell (alist->virtual-copies `((,repl-frame . ,euclid))))
    (add-content gcd-a-b (alist->virtual-copies `((,repl-frame . ,nothing))))
    (run)
    (virtual-copies->alist (content gcd-a-b))
    (produces `((,repl-frame . 17)))))

 )
