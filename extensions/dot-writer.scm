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

(define (make-dot-writer output-port)
  (define (write-graph write-contents)
    (write-string "digraph G {" output-port)
    (newline output-port)
    (prop:dot:indented
     (lambda ()
       (write-options)
       (write-contents)))
    (write-string "}" output-port)
    (newline output-port))

  (define (write-options)
    (for-each (lambda (option)
		(write-indentation)
		(write-string option output-port)
		(write-string ";" output-port)
		(newline output-port))
	      '(; "orientation=landscape"
                ; "size=\"10,7.5\""
                ; "page=\"8.5,11\""
		"ratio=fill")))

  (define (write-node node-id attributes)
    (write-indentation)
    (write node-id output-port)
    (write-attributes attributes)
    (write-string ";" output-port)
    (newline output-port))

  (define (write-edge source-name target-name attributes)
    (write-indentation)
    (write source-name output-port)
    (write-string " -> " output-port)
    (write target-name output-port)
    (write-attributes attributes)
    (write-string ";" output-port)
    (newline output-port))

  (define (write-cluster id attributes write-contents)
    (write-subgraph
     (string-append "cluster_" (write-to-string id))
     attributes write-contents))

  (define (write-subgraph id attributes write-contents)
    (write-indentation)
    (write-string "subgraph " output-port)
    (write-string id output-port)
    (write-string " { " output-port)
    (write-subgraph-attributes attributes)
    (newline output-port)
    (prop:dot:indented write-contents)
    (write-indentation)
    (write-string "}" output-port)
    (newline output-port))

  (define (write-attributes attributes)
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
  (define (write-subgraph-attributes attributes)
    (if (pair? attributes)
	(for-each (lambda (attribute)
		    (write-string (car attribute) output-port)
		    (write-string "=" output-port)
		    (write (cdr attribute) output-port)
		    (write-string "; " output-port))
		  attributes)))

  (define (write-indentation)
    (repeat prop:dot:indentation-level
	    (lambda ()
	      (write-string "  " output-port))))

  (define (me message)
    (cond ((eq? 'write-graph message) write-graph)
	  ((eq? 'write-node message) write-node)
	  ((eq? 'write-edge message) write-edge)
	  ((eq? 'write-cluster message) write-cluster)
	  (else
	   (error "Unknown message" message))))
  
  me)

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
    
    (define (node-type-string node)
      (cond ((cell? node) "(cell) ")
	    ((propagator? node) "(prop) ")
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
      ((writer 'write-node)
       (node-id node)
       `(("label" . ,(node-name node))
	 ("shape" . ,(node-shape node)))))

    (define (write-edge source target label)
      (define (edge-writer)
	((writer 'write-edge) source target `(("label" . ,label))))
      (if defer-edges?
	  (set! deferred-edges (cons edge-writer deferred-edges))
	  (edge-writer)))

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
	((writer 'write-cluster)
	 (hash group)
	 `(("label" . ,(write-to-string (name group))))
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
