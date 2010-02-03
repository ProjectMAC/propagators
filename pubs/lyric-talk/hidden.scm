
(define (find-new-possibility! distribution)
  (let ((starting-determined-density
	 (distribution/determined-density distribution)))
    (distribution/refine-until!
     distribution
     (lambda (distribution)
       (> (distribution/determined-density distribution)
	  starting-determined-density)))))

(define (repeat n thunk)
  (if (= n 0)
      #!unspecific
      (begin
	(thunk)
	(repeat (- n 1) thunk))))
