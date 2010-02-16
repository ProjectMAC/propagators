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

;;; Here's a cute way to use this:
#;
(fluid-let ((prop:cell-label
	     (lambda (var) (cons (name var) (content var)))))
  (prop:dot:show-graph (list in-n)))
;;; That draws a picture of the network and lists the contents
;;; of the cells (with write-to-string).

(define (prop:dot:show-graph root-nodes #!optional drawing-program)
  (call-with-temporary-file-pathname
   (lambda (svg-pathname)
     (prop:dot:draw-graph-to-file root-nodes svg-pathname drawing-program)
     ;; TODO There is, in principle, support for asynchronous
     ;; subprocesses, but it is "available for those who are willing
     ;; to read the source code."  More on this in an email exchange
     ;; with Taylor titled "Happy New Year, and a Question"
     (run-shell-command
      (string-append "eog " (->namestring svg-pathname))))))

(define (prop:dot:draw-graph-to-file root-nodes pathname #!optional drawer)
  (if (default-object? drawer)
      (set! drawer "dot"))
  (call-with-temporary-file-pathname
   (lambda (graph-pathname)
     (prop:dot:write-graph-to-file root-nodes graph-pathname)
     (run-shell-command
      (string-append
       drawer " " (->namestring graph-pathname)
       " -Tsvg -o " (->namestring pathname))))))

(define (prop:dot:write-graph-to-file root-nodes pathname)
  (call-with-output-file pathname
    (lambda (output-port)
      (prop:dot:write-graph root-nodes output-port))))

(define (prop:dot:write-graph-to-string root-nodes)
  (call-with-output-string
   (lambda (output-port)
     (prop:dot:write-graph root-nodes output-port))))

(define (prop:dot:write-graph root-nodes output-port)
  (write-string "digraph G {" output-port)
  (newline output-port)
  (prop:dot:write-options output-port)
  (prop:dot:walk-graph root-nodes output-port)
  (write-string "}" output-port)
  (newline output-port))

(define (prop:dot:write-options output-port)
  (for-each (lambda (option)
              (write-string "  " output-port)
              (write-string option output-port)
              (write-string ";" output-port)
              (newline output-port))
            '(; "orientation=landscape"
              ; "size=\"10,7.5\""
              ; "page=\"8.5,11\""
              "ratio=fill")))

(define (prop:dot:walk-graph nodes output-port)
  (let ((visited (make-eq-hash-table))
	(defer-edges? #t)
	(deferred-edges '()))

    (define (node-type-string node)
      (cond ((cell? node) "(cell) ")
	    ((propagator? node) "(prop) ")
	    ((network-group? node) "cluster_")
	    (else
	     (error "Unknown node type" node))))

    (define (node-id node)
      (string-append (node-type-string node) (write-to-string (hash node))))

    (define (node-name node)
      (write-to-string
       (cond ((cell? node) (prop:cell-label node))
	     ((propagator? node) (prop:propagator-label node))
	     (else
	      (error "Unnameable node type" node)))))

    (define (node-shape node)
      (cond ((cell? node) "ellipse")
	    ((propagator? node) "box")
	    (else
	     (error "Unshapeable node type" node))))

    (define (write-node node)
      (prop:dot:write-node
       (node-id node)
       `(("label" . ,(node-name node))
	 ("shape" . ,(node-shape node)))
       output-port))

    (define (write-edge source target label)
      (define (edge-writer output-port)
	(prop:dot:write-edge source target `(("label" . ,label)) output-port))
      (if defer-edges?
	  (set! deferred-edges
		(cons (call-with-output-string edge-writer)
		      deferred-edges))
	  (edge-writer output-port)))

    (define (write-input-edge input name index)
      (write-edge input name index))

    (define (write-output-edge output name index)
      (write-edge name output index))

    (define (write-edges propagator accessor write-edge)
      (let ((name (node-id propagator))
	    (number-edges? (< 1 (length (accessor propagator)))))
        (let loop ((cells (accessor propagator)) (index 0))
          (if (pair? cells)
              (let ((cell (car cells)))
                (write-edge (node-id cell) name (if number-edges? index ""))
                (loop (cdr cells) (+ index 1)))))))

    (define (write-propagator-apex propagator)
      (write-node propagator)
      (write-edges propagator prop:propagator-inputs write-input-edge)
      (write-edges propagator prop:propagator-outputs write-output-edge))

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
		(append (prop:propagator-inputs propagator)
			(prop:propagator-outputs propagator))))
    
    (define (visit-cell cell)
      (write-node cell)
      (for-each visit
		(prop:variable-connections cell)))
#;
    (for-each visit nodes)

    (define (traverse-group group)
      ;; TODO Indent the subgraphs correctly?
      (write-string " subgraph cluster_" output-port)
      (write (hash group) output-port)
      (write-string " { " output-port)
      (prop:dot:write-subgraph-attributes
       `(("label" . ,(write-to-string (name group))))
       output-port)
      (write-string "\n" output-port)
      (for-each traverse-thing (network-group-elements group))
      (write-string " }\n" output-port))

    (define (traverse-thing thing)
      (cond ((network-group? thing)
	     (traverse-group thing))
	    ((cell? thing)
	     (write-node thing))
	    ((propagator? thing)
	     (write-propagator-apex thing))
	    (else
	     'ok)))

    ;;; TODO Interface change: accept either some cells or a network
    ;;; group; if cells, draw without groups; if group, draw from that
    ;;; group; if nothing, draw from the top level.
    (traverse-group *current-network-group*)
    (if defer-edges?
	(for-each (lambda (edge)
		    (write-string edge output-port))
		  (reverse deferred-edges)))
    ))

(define (prop:dot:write-node node-id attributes output-port)
  (write-string "  " output-port)
  (write node-id output-port)
  (prop:dot:write-attributes attributes output-port)
  (write-string ";" output-port)
  (newline output-port))

(define (prop:dot:write-edge source-name target-name attributes output-port)
  (write-string "  " output-port)
  (write source-name output-port)
  (write-string " -> " output-port)
  (write target-name output-port)
  (prop:dot:write-attributes attributes output-port)
  (write-string ";" output-port)
  (newline output-port))

(define (prop:dot:write-attributes attributes output-port)
  (if (pair? attributes)
      (let ((first-attribute? #t))
	(write-string " [" output-port)
	(for-each (lambda (attribute)
		    (if (not first-attribute?)
			(write-string ", " output-port))
		    (write-string (car attribute) output-port)
		    (write-string "=" output-port)
		    (write (cdr attribute) output-port)
		    (set! first-attribute? #f))
		  attributes)
	(write-string " ]" output-port))))

;;; TODO Why is the string handling in MIT Scheme so awful?
(define (prop:dot:write-subgraph-attributes attributes output-port)
  (if (pair? attributes)
      (for-each (lambda (attribute)
		  (write-string (car attribute) output-port)
		  (write-string "=" output-port)
		  (write (cdr attribute) output-port)
		  (write-string "; " output-port))
		attributes)))

;;; Stubs by axch

(define (prop:propagator-inputs propagator)
  (or (eq-get propagator 'inputs)
      (eq-get propagator 'neighbors)
      '()))

(define (prop:propagator-outputs propagator)
  (or (eq-get propagator 'outputs)
      (eq-get propagator 'neighbors)
      '()))

(define (prop:variable-connections cell)
  (append (neighbors cell)
	  (or (eq-get cell 'shadow-connections)
	      '())))

(define prop:propagator-label name)
(define prop:cell-label name)
