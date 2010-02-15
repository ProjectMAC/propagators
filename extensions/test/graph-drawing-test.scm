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
  \"(variable) 14\" -> \"(propagator) 13\" [label=\"\" ];
  \"(variable) 14\" [label=\"foo\", shape=\"ellipse\" ];
  \"(propagator) 13\" -> \"(variable) 15\" [label=\"\" ];
  \"(variable) 15\" [label=\"bar\", shape=\"ellipse\" ];
 }
}
" (out)))))

 (define-each-check
   (< (memory-loss-from (repeated 100 make-eq-hash-table)) 2)
   (< (memory-loss-from (repeated 100 make-strong-eq-hash-table)) 2)
   (< (memory-loss-from (repeated 100 reset-premise-info!)) 2)
   (< (memory-loss-from (repeated 500 reset-network-groups!)) 10)
   (< (memory-loss-from (repeated 100 initialize-scheduler)) 2))

 (define-test (groups-do-not-leak)
   (define (one-small-network)
     (initialize-scheduler)
     (define-cell foo)
     (define-cell bar)
     (pass-through foo bar))
   (check (< (memory-loss-from (repeated 2000 one-small-network))
	     -1)))

 )
