(define-structure
  (deck
   (print-procedure
    (simple-unparser-method
     'deck (lambda (deck)
	     (list (deck-name deck)
		   (deck-commander deck)
		   (deck-treasure deck)
		   (deck-supply deck))))))
  name commander treasure supply)

(define names '(poop quarter main gun lower))
(define commanders '(draconio bosun scurvy kraken windlass))
(define treasures
  '(casket-of-magenta tamarind-jewels galliard-lute calypso-figure goldenhall-talisman))
(define supplies '(ropes spare-sails rum biscuits firearms))

(propagatify deck-name)
(propagatify deck-commander)
(propagatify deck-treasure)
(propagatify deck-supply)

(define p:make-deck (functionalize (function->propagator-constructor make-deck)))

(specify-flat deck?)

(define (deck-merge deck1 deck2)
  (let ((name-answer (merge (deck-name deck1) (deck-name deck2)))
	(commander-answer (merge (deck-commander deck1) (deck-commander deck2)))
	(treasure-answer (merge (deck-treasure deck1) (deck-treasure deck2)))
	(supply-answer (merge (deck-supply deck1) (deck-supply deck2))))
    (cond ((and (eq? name-answer (deck-name deck1))
		(eq? commander-answer (deck-commander deck1))
		(eq? treasure-answer (deck-treasure deck1))
		(eq? supply-answer (deck-supply deck1)))
	   deck1)
	  ((and (eq? name-answer (deck-name deck2))
		(eq? commander-answer (deck-commander deck2))
		(eq? treasure-answer (deck-treasure deck2))
		(eq? supply-answer (deck-supply deck2)))
	   deck2)
	  (else
	   (make-deck name-answer commander-answer treasure-answer supply-answer)))))

(assign-operation 'merge deck-merge deck? deck?)

(assign-operation 'contradictory?
  (lambda (deck) (or (contradictory? (deck-name deck))
		     (contradictory? (deck-commander deck))
		     (contradictory? (deck-treasure deck))
		     (contradictory? (deck-supply deck))))
  deck?)

(define (build-network)
  (let* ((deck-cells
	  (map (lambda (name)
		 (p:make-deck name nothing nothing nothing))
	       names))
	 (deck-commander-cells
	  (map (lambda (commander)
		 (p:make-deck nothing commander nothing nothing))
	       commanders))
	 (deck-treasure-cells
	  (map (lambda (treasure)
		 (p:make-deck nothing nothing treasure nothing))
	       treasures))
	 (deck-supply-cells
	  (map (lambda (supply)
		 (p:make-deck nothing nothing nothing supply))
	       supplies))
	 (cell-table
	  (append
	   (map cons names deck-cells)
	   (map cons commanders deck-commander-cells)
	   (map cons treasures deck-treasure-cells)
	   (map cons supplies deck-supply-cells)))
	 (deck-of (cell-table-lookup-function cell-table))
	 (p:deck (flat-function->propagator-expression deck-of))
	 (p:deck-name-of (lambda (thing)
			   (p:deck-name (p:deck thing))))
	 (p:commander-of (lambda (thing)
			   (p:deck-commander (p:deck thing))))
	 (p:treasure-of (lambda (thing)
			  (p:deck-treasure (p:deck thing))))
	 (p:supply-of (lambda (thing)
			(p:deck-supply (p:deck thing)))))
    (quadratic-guess-bijection deck-cells deck-commander-cells)
    (quadratic-guess-bijection deck-cells deck-treasure-cells)
    (quadratic-guess-bijection deck-cells deck-supply-cells)

    (require (p:eq? 'gun (p:deck-name-of 'casket-of-magenta)))
    (require (p:or (p:eq? 'casket-of-magenta (p:treasure-of 'scurvy))
		   (p:eq? 'tamarind-jewels (p:treasure-of 'scurvy))))
    (require (p:not (p:eq? 'gun (p:deck-name-of 'windlass))))
    (require (p:not (p:eq? 'gun (p:deck-name-of 'bosun))))
    (require (p:not (p:eq? 'lower (p:deck-name-of 'galliard-lute))))
    (require (p:not (p:eq? 'poop (p:deck-name-of 'spare-sails))))
    (require (p:not (p:eq? 'main (p:deck-name-of 'windlass))))
    (require (p:not (p:eq? 'goldenhall-talisman (p:treasure-of 'bosun))))
    (require (p:not (p:eq? 'galliard-lute (p:treasure-of 'bosun))))
    (require (p:not (p:eq? 'goldenhall-talisman (p:treasure-of 'draconio))))
    (require (p:not (p:eq? 'galliard-lute (p:treasure-of 'draconio))))
    (require (p:not (p:eq? 'biscuits (p:supply-of 'kraken))))
    (require (p:not (p:eq? 'firearms (p:supply-of 'kraken))))

    (require (p:not (p:eq? 'quarter (p:deck-name-of 'galliard-lute))))
    (require (p:not (p:eq? 'quarter (p:deck-name-of 'calypso-figure))))
    (require (p:not (p:eq? 'quarter (p:deck-name-of 'spare-sails))))
    (require (p:not (p:eq? 'kraken (p:commander-of 'casket-of-magenta))))
    (require (p:not (p:eq? 'windlass (p:commander-of 'spare-sails))))
    (require (p:not (p:eq? 'windlass (p:commander-of 'biscuits))))
    (require (p:eq? 'main (p:deck-name-of 'firearms)))
    (require (p:not (p:eq? 'draconio (p:commander-of 'spare-sails))))
    (require (p:not (p:eq? 'draconio (p:commander-of 'biscuits))))
    (require (p:not (p:eq? 'rum (p:supply-of 'casket-of-magenta))))
    (require (p:not (p:eq? 'scurvy (p:commander-of 'spare-sails))))
    (require (p:not (p:eq? 'biscuits (p:supply-of 'casket-of-magenta))))
    (require (p:not (p:eq? 'biscuits (p:supply-of 'goldenhall-talisman))))

    deck-cells))

(define (find-solution)
  (initialize-scheduler)
  (let ((decks (build-network)))
    (run)
    (map content decks)))

(define-method generic-match ((pattern <vector>) (object rtd:deck))
  (generic-match
   pattern (vector 'deck (deck-name object)
		   (deck-commander object)
		   (deck-treasure object)
		   (deck-supply object))))

(in-test-group
 albatross-conundrum
 (define-test
   (assert-matches
    '(#(deck poop windlass galliard-lute rum)
      #(deck quarter bosun tamarind-jewels biscuits)
      #(deck main draconio calypso-figure firearms)
      #(deck gun scurvy casket-of-magenta ropes)
      #(deck lower kraken goldenhall-talisman spare-sails))
    (map v&s-value (map tms-query (show-time find-solution))))))
