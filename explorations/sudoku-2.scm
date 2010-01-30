(load "../../propagator/sets")

(define (singleton-set? thing)
  (and (set? thing)
       (= 1 (length (set->list thing)))))

(define (one-choice? thing)
  (or (integer? thing)
      (and (tms? thing)
	   (not (nothing? (tms-query thing)))
	   (let ((content (v&s-value (tms-query thing))))
	     (or (integer? content)
		 (singleton-set? content))))))

(define (the-one-choice thing)
  (if (integer? thing)
      thing
      (let ((content (v&s-value (tms-query thing))))
	(cond ((singleton-set? content)
	       (car (set->list content)))
	      ((integer? content)
	       content)
	      (else
	       (error "Huh? the-one-choice" thing))))))

(define (one-choice thing)
  thing)

(define (add-set-split! cell size grain)
  (call-with-values
      (lambda ()
	(partition (lambda (n)
		     (< (modulo n (* 2 grain)) grain))
		   (iota size 1)))
    (lambda (in out)
      (one-of (list (make-set in) (make-set out))
	      cell))))

(define (add-guesser! cell size)
  (let loop ((grain 1))
    (if (>= grain size)
	'done
	(begin (add-set-split! cell size grain)
	       (loop (* 2 grain)))))
  ((constant (make-set (iota size 1))) cell))

----------------------------------------------------------------------

(define (all-different . cells)
  (require-distinct cells))

