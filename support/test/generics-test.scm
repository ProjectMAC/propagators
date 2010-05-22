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

(in-test-group
 generics

 (define-test (smoke)
   (define smoke-g (make-generic-operator-axch 1 'smoke))
   (check (generic-procedure? (get-operator-record smoke-g)))
   (check (= 1 (generic-procedure-arity (get-operator-record smoke-g))))
   (defhandler-axch smoke-g (lambda (x) 'integer) <integer>)
   (check (eq? 'integer (smoke-g 2)))
   (defhandler-axch smoke-g (lambda (x) 'symbol) symbol?)
   (check (eq? 'symbol (smoke-g 'foo)))
   (check (eq? 'integer (smoke-g 2))))

 (define-test (binary-smoke)
   (define smoke-g (make-generic-operator-axch 2 'smoke))
   (check (= 2 (generic-procedure-arity (get-operator-record smoke-g))))
   (defhandler-axch smoke-g (lambda (x y) '(integer integer)) <integer> <integer>)
   (check (equal? '(integer integer) (smoke-g 2 2)))
   (defhandler-axch smoke-g (lambda (x y) '(integer symbol)) <integer> symbol?)
   (defhandler-axch smoke-g (lambda (x y) '(symbol integer)) symbol? <integer>)
   (defhandler-axch smoke-g (lambda (x y) '(symbol symbol)) symbol? symbol?)
   (check (equal? '(integer integer) (smoke-g 2 2)))
   (check (equal? '(integer symbol)  (smoke-g 2 'foo)))
   (check (equal? '(symbol integer)  (smoke-g 'foo 2)))
   (check (equal? '(symbol symbol)   (smoke-g 'foo 'foo)))
   
   (defhandler-axch smoke-g (lambda (x y) '(integer vector)) <integer> vector?)
   (defhandler-axch smoke-g (lambda (x y) '(vector integer)) vector? <integer>)
   (defhandler-axch smoke-g (lambda (x y) '(vector vector)) vector? vector?)
   (check (equal? '(integer vector)  (smoke-g 2 #())))
   (check (equal? '(vector integer)  (smoke-g #() 2)))
   (check (equal? '(vector vector)  (smoke-g #() #())))

   (check (equal? '(integer integer) (smoke-g 2 2)))
   (check (equal? '(integer symbol)  (smoke-g 2 'foo)))
   (check (equal? '(symbol integer)  (smoke-g 'foo 2)))
   (check (equal? '(symbol symbol)   (smoke-g 'foo 'foo)))
   ))

