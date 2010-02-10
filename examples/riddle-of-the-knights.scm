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

(define-syntax propagatify
  (sc-macro-transformer
   (lambda (form use-env)
     (let* ((propagatee-name (cadr form))
	    (new-name (symbol 'p: propagatee-name)))
       `(define ,new-name
	  (flat-function->propagator-expression
	   ,(close-syntax propagatee-name use-env)))))))

(define (conditional-wire control end1 end2)
  (switch control end1 end2)
  (switch control end2 end1))

(define (guess-link cell1 cell2)
  (let ((control (p:amb)))
    (conditional-wire control cell1 cell2)
    control))

(define (quadratic-guess-bijection cells1 cells2)
  (define (not-all-off . cells)
    (require (reduce p:or #f cells)))
  (let ((controls
	 (map (lambda (cell1)
		(map (lambda (cell2)
		       (guess-link cell1 cell2))
		     cells2))
	      cells1)))
    ;; I hope that the contents of cells1 and cells2 are forcibly
    ;; distinct, so that connecting one to two will automatically
    ;; fail.
    (for-each (lambda (cell1-controls)
		(apply not-all-off cell1-controls))
	      controls)
    (apply for-each not-all-off controls)))

(define (quadratic-extend-bijection cell-alist cells1 cells2)
  (for-each (lambda (cell-pair)
	      (pass-through (car cell-pair) (cdr cell-pair))
	      (pass-through (cdr cell-pair) (car cell-pair)))
	    cell-alist)
  (quadratic-guess-bijection
   (lset-difference eq? cells1 (map car cell-alist))
   (lset-difference eq? cells2 (map cdr cell-alist))))

(define-structure
  (horse (print-procedure
	  (simple-unparser-method
	   'horse (lambda (horse) (list (horse-name horse))))))
  name color reins plume pattern)

(propagatify horse-color)
(propagatify horse-plume)
(propagatify horse-reins)
(propagatify horse-pattern)

(define-syntax defhorse
  (syntax-rules ()
    ((_ name color reins plume pattern)
     (define name (make-horse 'name 'color 'reins 'plume 'pattern)))))

(defhorse h0 yellow red  white none)
(defhorse h1 brown  red  none  split)
(defhorse h2 white  none none  none)
(defhorse h3 yellow none red   none)
(defhorse h4 black  none red   none)
(defhorse h5 white  none none  none)
(defhorse h6 brown  red  none  arrows)
(defhorse h7 black  red  none  none)
(defhorse h8 gray   none none  crown)
(defhorse h9 white  none none  crown)

(define horses (list h0 h1 h2 h3 h4 h5 h6 h7 h8 h9))

(define (white? horse)
  (eq? (horse-color horse) 'white))

(define (black? horse)
  (eq? (horse-color horse) 'black))

(define (red-reined? horse)
  (eq? (horse-reins horse) 'red))

(define (plumed? horse)
  (not (eq? (horse-plume horse) 'none)))

(propagatify white?)
(propagatify black?)
(propagatify red-reined?)
(propagatify plumed?)


(define-structure
  (shield (print-procedure
	   (simple-unparser-method
	    'shield (lambda (shield) (list (shield-name shield))))))
  name shape pattern)

(propagatify shield-shape)
(propagatify shield-pattern)

(define-syntax defshield
  (syntax-rules ()
    ((_ name shape pattern)
     (define name (make-shield 'name 'shape 'pattern)))))

(defshield s0 square crown)
(defshield s1 square split)
(defshield s2 shield cross)
(defshield s3 shield triangles)
(defshield s4 square arrows)
(defshield s5 shield alt-split)
(defshield s6 shield triangles)
(defshield s7 round  split)
(defshield s8 round  crown)
(defshield s9 round  crown)

(define shields (list s0 s1 s2 s3 s4 s5 s6 s7 s8 s9))

(define knights '(k0 k1 k2 k3 k4 k5 k6 k7 k8 k9))

(define names
  '(sir-gerard sir-almeric sir-jules sir-sigismund sir-balthus
	       sir-fernando sir-caspar sir-gawain sir-harold sir-emilio))

(define-structure
  (knight
   (print-procedure
    (simple-unparser-method
     'knight (lambda (knight)
	       (list (knight-name knight)
		     (knight-shield knight)
		     (knight-horse knight))))))
  name
  shield
  horse)

(propagatify knight-name)
(propagatify knight-shield)
(propagatify knight-horse)

(define (knight-merge knight1 knight2)
  (let ((name-answer (merge (knight-name knight1) (knight-name knight2)))
	(shield-answer (merge (knight-shield knight1) (knight-shield knight2)))
	(horse-answer (merge (knight-horse knight1) (knight-horse knight2))))
    (cond ((and (eq? name-answer (knight-name knight1))
		(eq? shield-answer (knight-shield knight1))
		(eq? horse-answer (knight-horse knight1)))
	   knight1)
	  ((and (eq? name-answer (knight-name knight2))
		(eq? shield-answer (knight-shield knight2))
		(eq? horse-answer (knight-horse knight2)))
	   knight2)
	  (else
	   (make-knight name-answer shield-answer horse-answer)))))

(defhandler merge knight-merge knight? knight?)

(defhandler contradictory?
  (lambda (knight) (or (contradictory? (knight-name knight))
		       (contradictory? (knight-shield knight))
		       (contradictory? (knight-horse knight))))
  knight?)

(define (get thing map)
  (let ((cell (assq thing map)))
    (and cell (cdr cell))))

(specify-flat knight?)
(specify-flat shield?)
(specify-flat horse?)
(specify-flat symbol?)

(define (cell-table-lookup-function cell-table)
  (lambda (key)
    (let ((answer (content (or (get key cell-table)
			       (error "No owner for" key)))))
      (if (tms? answer)
	  (let ((best-answer (tms-query answer)))
	    (cond ((v&s? best-answer)
		   (make-tms (list best-answer)))
		  ((nothing? best-answer)
		   nothing)
		  (else
		   (error "Huh? owner-of confused by" best-answer))))
	  answer))))

(define (knight-maker name-cell shield-cell horse-cell output)
  (propagator (list name-cell shield-cell horse-cell)
    (lambda ()
      (add-content output
        (make-knight (content name-cell) (content shield-cell) (content horse-cell))))))

(define p:knight-maker (functionalize knight-maker))

(define (build-network)
  (let* ((knight-cells
	  (map (lambda (foo) (make-cell)) knights))
	 (knight-name-cells
	  (map (lambda (name)
		 (p:knight-maker name nothing nothing))
	       names))
	 (knight-shield-cells
	  (map (lambda (shield)
		 (p:knight-maker nothing shield nothing))
	       shields))
	 (knight-horse-cells
	  (map (lambda (horse)
		 (p:knight-maker nothing nothing horse))
	       horses))
	 (cell-table
	  (append
	   (map cons knights knight-cells)
	   (map cons names knight-name-cells)
	   (map cons shields knight-shield-cells)
	   (map cons horses knight-horse-cells)))
	 (owner-of (cell-table-lookup-function cell-table))
	 (p:owner (flat-function->propagator-expression owner-of))
	 (p:horse-of (lambda (thing)
		       (p:knight-horse (p:owner thing))))
	 (p:shield-of (lambda (thing)
			(p:knight-shield (p:owner thing))))
	 (p:name-of (lambda (thing)
		      (p:knight-name (p:owner thing)))))
    ;; This is how the depth-first version of this program specified
    ;; its knights-{shields|horses|names} bijections.
    #|
    (knights-shields
     (extend-distinct-map `((k0 . ,s1) (k1 . ,s2) (k2 . ,s4)
			    (k4 . ,s5) (k7 . ,s6) (k8 . ,s8) (k9 . ,s9))
			  knights shields))
    (knights-horses
     (extend-distinct-map `((k2 . ,h6) (k5 . ,h7) (k8 . ,h8) (k9 . ,h9))
			  knights horses))
    (knights-names
     (extend-distinct-map `((k1 . sir-gerard) (k3 . sir-harold)
			    (k4 . sir-emilio) (k5 . sir-almeric))
			  knights names))
    |#
    #|
    ;; If I specify mine this way, the resulting program takes about
    ;; a day to run, but produces the right answer, and experiences
    ;; approximately 20000 failures.  For reference,
    ;; (map length (map tms-values answers)) produces
    ;; (1461 987 1062 1508 838 1483 3376 2075 1794 3239)
    (quadratic-guess-bijection knight-cells knight-name-cells)
    (quadratic-guess-bijection knight-cells knight-shield-cells)
    (quadratic-guess-bijection knight-cells knight-horse-cells)
    (for-each (lambda (knight shield)
		(require (p:eq? shield (p:shield-of knight))))
	      '(    k0 k1 k2 k4 k7 k8 k9)
	      (list s1 s2 s4 s5 s6 s8 s9))
    (for-each (lambda (knight horse)
		(require (p:eq? horse (p:horse-of knight))))
	      '(    k2 k5 k8 k9)
	      (list h6 h7 h8 h9))
    (for-each (lambda (knight name)
		(require (p:eq? name (p:name-of knight))))
	      '(k1 k3 k4 k5)
	      '(sir-gerard sir-harold sir-emilio sir-almeric))
    |#
    ;; If I specify my bijections this way, the resulting program
    ;; also gets the right answer, but runs much faster:
    ;; ;process time: 885600 (868670 RUN + 16930 GC); real time: 900624
    ;; It also experiences only about 1397 failures, and
    ;; (map length (map tms-values answers)) produces
    ;; (87 16 17 58 17 5 423 83 17 17)
    (define (get-cell-pair key1 key2)
      (cons (get key1 cell-table)
	    (get key2 cell-table)))
    (quadratic-extend-bijection
     (map get-cell-pair
	  '(k1 k3 k4 k5)
	  '(sir-gerard sir-harold sir-emilio sir-almeric))
     knight-cells knight-name-cells)
    (quadratic-extend-bijection
     (map get-cell-pair
	  '(    k0 k1 k2 k4 k7 k8 k9)
	  (list s1 s2 s4 s5 s6 s8 s9))
     knight-cells knight-shield-cells)
    (quadratic-extend-bijection
     (map get-cell-pair
	  '(    k2 k5 k8 k9)
	  (list h6 h7 h8 h9))
     knight-cells knight-horse-cells)
    ;; Document
    (require (p:plumed? (p:horse-of 'sir-gerard)))
    (require (p:not (p:eq? (p:shield-shape (p:shield-of 'sir-almeric))
			   (p:shield-shape (p:shield-of 'sir-jules)))))
    (require (p:eq? (p:shield-pattern (p:shield-of 'sir-almeric))
		    (p:shield-pattern (p:shield-of 'sir-jules))))
					; Embedded
    (require (p:eq? 'cross (p:shield-pattern (p:shield-of 'sir-gerard))))
    (require (p:black? (p:horse-of 'sir-sigismund)))
    (require (p:white? (p:horse-of 'sir-balthus)))
    
    ;; Tapestry
    (require (p:red-reined? (p:horse-of s0)))
    (require (p:eq? h0 (p:horse-of 'sir-caspar)))
    (require (p:eq? h2 (p:horse-of 'sir-gawain)))
    (require (p:white? (p:horse-of s3)))
    (require (p:red-reined? (p:horse-of 'k7)))
    (require (p:red-reined? (p:horse-of s7)))
    
    ;; Horse-pattern
    (for-each (lambda (horse)
		(require (p:or (p:eq? (p:horse-pattern horse) 'none)
			       (p:eq? (p:horse-pattern horse)
				      (p:shield-pattern (p:shield-of horse))))))
	      horses) 
    knight-cells))

(define (find-solution)
  (initialize-scheduler)
  (let ((knights (build-network)))
    (run)
    (map content knights)))

(define-method generic-match ((pattern <vector>) (object rtd:knight))
  (generic-match
   pattern (vector 'knight (knight-name object)
		   (knight-shield object)
		   (knight-horse object))))

#|
 (define answer (show-time find-solution))
 (map v&s-value (map tms-query answer))
 (produces
  `(#(knight sir-sigismund ,s1 ,h4)
    #(knight sir-gerard    ,s2 ,h3)
    #(knight sir-fernando  ,s4 ,h6)
    #(knight sir-harold    ,s7 ,h1)
    #(knight sir-emilio    ,s5 ,h5)
    #(knight sir-almeric   ,s0 ,h7)
    #(knight sir-gawain    ,s3 ,h2)
    #(knight sir-caspar    ,s6 ,h0)
    #(knight sir-jules     ,s8 ,h8)
    #(knight sir-balthus   ,s9 ,h9)))
|#
