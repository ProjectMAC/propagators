#lang at-exp scheme

(require scriblib/autobib)
(provide (all-defined-out))

(define-cite ~cite citet generate-bib)

(define axch (author-name "Alexey" "Radul"))
(define gjs (author-name "Gerald Jay" "Sussman"))
(define mit "Massachusetts Institute of Technology, Cambridge, MA")
(define csail-tr "CSAIL Technical Report")

(define art-thesis
  (make-bib
   #:author axch
   #:title "Propagation Networks: A Flexible and Expressive Substrate for Computation"
   #:date "Sep 2009"
   #:url "http://hdl.handle.net/1721.1/49525"
   #:location (dissertation-location #:institution mit)
   #:is-book? #t))

(define art
  (make-bib
   #:author (authors axch gjs)
   #:title "The Art of the Propagator"
   #:location (techrpt-location
	       #:institution csail-tr
	       #:number "MIT-CSAIL-TR-2009-002")
   #:date "2009"
   #:url "http://hdl.handle.net/1721.1/44215"))
