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
 graph-drawing

 (define-each-check
   (equal? '+ (name generic-+)))

 (define-test (naming-smoke)
   (initialize-scheduler)
   (define-cell foo)
   (define-cell bar)
   (define-cell baz)
   (vc:adder foo bar baz)
   (check (= 1 (length (neighbors foo))))
   (check (= 1 (length (neighbors bar))))
   (check (= 1 (length (neighbors baz))))
   (check (eq? 'foo (name foo)))
   (check (eq? 'bar (name bar)))
   (check (eq? 'baz (name baz)))
   (define the-adder (car (neighbors foo)))
   (check (eq? the-adder (car (neighbors bar))))
   (check (eq? the-adder (car (neighbors baz))))
   (check (equal? (list foo bar) (prop:propagator-inputs the-adder)))
   (check (equal? (list baz) (prop:propagator-outputs the-adder)))
   (check (eq? '+ (name the-adder)))
   (check (propagator? the-adder))
   (check (cell? foo))
   (check (cell? bar))
   (check (cell? baz)))

 (define-test (drawing-smoke)
   (interaction
    (initialize-scheduler)
    (define-cell foo)
    (define-cell bar)
    (pass-through foo bar)
    (prop:dot:write-graph-to-string (list foo bar))
    (check (equal? ;; TODO Make this not depend on the hash numbers!
"digraph G {
  ratio=fill;
 subgraph cluster_12 { label=\"top-group\"; 
  \"(propagator) 13\" [label=\"identity\", shape=\"box\" ];
  \"(variable) 15\" [label=\"bar\", shape=\"ellipse\" ];
  \"(variable) 14\" [label=\"foo\", shape=\"ellipse\" ];
 }
  \"(variable) 14\" -> \"(propagator) 13\" [label=\"\" ];
  \"(propagator) 13\" -> \"(variable) 15\" [label=\"\" ];
}
" (out)))))

 (define-each-check
   (< (memory-loss-from (repeated 100 make-eq-hash-table)) 2)
   (< (memory-loss-from (repeated 100 make-strong-eq-hash-table)) 2)
   (< (memory-loss-from (repeated 100 reset-premise-info!)) 2)
   (< (memory-loss-from (repeated 500 reset-network-groups!)) 10)
   (< (memory-loss-from (repeated 100 initialize-scheduler)) 2))

 (define-test (groups-do-not-leak)
   (initialize-scheduler)
   (define (one-small-network)
     (define-cell foo)
     (define-cell bar)
     (initialize-scheduler))
   (check (< (memory-loss-from (repeated 100 one-small-network)) 2)))

 (define-test (groups-do-not-leak-2)
   (initialize-scheduler)
   (define (one-small-network)
     (define-cell foo)
     (define-cell bar)
     (pass-through foo bar)
     (initialize-scheduler))
   (check (< (memory-loss-from (repeated 100 one-small-network)) 2)))

 (define-test (grouped-drawing)
   (interaction
    (initialize-scheduler)
    (define-cell foo)
    (with-network-group (network-group-named 'subgroup)
      (lambda ()
	(define-cell bar)
	(pass-through foo bar)))
    (prop:dot:write-graph-to-string (list foo))
    (check (equal? ;; TODO Make this not depend on the hash numbers!
"digraph G {
  ratio=fill;
 subgraph cluster_16 { label=\"top-group\"; 
 subgraph cluster_17 { label=\"subgroup\"; 
  \"(propagator) 18\" [label=\"identity\", shape=\"box\" ];
  \"(variable) 20\" [label=\"bar\", shape=\"ellipse\" ];
 }
  \"(variable) 19\" [label=\"foo\", shape=\"ellipse\" ];
 }
  \"(variable) 19\" -> \"(propagator) 18\" [label=\"\" ];
  \"(propagator) 18\" -> \"(variable) 20\" [label=\"\" ];
}
" (out)))))

 (define-test (grouped-drawing-2)
   (interaction
    (initialize-scheduler)
    (define-cell foo)
    (define-cell bar)
    (identity-constraint foo bar)
    (prop:dot:write-graph-to-string (list foo))
    (check (equal? ;; TODO Make this not depend on the hash numbers!
"digraph G {
  ratio=fill;
 subgraph cluster_21 { label=\"top-group\"; 
 subgraph cluster_22 { label=\"identity-constraint\"; 
  \"(propagator) 23\" [label=\"identity\", shape=\"box\" ];
  \"(propagator) 26\" [label=\"identity\", shape=\"box\" ];
 }
  \"(variable) 24\" [label=\"bar\", shape=\"ellipse\" ];
  \"(variable) 25\" [label=\"foo\", shape=\"ellipse\" ];
 }
  \"(variable) 24\" -> \"(propagator) 23\" [label=\"\" ];
  \"(propagator) 23\" -> \"(variable) 25\" [label=\"\" ];
  \"(variable) 25\" -> \"(propagator) 26\" [label=\"\" ];
  \"(propagator) 26\" -> \"(variable) 24\" [label=\"\" ];
}
" (out)))))

 )
