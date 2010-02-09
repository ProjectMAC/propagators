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

;;; How much like a primitive propagator is a compound propagator?

;;; When the input to a primitive propagator gets refined, you rerun
;;; the primitive to produce a refined output.  When the input to a
;;; compound propagator changes, do you rerun the compound propagator
;;; completely, or just propagate the refinement into it, and reuse
;;; pieces of the computation that were independent of that
;;; refinement?  In order to be able to do that, you have to store
;;; those pieces...

;;; Is the execution of a compound propagator atomic from the
;;; perspective of its user, like the execution of a primitive
;;; propagator?  To do that, a compound propagator would need to
;;; contain its own scheduler, which would take over every time you
;;; ran that propagator, and run the compound until quiescence before
;;; returning to the caller.  The thing the current system does is
;;; splice the pieces of the compound into the caller's scheduler to
;;; run as it will.  You could also imagine a funny intermediate
;;; state, where the compound treats the outside world as just one
;;; more propagator, and ``returns'' (remembering its own state) every
;;; time it would ``run'' that one more propagator (With prioritized
;;; schedulers, this reduces to atomicity if the ``outside world''
;;; propagator has the lowest possible priority).  Then the compound
;;; will not be idempotent from the perspective of the outside, and so
;;; will need to reschedule itself.  Likewise, the outside is
;;; presumably not idempotent with respect to the compound.

;;; This expects TO-BUILD to attach the subnetwork to some existing
;;; cells it is closed over, as in the paper.
(define (compound-propagator neighbors to-build)
  (propagator neighbors
    (lambda ()
      (let ((run-result
	     (with-fresh-scheduler
	      (lambda ()
		;; Also need to make the connections to the neighbors
		;; constructed by to-build temporary.  But this
		;; doesn't work if the network so constructed exports
		;; guesses that carry the identities of ambs, because
		;; those identities may not be preseved.
		(to-build)
		(run)))))
	(if (eq? run-result 'done)
	    ;; We won, carry on
	    'ok
	    ;; Do something appropriate if this is, say, a contradiction
	    ;; that was unresolvable on the inside but is resolvable on
	    ;; the outside, otherwise pass it on like this:
	    (abort-process run-result))))))

(define (with-fresh-scheduler to-do)
  ;; TODO Also somehow need things like *external-premise-nogoods*
  ;; that are global supports for the dependency tracker.  I think.
  ;; Also probably need to relabel premises created by ambs from
  ;; the outside as "external", I think.
  (fluid-let ((*alerted-propagators* *alerted-propagators*)
	      (*alerted-propagator-list* *alerted-propagator-list*)
	      (*abort-process* *abort-process*)
	      (*last-value-of-run* *last-value-of-run*)
	      (*propagators-ever-alerted* *propagators-ever-alerted*)
	      (*propagators-ever-alerted-list* *propagators-ever-alerted-list*))
    (initialize-scheduler)
    (to-do)))

;;; This version requires an already-constructed boundary to represent
;;; the interior of the compound.  Either this boundary must represent
;;; a call site, or with-temporary-connections must construct
;;; appropriate relabelers.  Either way, we can decide whether the
;;; frame that gets created corresponds to the fresh scheduler or has
;;; an existence of its own.  If the former, then it can be garbage
;;; collected when the scheduler finishes (but a nested stack of
;;; schedulers can of course produce a large pile of frames) (and only
;;; if there are no other references to it, such as those closures
;;; might capture); if the latter, then the caller presumably has a
;;; frame too.  Does using fluid-let for the new scheduler rely too
;;; heavily on being stuck in a uniprocess environment?
(define (compound-propagator neighbors boundary)
  (propagator neighbors
    (lambda ()
      (let ((run-result
	     (with-fresh-scheduler
	      (lambda ()
		(with-temporary-connections neighbors boundary run)))))
	(if (eq? run-result 'done)
	    'ok
	    (abort-process run-result))))))

(define (with-temporary-connections cells-a cells-b thunk)
  (let ((the-connections #f)
	(make-connection (connection-propagator-creator 'shared-state)))
    (dynamic-wind
	(lambda ()
	  (set! the-connections
		(map make-connection cells-a cells-b)))
	thunk
	(lambda ()
	  (for-each remove-neighbor! cells-a the-connections)
	  (for-each remove-neighbor! cells-b the-connections)))))

;;; For reference, the "splicing scheduler" version, which corresponds
;;; directly to CALL-SITE from abstraction.scm.  There the shared
;;; state is the frame map, and the connection creator creates a pair
;;; of inward transferring and outward transferring propagators.
(define (compound-propagator neighbors boundary)
  (let ((make-connection (connection-propagator-creator 'shared-state)))
    (map make-connection neighbors boundary)))

;;; The difference between these two suggests that the scheduler's
;;; list of propagators ever alerted should hold propagators strongly,
;;; but the cells should hold them weakly?  

;;; Maybe also each binary-amb at least can hold its scheduler
;;; strongly, so that if a choice may still be revisited that piece of
;;; network doesn't go away?  But then we wouldn't want to build
;;; another in its place...

;;; This version doesn't need temporary connections because it carries
;;; out the data transfer itself.  It expects FRESH-COPY to return a
;;; list of boundary cells.  In a virtual-copies version, it might
;;; return the token naming the new copy, and COMPOUND-PROPAGATOR
;;; might close over the boundary cells.  Either way, something weird
;;; would need to be done to support ambs living inside but exporting
;;; supports outside.
(define (compound-propagator neighbors fresh-copy)
  (propagator neighbors
    (lambda ()
      (let ((saved-boundary #f)
	    (run-result
	     (with-fresh-scheduler
	      (lambda ()
		(let ((boundary (fresh-copy)))
		  (set! saved-boundary boundary)
		  ;; In, for example, the virtual copies world, this
		  ;; could be some more complicated or selective
		  ;; operation than a direct transfer of the entire
		  ;; content
		  (map (lambda (outside inside)
			 (add-content inside (content outside)))
		       neighbors boundary))
		(run)))))
	(if (eq? run-result 'done)
	    ;; If we win, we need to ship the answers back
	    (map (lambda (outside inside)
		   (add-content outside (content inside)))
		 neighbors saved-boundary)
	    ;; In fact, we may need to ship the partial answers back
	    ;; even if we lose...
	    (abort-process run-result))))))
;;; What happens if some closure closes over some cell inside this,
;;; exports it, lets the internal scheduler die, and then adds more
;;; information to the cell it closed over?  Then some propagators at
;;; this level will probably need to be rerun; what scheduler should
;;; do that?  This question is making think that trying to separate
;;; the schedulers is a bad idea...  Or maybe when you export a
;;; closure across the intended scheduler boundary, you do something
;;; like make fresh copies of its cells for the benefit of the
;;; outside, and maintain the scheduler separation?

;;; Here's a version that just segregates the schedulers and leaves
;;; it up to the rest of the system to make or not make copies of
;;; things as it will.
(define (compound-propagator neighbors boundary)
  (propagator neighbors
    (lambda ()
      (let ((run-result
	     (with-fresh-scheduler
	      (lambda ()
		(map (lambda (outside inside)
		       (add-content inside (content outside)))
		     neighbors boundary)
		(run)))))
	(if (eq? run-result 'done)
	    (map (lambda (outside inside)
		   (add-content outside (content inside)))
		 neighbors boundary)
	    (abort-process run-result))))))
