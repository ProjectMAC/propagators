(V&S (M a)) -> (M (V&S a))
(let ((goodie (v&s-value v&s)))
  (map goodie (lambda (x) (supported x (v&s-support v&s)))))
;;; therefore I can make (M (V&S a)) a monad

(TMS (M a)) -> (M (TMS a))
(let ((goodie (tms-query tms)))
  (map goodie (lambda (x) (make-tms (list x)))))
;;; therefore I can make (M (TMS a)) a monad

(Maybe (M a)) -> (M (Maybe a))
(if (nothing? thing)
    (return nothing)
    (map thing just))
;;; therefore I can make (M (Maybe a)) a monad

(SYMBOLIC (M a)) -> (M (SYMBOLIC a))
(let ((goodie (symbolic-expression symbolic)))
  (map goodie (lambda (x) (%make-symbolic x (symbolic-metadata symbolic)))))
;;; therefore I can make (M (SYMBOLIC a)) a monad

(SYMB-INEQ (M a)) -> (M (SYMB-INEQ a))
(let ((goodie (symb-ineq-expression symb-ineq)))
  (map goodie (lambda (x)
		 (make-symb-ineq
		  x
		  '()  ;; Not passing on the local stuff
		  (symb-ineq-global symb-ineq)))))
;;; therefore I can make (M (SYMB-INEQ a)) a monad

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defhandler generic-bind
  (lambda (thing f)
    (let ((f-prime
	   (lambda (x)
	     (generic-pseudobind
	      (lambda (y) (unFC (f y)))
	      x))))
      (FC (generic-bind f-prime (unFC thing)))))
  forward-composition? any?)

N a -> (a -> (M (N a))) -> M (N a)

(define (generic-pseudobind f x)
  (generic-map generic-join (generic-into (generic-map f x))))
