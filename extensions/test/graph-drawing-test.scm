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
   (check (equal? (list foo bar) (propagator-inputs the-adder)))
   (check (equal? (list baz) (propagator-outputs the-adder)))
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
    (prop:dot:write-graph-to-string foo)
    (check (equal? ;; TODO Make this not depend on the hash numbers!
"digraph G {
  ratio=fill;
  \"(cell) 12\" [label=\"foo\", shape=\"ellipse\" ];
  \"(prop) 13\" [label=\"identity\", shape=\"box\" ];
  \"(cell) 12\" -> \"(prop) 13\" [label=\"\" ];
  \"(prop) 13\" -> \"(cell) 14\" [label=\"\" ];
  \"(cell) 14\" [label=\"bar\", shape=\"ellipse\" ];
}
" (out)))
    (check (equal? (prop:dot:write-graph-to-string foo)
		   (prop:dot:write-graph-to-string (list foo bar))))))

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
    (prop:dot:write-graph-to-string *current-network-group*)
    (check (equal? ;; TODO Make this not depend on the hash numbers!
"digraph G {
  ratio=fill;
  subgraph cluster_15 { label=\"top-group\"; 
    subgraph cluster_16 { label=\"subgroup\"; 
      \"(prop) 17\" [label=\"identity\", shape=\"box\" ];
      \"(cell) 19\" [label=\"bar\", shape=\"ellipse\" ];
    }
    \"(cell) 18\" [label=\"foo\", shape=\"ellipse\" ];
  }
  \"(cell) 18\" -> \"(prop) 17\" [label=\"\" ];
  \"(prop) 17\" -> \"(cell) 19\" [label=\"\" ];
}
" (out)))))

 (define-test (grouped-drawing-2)
   (interaction
    (initialize-scheduler)
    (define-cell foo)
    (define-cell bar)
    (identity-constraint foo bar)
    (prop:dot:write-graph-to-string)
    (check (equal? ;; TODO Make this not depend on the hash numbers!
"digraph G {
  ratio=fill;
  subgraph cluster_20 { label=\"top-group\"; 
    subgraph cluster_21 { label=\"identity-constraint\"; 
      \"(prop) 22\" [label=\"identity\", shape=\"box\" ];
      \"(prop) 25\" [label=\"identity\", shape=\"box\" ];
    }
    \"(cell) 23\" [label=\"bar\", shape=\"ellipse\" ];
    \"(cell) 24\" [label=\"foo\", shape=\"ellipse\" ];
  }
  \"(cell) 23\" -> \"(prop) 22\" [label=\"\" ];
  \"(prop) 22\" -> \"(cell) 24\" [label=\"\" ];
  \"(cell) 24\" -> \"(prop) 25\" [label=\"\" ];
  \"(prop) 25\" -> \"(cell) 23\" [label=\"\" ];
}
" (out)))))

 )
