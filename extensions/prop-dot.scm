;;; ----------------------------------------------------------------------
;;; Copyright 2009-2010 Taylor Campbell and Alexey Radul.
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

;;; Code to render propagator networks as dot graphs.

;;; TODO Further improvements

;;; Desperately need support for various forms of abstraction on the
;;; graph, perhaps in the form of subgraph labels.  In particular, the
;;; internal structure of "macros", call-sites, and closures should be
;;; subgraphed, and ideally suppressible.
;;; - In particular, draw-closure (instead of draw-graph) might be
;;;   easy enough to implement.

;;; Explore various graph drawing engines: graphviz, JGraph, others.
;;; http://www2.research.att.com/~volinsky/Graphs/slides/north.pdf

;;; TODO:
;;; Clean up the nomenclature of this now relatively syntax-independent
;;;   network traversal code
;;; Output Graphml (with some extensions) format as well as dot
;;; Dump subgroup data for compound propagators ?
;;; Dump subgroup data for closures ??
;;; Dump subgroup data for nested expressions
;;; Dump values (maybe user-configurable views on them?)
;;; Dump animations of the progress of values over time
;;; Draw pictures of all the interesting propagator networks.

;;; Here's a cute way to use this:
#;
 (fluid-let ((prop:cell-label
	      (lambda (var) (cons (name var) (content var)))))
   (prop:dot:show-graph))
;;; That draws a picture of the network and lists the contents
;;; of the cells (with write-to-string).

;;; Here's another fun way to play:
#;
 (fluid-let ((make-dot-writer make-graphml-writer))
   (prop:dot:write-graph-to-file "frob.graphml"))
;;; That draws stuff in gramphml.  (I'll fix this interface soon, I
;;; promise).

(define (prop:dot:show-graph #!optional start drawing-program)
  (call-with-temporary-file-pathname
   (lambda (svg-pathname)
     (prop:dot:draw-graph-to-file svg-pathname start drawing-program)
     ;; TODO There is, in principle, support for asynchronous
     ;; subprocesses, but it is "available for those who are willing
     ;; to read the source code."  More on this in an email exchange
     ;; with Taylor titled "Happy New Year, and a Question"
     (run-shell-command
      (string-append "eog " (->namestring svg-pathname))))))

(define (prop:dot:draw-graph-to-file pathname #!optional start drawer)
  (if (default-object? drawer)
      (set! drawer "dot"))
  (call-with-temporary-file-pathname
   (lambda (graph-pathname)
     (prop:dot:write-graph-to-file graph-pathname start)
     (run-shell-command
      (string-append
       drawer " " (->namestring graph-pathname)
       " -Tsvg -o " (->namestring pathname))))))

(define (prop:dot:write-graph-to-file pathname #!optional start)
  (call-with-output-file pathname
    (lambda (output-port)
      (prop:dot:write-graph start output-port))))

(define (prop:dot:write-graph-to-string #!optional start)
  (call-with-output-string
   (lambda (output-port)
     (prop:dot:write-graph start output-port))))

(define (prop:dot:write-graph #!optional start output-port)
  (if (default-object? output-port)
      (set! output-port (current-output-port)))
  (let ((writer (make-dot-writer output-port)))
    ((writer 'write-graph)
     (lambda ()
       (prop:dot:walk-graph writer start)))))

(define (prop:dot:walk-graph writer #!optional start)
  (let ((visited (make-eq-hash-table))
	(defer-edges? #f)
	(deferred-edges '()))

    (define (node? thing)
      (or (cell? thing) (propagator? thing)))

    (define write-node (writer 'write-node))

    (define (write-edge source target label)
      (define (edge-writer)
	((writer 'write-edge) source target label))
      (if defer-edges?
	  (set! deferred-edges (cons edge-writer deferred-edges))
	  (edge-writer)))

    (define (write-input-edge input name index)
      (write-edge input name index))

    (define (write-output-edge output name index)
      (write-edge name output index))

    (define (write-edges propagator accessor write-edge)
      (let ((name (prop:dot:node-id propagator))
	    (number-edges? (< 1 (length (accessor propagator)))))
        (let loop ((cells (accessor propagator)) (index 0))
          (if (pair? cells)
              (let ((cell (car cells)))
                (write-edge (prop:dot:node-id cell) name (if number-edges? index ""))
                (loop (cdr cells) (+ index 1)))))))

    (define (write-propagator-apex propagator)
      (write-node propagator)
      (write-edges propagator propagator-inputs write-input-edge)
      (write-edges propagator propagator-outputs write-output-edge))

    (define (visit node)
      (if (not (hash-table/get visited node #f))
          (begin (hash-table/put! visited node #t)
                 (cond ((cell? node) (visit-cell node))
		       ((propagator? node) (visit-propagator node))
		       (else
			(error "Unknown node type" node))))))

    (define (visit-propagator propagator)
      (write-propagator-apex propagator)
      (for-each visit
		(append (propagator-inputs propagator)
			(propagator-outputs propagator))))
    
    (define (visit-cell cell)
      (write-node cell)
      (for-each visit (cell-connections cell)))

    (define (traverse-group group)
      (fluid-let ((defer-edges? #t))
	((writer 'write-cluster) (hash group) (name group)
	 (lambda ()
	   (for-each traverse (network-group-elements group)))))
      (if (not defer-edges?)
	  (dump-deferred-edges)))

    (define (traverse thing)
      (cond ((network-group? thing)
	     (traverse-group thing))
	    ((cell? thing)
	     (write-node thing))
	    ((propagator? thing)
	     (write-propagator-apex thing))
	    (else
	     'ok)))

    (define (dump-deferred-edges)
      (for-each (lambda (edge-writer) (edge-writer))
		(reverse deferred-edges))
      (set! deferred-edges '()))

    (define (dispatch start)
      (cond ((default-object? start) (traverse-group *current-network-group*))
	    ((network-group? start) (traverse-group start))
	    ((node? start) (visit start))
	    ((pair? start) (for-each dispatch start))
	    (else
	     (error "Unknown entry point" start))))

    (dispatch start)))

(define (prop:dot:node-id node)
  (define (node-type-string node)
    (cond ((cell? node) "(cell) ")
	  ((propagator? node) "(prop) ")
	  (else
	   (error "Unknown node type" node))))
  (string-append (node-type-string node) (write-to-string (hash node))))

(define (prop:dot:node-label node)
  (write-to-string
   (cond ((cell? node) (prop:cell-label node))
	 ((propagator? node) (prop:propagator-label node))
	 (else
	  (error "Unnameable node type" node)))))

(define prop:dot:indentation-level 0)

(define (prop:dot:indented thunk)
  (fluid-let ((prop:dot:indentation-level
	       (+ prop:dot:indentation-level 1)))
    (thunk)))

(define prop:propagator-label name)
(define prop:cell-label name)
