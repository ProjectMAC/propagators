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

(define (self-relatively thunk)
  (if (current-eval-unit #f)
      (with-working-directory-pathname
       (directory-namestring (current-load-pathname))
       thunk)
      (thunk)))

(define (load-relative filename)
  (self-relatively (lambda () (load filename))))

(define (compiled-code-type)
  ;; Trying to support the C backend
  (if (lexical-unbound?
       (nearest-repl/environment)
       'compiler:compiled-code-pathname-type)
      "com"
      (compiler:compiled-code-pathname-type)))

(define (cf-conditionally filename)
  (fluid-let ((sf/default-syntax-table (nearest-repl/environment)))
    (sf-conditionally filename))
  (if (cf-seems-necessary? filename)
      (compile-bin-file filename)))

(define (compiler-available?)
  (not (lexical-unbound? (nearest-repl/environment) 'cf)))

(define (compilation-seems-necessary? filename)
  (or (sf-seems-necessary? filename)
      (cf-seems-necessary? filename)))

(define (sf-seems-necessary? filename)
  (not (file-processed? filename "scm" "bin")))

(define (cf-seems-necessary? filename)
  (not (file-processed? filename "bin" (compiled-code-type))))

(define (load-compiled filename)
  (if (compiler-available?)
      (cf-conditionally filename)
      (if (compilation-seems-necessary? filename)
	  (warn "The compiler does not seem to be loaded;\nSkipping compilation;\nAre you running Scheme with --compiler?")))
  (load filename))

(define (load-relative-compiled filename)
  (self-relatively (lambda () (load-compiled filename))))

(load-relative "../testing/load")

(for-each load-relative-compiled
  '("profiler"
    "eq-properties"
    "utils"
    "generic-system"
    "test-utils"))
