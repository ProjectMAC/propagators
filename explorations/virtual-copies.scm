;;;; Boring data structures

;;; I want to be able to define copy sets that have systematically
;;; predictable values in all frames.  I intended to do that with an
;;; optional procedure that would produce the value given the frame,
;;; but I realized that I need to analyze those default values enough
;;; that I don't want to implement that yet.  Instead, the only
;;; systematic behavior I will currently allow is being a fixed piece
;;; of partial information in all frames.  The actually listed copies
;;; are presumed to subsume the default, an invariant I will need to
;;; maintain when constructing these objects.

(define-structure
  (virtual-copies (constructor %make-v-c))
  copy-alist
  default-info)

(define (make-virtual-copies copy-alist #!optional default-info)
  (if (default-object? default-info)
      (set! default-info nothing))
  (%make-v-c copy-alist default-info))

(define (default-virtual-copy copy-set frame)
  (virtual-copies-default-info copy-set)
  ;; If I had default procedures, I could do this:
  #;
  (if (virtual-copies-default-proc copy-set)
      ((virtual-copies-default-proc copy-set) frame)
      nothing))

(define (frame-content copy-set frame)
  (let ((binding (assq frame (virtual-copies-copy-alist copy-set))))
    (if binding
	(cdr binding)
	(default-virtual-copy copy-set frame))))

(define (frames-content copy-set frames)
  ;; TODO This is needlessly quadratic
  (map (lambda (frame)
	 (frame-content copy-set frame))
       frames))

(define (relevant-frames copy-sets)
  (delete-duplicates
   (append-map
    (lambda (copy-set)
      (map car (virtual-copies-copy-alist copy-set)))
    copy-sets)))

(define (equivalent? info1 info2)
  (or (eq? info1 info2) ; Fast path...
      (and (implies? info1 info2)
	   (implies? info2 info1))))

(define (v-c-equal? copy-set1 copy-set2)
  ;; This won't work as written with default-procs
  (and (equivalent? (virtual-copies-default-info copy-set1)
		    (virtual-copies-default-info copy-set2))
       (let ((relevant-frames (relevant-frames (list copy-set1 copy-set2))))
	 (apply boolean/and
	   (map equivalent?
		(frames-content copy-set1 relevant-frames)
		(frames-content copy-set2 relevant-frames))))))

(define (virtual-copy-merge copy-set1 copy-set2)
  (let ((answer ((virtual-copy-unpacking merge) copy-set1 copy-set2)))
    (cond ((v-c-equal? answer copy-set1) copy-set1)
	  ((v-c-equal? answer copy-set2) copy-set2)
	  (else answer))))

(assign-operation
 'merge virtual-copy-merge virtual-copies? virtual-copies?)

;;;; God's-eye virtual copies

;;; Each propagator tries to process all available virtual copies
;;; every time it runs.

;;; The alternative would have been to have each propagator operate on
;;; just some suitably-chosen "current" one.  This latter is annoying
;;; because it seems to suppose a global (or at least dynamically
;;; scoped) notion of "current".  The former is annoying because then
;;; every time we get a new frame, we end up repeating all the work in
;;; the old frames.  I decided that the second of those troubles
;;; bothers me less, so I am implementing operating on all virtual
;;; copies.

;;; Operating on all virtual copies is like operating on all
;;; worldviews in a TMS, and therefore perhaps undesirable.  Or
;;; perhaps not: worldviews differ from copies in that there are
;;; combinatorially many of them, and in that the presumption is that
;;; in the end only one worldview is "right", whereas there are only
;;; as many virtual copies as are made, and we presumably do want them
;;; all to yield their answers, because they feed into each other.
;;; But perhaps it makes even more sense to make virtual (or does that
;;; make them physical now?) copies of the propagators as well, and
;;; schedule each virtual copy's version of a given propagator
;;; separately.  Ideally, the effect would be that each copy of a
;;; propagator then knows which copy it belongs to, so it would only
;;; wake up when something interesting happened in that copy, and thus
;;; we would not repeat work.  Perhaps this amounts to a non-global
;;; notion of "current copy".  This idea might also solve the problem
;;; with amb, below.

(define (virtual-copy-unpacking f)
  (lambda args
    (let ((relevant-frames (relevant-frames args)))
      (make-virtual-copies
       (map (lambda (frame)
	      (cons frame (apply f (map (lambda (arg)
					  (frame-content arg frame))
					args))))
	    relevant-frames)
       ;; This won't work as written with default-procs
       (apply f (map virtual-copies-default-info args))))))

(for-each
 (lambda (name underlying-operation)
   (assign-operation
    name (virtual-copy-unpacking
	  ;; TODO Fix this lift via generic methods that handle nothings
	  (lift-to-cell-contents underlying-operation))
    virtual-copies? virtual-copies?))
 '(+ - * / = < > <= >= and or)
 (list generic-+ generic-- generic-* generic-/
       generic-= generic-< generic-> generic-<= generic->=
       generic-and generic-or))

(for-each
 (lambda (name underlying-operation)
   (assign-operation
    name (virtual-copy-unpacking
	  ;; TODO Fix this lift via generic methods that handle nothings
	  (lift-to-cell-contents underlying-operation))
    virtual-copies?))
 '(abs square sqrt not)
 (list generic-abs generic-square generic-sqrt generic-not))

;;;; Conditionals, again

;;; The God's-eye view forces a rethinking of the conditional, because
;;; of course the value of the predicate may differ from frame to
;;; frame, so the output may need to become the consequent in some
;;; frames and the alternative in others.  It turns out, however, that
;;; if is less special than I thought.  It differs from an ordinary
;;; ternary function in only two ways: it would route requests
;;; differently if we were pulling (which is not a problem I'm dealing
;;; with yet) and it can still produce a useful output even if one of
;;; the inputs is "nothing" (so uniformly handling input nothings is a
;;; bad idea).  These two are of course dual to each other.
;;; Therefore, the most general conditional is a ternary generic
;;; function, but for convenience I reproduce the previous behavior,
;;; which is defined by a unary and a binary generic function, in the
;;; ternary function's default method.  Incidentally, the
;;; generic-true? and generic-ignore-first slicing would work for
;;; ant's-eye virtual copies, for the same reason that it works for
;;; ant's-eye TMSes.

(define (conditional p if-true if-false output)
  (propagator (list p if-true if-false)
    (lambda ()
      (add-content output
        (apply generic-ternary-if (map content (list p if-true if-false)))))))

(define generic-ternary-if
  (make-generic-operator 3 'ternary-if
   (lambda (predicate consequent alternative)
     (if (nothing? predicate)
	 nothing
	 (if (generic-true? predicate)
	     (generic-ignore-first predicate consequent)
	     (generic-ignore-first predicate alternative))))))

(assign-operation
 'ternary-if (virtual-copy-unpacking generic-ternary-if)
 virtual-copies? virtual-copies? virtual-copies?)

;; TODO Is this right?
(define (->virtual-copies thing)
  (if (virtual-copies? thing)
      thing
      (make-virtual-copies '() thing)))

(assign-operation
 'ternary-if (coercing 
	      ->virtual-copies
	      (virtual-copy-unpacking generic-ternary-if))
 virtual-copies? virtual-copies? nothing?)

(assign-operation
 'ternary-if (coercing 
	      ->virtual-copies
	      (virtual-copy-unpacking generic-ternary-if))
 virtual-copies? nothing? virtual-copies?)

#|

Further reflection, via the question of coersions to virtual-copies,
yields another bug: What is the right interaction between virtual
copies and tmses?  Specifically, what if there's a binary amb inside
a recursive function?  e.g.

(define (integer-from n)
  (amb n (integer-from (+ n 1))))

or

(define (integer-from n answer)
  (let ((choice (make-cell))
	(next-n (make-cell))
	(one (make-cell))
	(recursive-answer (make-cell)))
    (binary-amb choice)
    ((constant 1) one)
    (adder n one next-n)
    (conditional choice n recursive-answer answer)
    (integer-from next-n recursive-answer)))

In this case, at least, we mean for each amb in each different virtual
copy to be treated separately (with the understanding that if some amb
chooses not to recur, then the subsequent ambs' choices have no
influence on the answer).  But the virtual copies as envisioned only
copy cells, and do not copy an amb's internally constructed premises.
As a consequence, the premises retain their identity, and it appears
as though there is only one choice to make: to return the first n, or
to recur forever.

|#


;;;; Boundaries

(define frame-count 0)

(define (fresh-frame)
  (set! frame-count (+ frame-count 1))
  (cons 'frame frame-count))

(define-structure
  frame-map
  frame-alist)

(define (frame-map-bind! frame-map key1 key2)
  (set-frame-map-frame-alist!
   frame-map (cons (cons key1 key2)
		   (frame-map-frame-alist frame-map))))

(define (frame-get frame-map key)
  (let ((binding (assq key (frame-map-frame-alist frame-map))))
    (if binding
	(cdr binding)
	;; This may need cross-propagator locks
	(let ((answer (fresh-frame)))
	  (frame-map-bind! frame-map key answer)
	  answer))))

(define (transfer-inward frame-map copy-set)
  (if (nothing? copy-set)
      nothing
      (make-virtual-copies
       (map (lambda (binding)
	      (cons (frame-get frame-map (car binding))
		    (cdr binding)))
	    (virtual-copies-copy-alist copy-set))
       (virtual-copies-default-info copy-set))))

(define (transfer-outward frame-map copy-set)
  (if (nothing? copy-set)
      nothing
      (make-virtual-copies
       (map (lambda (frame-pair)
	      (cons (car frame-pair)
		    (frame-content copy-set (cdr frame-pair))))
	    (frame-map-frame-alist frame-map))
       (virtual-copies-default-info copy-set))))

(define (inward-transferrer frame-map inside outside)
  (propagator outside
    (lambda ()
      (add-content inside
        (transfer-inward frame-map (content outside))))))

(define (outward-transferrer frame-map inside outside)
  ;; TODO This should get woken up every time to frame-map changes.
  ;; Therefore, the frame-map should be stored in a dedicated cell.
  (propagator inside
    (lambda ()
      (add-content outside
        (transfer-outward frame-map (content inside))))))

;;; This treats the outside as the boss: new frames that appear on the
;;; outside generate new frame map entries, but new frames that appear
;;; on the inside do not.  Instead, the channels from the inside to
;;; the outside only transport things for which there already are
;;; frame map entries.  Perhaps this has something to do with the fact
;;; that the inside is by design shared by all call sites of a given
;;; abstraction, but each call site has a different outside.

(define (call-site outside-cells inside-cells)
  (if (not (= (length outside-cells)
	      (length inside-cells)))
      (error "Differing boundary lengths" outside-cells inside-cells))
  (let ((frame-map (make-frame-map '())))
    (map (lambda (outside-cell inside-cell)
	   (inward-transferrer frame-map inside-cell outside-cell)
	   (outward-transferrer frame-map inside-cell outside-cell))
	 outside-cells
	 inside-cells)))

;;;; Factorial, again

;;; Here we have a question of "calling convention".  In the olden
;;; days, the thing one would define was a procedure that took its
;;; interface cells as arguments and manufactured a copy of the
;;; propagator (or network) it represented.  Doing that in this case,
;;; however, seems distasteful, because it would let the outside world
;;; see how many recursive calls factorial has made, and what the
;;; intermediate values in them were.  An alternative does present
;;; itself, however: Define the list of interface cells, build the
;;; appropriate piece of network on them once, and use CALL-SITE to
;;; "call" it.  As you can see below, this lends itself to relatively
;;; good-looking recursion, at least.

;;; Hm.  This particular way to do it has the (mis?)feature that cells
;;; remember their call histories across reinitializations of the
;;; scheduler.

(define factorial (list (make-cell) (make-cell)))

;;; Hm.  (initialize-scheduler) also unalerts the constants :(
(initialize-scheduler)

;;; Normally I would do this with a let, but exposing the names 
;;; aids debugging
(define n (car factorial))
(define out (cadr factorial))
(define zero (make-cell))
(define control (make-cell))
(define not-control (make-cell))
(define one (make-cell))
(define n-again (make-cell))
(define n-1 (make-cell))
(define n-1! (make-cell))
(define empty (make-cell))
((constant (make-virtual-copies '() 0)) zero)
((constant (make-virtual-copies '() 1)) one)
(=? n zero control)
(inverter control not-control)
(conditional control one empty out)
(conditional not-control n empty n-again)
(subtractor n-again one n-1)
(call-site (list n-1 n-1!) factorial)
(multiplier n-1! n out)

#|
(define input (make-cell))
(define output (make-cell))
(call-site (list input output) factorial)
(add-content input (make-virtual-copies
		    (list (cons 'foo 6))
		    nothing))
(pp (content input))
#[virtual-copies 167]
(copy-alist ((foo . 6)))
(default-info (*the-nothing*))
;Unspecified return value

(pp (content output))
(*the-nothing*)
;Unspecified return value

(run)
(pp (content output))
#[virtual-copies 54]
(copy-alist ((foo . 720)))
(default-info (*the-nothing*))
|#



;;;; Fibonacci, again

(initialize-scheduler)

(define fibonacci (list (make-cell) (make-cell)))

(define n (car fibonacci))
(define fibn (cadr fibonacci))
(define one (make-cell))
(define two (make-cell))
(define n<2 (make-cell))
(define n-again (make-cell))
(define n-1 (make-cell))
(define n-2 (make-cell))
(define fibn-1 (make-cell))
(define fibn-2 (make-cell))
(define sum (make-cell))
(define empty (make-cell))

((constant (make-virtual-copies '() 1)) one)
((constant (make-virtual-copies '() 2)) two)
(<? n two n<2)
(conditional n<2 empty n n-again)
(subtractor n-again one n-1)
(subtractor n-again two n-2)
(call-site (list n-1 fibn-1) fibonacci)
(call-site (list n-2 fibn-2) fibonacci)
(adder fibn-1 fibn-2 sum)
(conditional n<2 n sum fibn)

#|
(define input (make-cell))
(define output (make-cell))
(call-site (list input output) fibonacci)
(add-content input (make-virtual-copies
		    (list (cons 'foo 8))
		    nothing))
(pp (content input))
#[virtual-copies 13]
(copy-alist ((foo . 8)))
(default-info (*the-nothing*))

(pp (content output))
(*the-nothing*)
;Unspecified return value

(run)
(pp (content output))
#[virtual-copies 68]
(copy-alist ((foo . 21)))
(default-info (*the-nothing*))

|#
