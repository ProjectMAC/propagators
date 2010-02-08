(declare (usual-integrations make-cell))

(define-structure sudoku-board rt-size cells)

(define (empty-sudoku-board rt-size)
  (let ((size (square rt-size)))
    (make-sudoku-board rt-size
     (make-initialized-vector size
      (lambda (row)
	(make-initialized-vector size
         (lambda (col)
	   (make-cell))))))))

(define (sudoku-board-size board)
  (square (sudoku-board-rt-size board)))

(define (sudoku-board-ref board row col)
  (vector-ref (vector-ref (sudoku-board-cells board) row) col))

(define (sudoku-board-cells board)
  (apply append (sudoku-board-rows board)))

(define (sudoku-board-rows board)
  (map vector->list (vector->list (sudoku-board-cells board))))

(define (sudoku-board-cols board)
  (map (lambda (col)
	 (map (lambda (row)
		(sudoku-board-ref board row col))
	      (iota (sudoku-board-size board))))
       (iota (sudoku-board-size board))))

(define (sudoku-board-square-at board row col)
  (apply append (map (lambda (drow)
		       (map (lambda (dcol)
			      (sudoku-board-ref board (+ row drow) (+ col dcol)))
			    (iota (sudoku-board-rt-size board))))
		     (iota (sudoku-board-rt-size board)))))

(define (sudoku-board-squares board)
  (apply append (map (lambda (row)
		       (map (lambda (col)
			      (sudoku-board-square-at board row col))
			    (map (lambda (x) (* x (sudoku-board-rt-size board)))
				 (iota (sudoku-board-rt-size board)))))
		     (map (lambda (x) (* x (sudoku-board-rt-size board)))
			  (iota (sudoku-board-rt-size board))))))

(define (add-different-constraints! board)
  (for-each (lambda (shape)
	      (for-each (lambda (cells)
			  (apply all-different cells))
			(shape board)))
	    (list sudoku-board-rows sudoku-board-cols sudoku-board-squares)))

(define (add-known-values! board board-by-rows)
  (for-each (lambda (board-row spec-row)
	      (for-each (lambda (board-cell spec)
			  (if (and (integer? spec)
				   (<= 1 spec 9))
			      (add-content board-cell (one-choice spec))))
			board-row spec-row))
	    (sudoku-board-rows board) board-by-rows))

(define (add-guessers! board)
  (for-each (lambda (row)
	      (for-each (lambda (cell)
			  (add-guesser! cell (sudoku-board-size board)))
			row))
	    (sudoku-board-rows board)))

(define (parse-sudoku board-by-rows)
  (let* ((rt-size (inexact->exact (sqrt (length board-by-rows))))
	 (board (empty-sudoku-board rt-size)))
    (add-different-constraints! board)
    (add-known-values! board board-by-rows)
    (add-guessers! board)
    board))

(define (print-sudoku-board board)
  (for-each (lambda (row)
	      (for-each (lambda (cell)
			  (if (one-choice? (content cell))
			      (display (the-one-choice (content cell)))
			      (display "?")))
			row)
	      (newline))
	    (sudoku-board-rows board))
  board)

(define-test (parse-smoke)
  (initialize-scheduler)
  (check
   (equal?
    "????\n????\n????\n?3??\n"
    (with-output-to-string
      (lambda ()
	(print-sudoku-board
	 (parse-sudoku
	  '((0 0 0 0) (0 0 0 0) (0 0 0 0) (0 3 0 0)))))))))

(define (do-sudoku board-by-rows)
  (initialize-scheduler)
  (let ((board (parse-sudoku board-by-rows)))
    (run)
    (print-sudoku-board board)))

(define (count-failures thunk)
  (fluid-let ((*number-of-calls-to-fail* 0))
    (let ((value (thunk)))
      (pp `(failed ,*number-of-calls-to-fail* times))
      value)))

(define (all-different . cells)
  (require-distinct cells))

(define (add-guesser! cell size)
  (if (not (integer? (content cell)))
      (one-of (iota size 1) cell)))

(define (one-choice? thing)
  (or (integer? thing)
      (and (tms? thing)
	   (not (nothing? (tms-query thing))))))

(define (the-one-choice thing)
  (if (integer? thing)
      thing
      (v&s-value (tms-query thing))))

(define (one-choice thing)
  thing)

(define-test (solve-smoke)
  (check
   (equal?
    "3124\n2431\n1243\n4312\n"
    (with-output-to-string
      (lambda ()
	(do-sudoku '((0 0 0 0) (0 0 0 0) (0 0 0 0) (0 3 0 0))))))))

;;; On a nontrivially loaded machine:
;;; process time: 184760 (169200 RUN + 15560 GC); real time: 255528
;;; process time: 184860 (168930 RUN + 15930 GC); real time: 269679
;;; 629 failures
;;; Interpreted; 4198 propagators (1944 from require-distinct and 2254
;;; from guessers)
;; This test takes too long to run
#;
(define-test (solve)
  (set! *number-of-calls-to-fail* 0)
  (check (equal?
	  (string-append
	   "327194658\n"
	   "846325179\n"
	   "519687243\n"
	   "172563894\n"
	   "653948721\n"
	   "498712365\n"
	   "764851932\n"
	   "985236417\n"
	   "231479586\n")
	  (with-output-to-string
	    (lambda ()
	      (do-sudoku
	       '((0 0 7 0 0 0 6 5 0)
		 (8 4 6 0 0 5 1 0 9)
		 (0 0 9 0 0 0 0 0 3)
		 (1 0 0 5 6 0 0 9 4)
		 (0 0 0 9 4 8 0 0 0)
		 (4 9 0 0 1 2 0 0 5)
		 (7 0 0 0 0 0 9 0 0)
		 (9 0 5 2 0 0 4 1 7)
		 (0 3 1 0 0 0 5 0 0)))))))
  (check (= 629 *number-of-calls-to-fail*)))

;;; And this one seems to run out of memory (with --heap 6000)
;;; exhibiting at least 940 failures, any many more nogood sets.
#;
(show-time
 (lambda ()
   (count-failures
    (lambda ()
      (do-sudoku
       '((0 0 8 0 1 0 0 4 0)
	 (0 4 1 6 0 0 7 8 0)
	 (0 0 6 0 7 8 0 0 0)
	 (0 0 0 7 0 0 9 3 0)
	 (0 9 0 0 0 0 0 5 0)
	 (0 2 3 0 0 5 0 0 0)
	 (0 0 0 9 5 0 8 0 0)
	 (0 8 9 0 0 4 5 7 0)
	 (0 7 0 0 8 0 1 0 0)))))))
