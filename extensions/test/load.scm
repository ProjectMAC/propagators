(define (load-relative filename)
  (with-working-directory-pathname 
   (directory-namestring (current-load-pathname))
   (lambda () (load filename))))

(define-method generic-match ((pattern <vector>) (object :symb-ineq))
  (generic-match
   pattern (vector 'symb-ineq (symb-ineq-expression object)
		   (symb-ineq-local object)
		   (symb-ineq-global object))))

(define-method generic-match ((pattern <vector>) (object :symbolic))
  (generic-match
   pattern (vector 'symbolic (symbolic-expression object)
		   (symbolic-metadata object))))

(define-method generic-match ((pattern <vector>) (object :symbolic-metadata))
  (generic-match
   pattern (vector 'metadata (symbolic-variable-order object)
		   (symbolic-substitutions object)
		   (symbolic-residual-equations object))))

(define-method generic-match ((pattern <vector>) (object rtd:frs))
  (if (stale-frs? object)
      (generic-match
       pattern (vector 'stale-frs (frs-value object)
		       (frs-support object)))
      (generic-match
       pattern (vector 'frs (frs-value object)
		       (frs-support object)))))

(define-method generic-match ((pattern <vector>) (object rtd:frpremise))
  (generic-match
   pattern (vector 'frp (frpremise-identity object)
		   (frpremise-timestamp object))))

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

(load-relative "inequality-test")
(load-relative "symbolics-test")
(load-relative "symbolics-ineq-test")
(load-relative "voltage-divider-test")
(load-relative "bridge-rectifier-test")
(load-relative "functional-reactive-test")
(load-relative "environments-test")
(load-relative "graph-drawing-test")
