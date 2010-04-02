;;; Some example syntax-rules macros.  Just for fun.

(syntax-rules (else =>)
  ((cond (predicate => lambda-form)
	 clause ...)
   (let ((answer predicate))
     (if answer
	 (lambda-form answer)
	 (cond clause ...))))
  ((cond (predicate consequent ...)
	 clause ...)
   (if predicate
       (begin consequent ...)
       (cond clause ...)))
  ((cond (else consequent ...))
   (begin consequent ...))
  ((cond)
   unspecific))


(syntax-rules ()
  ((foo)
   (quote grumble)))
