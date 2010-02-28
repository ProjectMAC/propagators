(define (plan-trip source destination method)
  (let-cells (cost time annoyance)
    (air-travel      source destination method cost time annoyance)
    (train-travel    source destination method cost time annoyance)
    (intercity-bus-travel source destination method cost time annoyance)
    (car-travel      source destination method cost time annoyance)
    (subway-travel   source destination method cost time annoyance)
    (city-bus-travel source destination method cost time annoyance)
    (taxi-travel     source destination method cost time annoyance)
    (bicycle-travel  source destination method cost time annoyance)
    (walking-travel  source destination method cost time annoyance)))

(define (doit go-worldview input output build-it)
  ;; The input is a bunch of conditional input information.  The
  ;; output is a bunch of conditional output information.  The
  ;; go-worldview starts empty.  When it is written, the device reads
  ;; that worldview from the input, and goes off and does the
  ;; computation.  When an answer shows up on the internal output, it
  ;; is reconditioned on the go-worldview and written to the external
  ;; output.  Also at this point, the device is reset for the next use
  ;; by rebuilding the internal input and output cells, and clearing
  ;; the go-worldview cell.  The outside world knows the device is
  ;; ready for use by examining the go-worldview cell.  Substructure
  ;; assumes responsibility for not jumping the gun, and writing the
  ;; full answer to the internal output cell all at once.
  ;; The build-it procedure attaches the internal device to the
  ;; internal input and output cells.
  (let-cell status
    (define (builder status)
      (define (do-build)
	(if (nothing? (content status))
	    (let-cells (in-worldview in-input in-output)
	      (build-it in-input in-output)
	      (worldview-selector go-worldview input in-input)
	      ;; This indirection prevents worldview-attacher from
	      ;; rewriting the status cell when the go-worldview
	      ;; changes (assuming the in-worldview cell rejects
	      ;; updates).
	      (copy go-worldview in-worldview)
	      (worldview-attacher in-worldview in-output output status)
	      (add-content status 'built))))
      (propagator status do-build))
    (define (destroyer status)
      (define (do-destroy)
	(if (eq? 'done (content status))
	    (begin (add-content status *clear*)
		   (add-content go-worldview *clear*))))
      (propagator status do-destroy))
    (builder status)
    (destroyer status)))
