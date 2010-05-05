;; M a X (a -> M b) -> M b
(define generic-bind (make-generic-operator 2 'bind ...))

;; a -> M a
;; (define generic-return ...)

(define-structure just value)
(define-structure nothing)

(define (maybe? thing)
  (or (just? thing)
      (nothing? thing)))

(define (maybe-bind maybe func)
  (if (nothing? maybe)
      nothing
      (func (just-value maybe))))

(define (maybe-return value)
  (just value))


(defhandler generic-bind maybe-bind maybe? func)

;; a X [(a,b)] -> maybe b
(define (my-assq item list)
  (let ((answer (assq item list)))
    (if (pair? answer)
	(just (cdr answer))
	nothing)))


;; a X [(a,b)] X [(b,c)] -> maybe c
(define (path-lookup item l1 l2)
  (generic-bind (my-assq item l1)
   (lambda (itemb)
     (my-assq itemb l2))))


(define (path-lookup2 item l1 l2)
  (generic-bind (my-assq item l1)
   (lambda (itemb)
     (generic-bind (return (* 2 itemb))
      (lambda (itemc)
	(my-assq itemc l2))))))


(define-structure returned value)

(define (return value)
  (make-returned value))

(defhandler generic-bind
  (lambda (returned func)
    (func (returned-value returned)))
  returned?)


;; [a] X (a -> [b]) -> [b]
(define (list-bind lst func)
  (apply append (map (lambda (frob)
		        (->list (func frob)))
		     lst)))

(define (->list frob)
  (cond ((returned? frob)
	 (list (returned-value frob)))
	((list? frob)
	 frob)
	(else (error "Monad collision!" frob))))

(define (demander ok? returned->ok)
  (lambda (thing)
    (cond ((ok? thing)
	   thing)
	  ((returned? thing)
	   (returned->ok (returned-value thing)))
	  (else (error "Broken thing!" thing ok?)))))

(define ->list (demander list? list))

(define (demand ok? thing)
  (cond ((ok? thing)
	 thing)
	((returned? thing)
	 ((eq-get ok? 'maker) (returned-value thing)))
	(else (error "Broken thing!" thing ok?))))

(eq-put! list? 'maker list)

(define (list-bind lst func)
  (apply append (map (lambda (frob)
		       (demand list? (func frob)))
		     lst)))

;; (a X b -> c) -> (F a X F b -> F c)


;; (a X b -> c) X (units X units -> units) -> (united a X united b -> united c)

;;; ------------------------------------------------------------------

;;; Have generic operators, like +, *
;;; Each kind of component object has a tag -- may be coercions
;;;   Works on numbers
;;;   Works on unit objects
;;;   Works on symbolic expressions
;;;   ...

;;; There are objects that may incorporate any or all of the above,
;;;  and the components can be accessed by component accessors.
;;;  New base objects are composed by specifying the components to be
;;;   combined.

;;; Simple case is parallel application

(define-structure thing components)

(defhandler generic-apply foo unary-operator? thing?)

(define foo (operator thing)
  (make-thing (map generic-apply operator (components thing))))
