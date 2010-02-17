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

(define (make-graphml-writer output-port)
  (define (write-graph write-contents)
    (write-xml-header
     (lambda ()
       (write-graph-header)
       (write-tag "graph" `((edgedefault . "directed")
			    (id . "G"))
		  write-contents))))

  (define (write-xml-header write-contents)
    (write-string "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>" output-port)
    (write-tag
     "graphml"
     `((xmlns . "http://graphml.graphdrawing.org/xmlns")
       (xmlns:xsi . "http://www.w3.org/2001/XMLSchema-instance")
       (xmlns:y . "http://www.yworks.com/xml/graphml")
       (xsi:schemaLocation . "http://graphml.graphdrawing.org/xmlns http://www.yworks.com/xml/schema/graphml/1.1/ygraphml.xsd"))
     write-contents)
    (newline output-port))

  (define (write-graph-header)
    (write-tag "key" '((for . "node") (id . "d3") (yfiles.type . "nodegraphics")))
    (write-tag "key" '((for . "edge") (id . "d6") (yfiles.type . "edgegraphics"))))

  (define (write-tag tag attributes #!optional write-contents)
    (newline output-port)
    (write-indentation)
    (write-string "<" output-port)
    (write-string tag output-port)
    (for-each (lambda (pair)
		(write-string " " output-port)
		(write (car pair) output-port)
		(write-string "=" output-port)
		(write-string "\"" output-port)
		(write-string (cdr pair) output-port)
		(write-string "\"" output-port))
	      attributes)
    (if (default-object? write-contents)
	(write-string "/>" output-port)
	(begin (write-string ">" output-port)
	       (prop:dot:indented write-contents)
	       (write-string "</" output-port)
	       (write-string tag output-port)
	       (write-string ">" output-port))))

  (define (write-node node-id attributes)
    (write-tag
     "node" `((id . ,node-id))
     (lambda ()
       (write-tag
	"data" '((key . "d3"))
        (lambda ()
	  (write-tag
	   "y:ShapeNode" '()
	   (lambda ()
	     ;; TODO This is a hack!
	     (write-tag
	      "y:NodeLabel" '()
	      (lambda ()
		(write-string (cdr (assoc "label" attributes)) output-port)))
	     (write-tag
	      "y:Shape" `((type . ,(compute-node-shape attributes)))))))))))

  ;; What a hack!
  (define (compute-node-shape attributes)
    (let ((candidate (cdr (assoc "shape" attributes))))
      (if (equal? "box" candidate)
	  "rectangle"
	  candidate)))

  (define (write-edge source-name target-name attributes)
    ;; TODO Edge labels
    (write-tag "edge" `((source . ,source-name)
			(target . ,target-name))))

  (define (write-cluster id attributes write-contents)
    (write-tag "node" `((id . ,(string-append "(cluster) " (write-to-string id)))
			(yfiles.foldertype . "group"))
     (lambda ()
       (write-tag "data" `((key . "d3"))
	(lambda ()
	  (write-tag "y:ProxyAutoBoundsNode" '()
	   (lambda ()
	     (write-tag "y:Realizers" '((active . "0"))
	      (lambda ()
		(write-tag "y:GroupNode" '()
		 (lambda ()
		   (write-tag "y:NodeLabel" '()
		    (lambda ()
		      (write-string (cdr (assoc "label" attributes)) output-port)))))
		(write-tag "y:GroupNode" '()
		 (lambda ()
		   (write-tag "y:NodeLabel" '()
		    (lambda ()
		      (write-string (cdr (assoc "label" attributes)) output-port)))))))))))
       (write-tag
	"graph" `((edgedefault . "directed")
		  (id . ,(string-append "(subgraph) " (write-to-string id))))
	write-contents))))

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
