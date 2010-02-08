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

