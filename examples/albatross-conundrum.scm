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

(declare (usual-integrations make-cell))

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

(define deck-names '(poop quarter main gun lower))
(define commanders '(draconio bosun scurvy kraken windlass))
(define treasures
  '(casket-of-magenta tamarind-jewels galliard-lute calypso-figure goldenhall-talisman))
(define supplies '(ropes spare-sails rum biscuits firearms))

(propagatify deck-name)
(propagatify deck-commander)
(propagatify deck-treasure)
(propagatify deck-supply)

(define e:make-deck (functionalize (function->propagator-constructor make-deck)))
(name! make-deck 'make-deck)

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

(defhandler merge deck-merge deck? deck?)

(defhandler contradictory?
  (lambda (deck) (or (contradictory? (deck-name deck))
		     (contradictory? (deck-commander deck))
		     (contradictory? (deck-treasure deck))
		     (contradictory? (deck-supply deck))))
  deck?)

(define (build-albatross-network)
  (let* ((deck-cells
	  (map (lambda (name)
		 (e:make-deck name nothing nothing nothing))
	       deck-names))
	 (deck-commander-cells
	  (map (lambda (commander)
		 (e:make-deck nothing commander nothing nothing))
	       commanders))
	 (deck-treasure-cells
	  (map (lambda (treasure)
		 (e:make-deck nothing nothing treasure nothing))
	       treasures))
	 (deck-supply-cells
	  (map (lambda (supply)
		 (e:make-deck nothing nothing nothing supply))
	       supplies))
	 (cell-table
	  (append
	   (map cons deck-names deck-cells)
	   (map cons commanders deck-commander-cells)
	   (map cons treasures deck-treasure-cells)
	   (map cons supplies deck-supply-cells)))
	 (cell-of (cell-grabber cell-table))
	 (e:deck-name-of (lambda (thing)
			   (e:deck-name (cell-of thing))))
	 (e:commander-of (lambda (thing)
			   (e:deck-commander (cell-of thing))))
	 (e:treasure-of (lambda (thing)
			  (e:deck-treasure (cell-of thing))))
	 (e:supply-of (lambda (thing)
			(e:deck-supply (cell-of thing)))))
    (quadratic-guess-bijection deck-cells deck-commander-cells)
    (quadratic-guess-bijection deck-cells deck-treasure-cells)
    (quadratic-guess-bijection deck-cells deck-supply-cells)

    (require (e:eq? 'gun (e:deck-name-of 'casket-of-magenta)))
    (require (e:or (e:eq? 'casket-of-magenta (e:treasure-of 'scurvy))
		   (e:eq? 'tamarind-jewels (e:treasure-of 'scurvy))))
    (require (e:not (e:eq? 'gun (e:deck-name-of 'windlass))))
    (require (e:not (e:eq? 'gun (e:deck-name-of 'bosun))))
    (require (e:not (e:eq? 'lower (e:deck-name-of 'galliard-lute))))
    (require (e:not (e:eq? 'poop (e:deck-name-of 'spare-sails))))
    (require (e:not (e:eq? 'main (e:deck-name-of 'windlass))))
    (require (e:not (e:eq? 'goldenhall-talisman (e:treasure-of 'bosun))))
    (require (e:not (e:eq? 'galliard-lute (e:treasure-of 'bosun))))
    (require (e:not (e:eq? 'goldenhall-talisman (e:treasure-of 'draconio))))
    (require (e:not (e:eq? 'galliard-lute (e:treasure-of 'draconio))))
    (require (e:not (e:eq? 'biscuits (e:supply-of 'kraken))))
    (require (e:not (e:eq? 'firearms (e:supply-of 'kraken))))

    (require (e:not (e:eq? 'quarter (e:deck-name-of 'galliard-lute))))
    (require (e:not (e:eq? 'quarter (e:deck-name-of 'calypso-figure))))
    (require (e:not (e:eq? 'quarter (e:deck-name-of 'spare-sails))))
    (require (e:not (e:eq? 'kraken (e:commander-of 'casket-of-magenta))))
    (require (e:not (e:eq? 'windlass (e:commander-of 'spare-sails))))
    (require (e:not (e:eq? 'windlass (e:commander-of 'biscuits))))
    (require (e:eq? 'main (e:deck-name-of 'firearms)))
    (require (e:not (e:eq? 'draconio (e:commander-of 'spare-sails))))
    (require (e:not (e:eq? 'draconio (e:commander-of 'biscuits))))
    (require (e:not (e:eq? 'rum (e:supply-of 'casket-of-magenta))))
    (require (e:not (e:eq? 'scurvy (e:commander-of 'spare-sails))))
    (require (e:not (e:eq? 'biscuits (e:supply-of 'casket-of-magenta))))
    (require (e:not (e:eq? 'biscuits (e:supply-of 'goldenhall-talisman))))

    deck-cells))

(define (find-albatross-solution)
  (initialize-scheduler)
  (let ((decks (build-albatross-network)))
    (run)
    (map content decks)))

(define-method generic-match ((pattern <vector>) (object rtd:deck))
  (generic-match
   pattern (vector 'deck (deck-name object)
		   (deck-commander object)
		   (deck-treasure object)
		   (deck-supply object))))

#|
 (define answer (show-time find-albatross-solution))
 (map v&s-value (map tms-query answer))
 (produces
  '(#(deck poop windlass galliard-lute rum)
    #(deck quarter bosun tamarind-jewels biscuits)
    #(deck main draconio calypso-figure firearms)
    #(deck gun scurvy casket-of-magenta ropes)
    #(deck lower kraken goldenhall-talisman spare-sails)))
|#
