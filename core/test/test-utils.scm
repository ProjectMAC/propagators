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

