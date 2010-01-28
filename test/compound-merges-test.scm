(in-test-group
 compound-merges
 (define-each-check
   (generic-match (cons nothing nothing) (merge (cons nothing nothing) nothing))
   (generic-match (cons nothing nothing) (merge nothing (cons nothing nothing)))
   (generic-match
    (cons nothing nothing) (merge (cons nothing nothing) (cons nothing nothing)))
   (generic-match (cons 4 nothing) (merge nothing (cons 4 nothing)))
   (generic-match (cons 4 nothing) (merge (cons 4 nothing) nothing))
   (generic-match (cons 4 nothing) (merge (cons 4 nothing) (cons 4 nothing)))
   (generic-match the-contradiction (merge 4 (cons 5 6)))
   (generic-match the-contradiction (merge 4 (cons 4 5)))
   (generic-match the-contradiction (merge 4 (cons nothing nothing)))
   (generic-match '(4 . 5) (merge (cons nothing 5) (cons 4 nothing)))
   (generic-match '(4 . 5) (merge (cons 4 nothing) (cons nothing 5)))
   (generic-match '(4 . 5) (merge (cons 4 5) (cons 4 nothing)))
   (generic-match '(4 . 5) (merge (cons 4 nothing) (cons 4 5)))
   (generic-match '(4 . 5) (merge (cons 4 5) (cons 4 5)))
   ;; It's not entirely clear what to do with
   #;
   (merge (make-tms (supported (cons (make-tms (supported 4 '(fred))) nothing)
			       '(george)))
	  (make-tms (supported (cons (make-tms (supported 3 '(bill))) nothing)
			       '(joe))))
   ;; because if it signals a contradiction, both george and joe
   ;; should be implicated.  Likewise,
   #;
   (merge (make-tms (supported (cons (make-tms (supported 4 '(fred))) nothing)
			       '(george)))
	  (make-tms (supported (cons nothing (make-tms (supported 3 '(bill))))
			       '())))
   ;; is mysterious because the result should, I think, look like
   ;; (4:fred,george . 3:bill), but I'm not sure how to make it do
   ;; that.  Also,
   #;
   (merge (make-tms (supported (cons (make-tms (supported 4 '(fred))) nothing)
			       '(george)))
	  (make-tms (supported the-contradiction '(fred george))))
   ;; (or the moral equivalents thereof) should retain the fact that
   ;; george said there was a pair here (in case there's a pair?
   ;; propagator watching), but can probably afford to get rid of the
   ;; 4:fred inside, because if the pair is believed, then george is,
   ;; so fred isn't.
))
