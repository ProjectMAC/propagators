(define (disbelieving-func premise thunk)
  (let ((old-belief (premise-in? premise)))
    (kick-out! premise)
    (let ((answer (thunk)))
      (if old-belief
	  (bring-in! premise)
	  (kick-out! premise))
      answer)))

(define-syntax disbelieving
  (syntax-rules ()
    ((_ premise body ...)
     (disbelieving-func premise (lambda () body ...)))))

(define (fail-all cells)
  (process-one-contradiction
   (apply append (map v&s-support (filter v&s? (map tms-query (filter tms? (map content cells))))))))

(define (for-each-consistent-state proc cells)
  (set! cells (listify cells))
  (let loop ((last-run-result (run)))
    (if (eq? 'done last-run-result)
	(begin
	  (proc)
	  (fail-all cells)
	  (loop (run))))))

(define map-consistent-states (walker->mapper for-each-consistent-state))

