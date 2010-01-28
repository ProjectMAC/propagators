;;; Naive conditional from abstraction.tex

(define (conditional p if-true if-false output)
  (propagator (list p if-true if-false)
    (lambda ()
      (let ((predicate (content p)))
        (if (nothing? predicate)
            'done
            (add-content output
                         (if predicate
                             (content if-true)
                             (content if-false))))))))

;;; More sophisticated conditional from generic-primitives-4.tex

(define (conditional p if-true if-false output)
  (propagator (list p if-true if-false)
    (lambda ()
      (let ((predicate (content p)))
        (if (nothing? predicate)
            'done
            (add-content
             output
             (if (generic-true? predicate)
                 (generic-ignore-first predicate (content if-true))
                 (generic-ignore-first predicate (content if-false)))))))))

(define true? (lambda (x) (not (not x))))

(define generic-true? (make-generic-operator 1 'true? true?))
(defhandler 'true?
  (lambda (v\&s) (generic-true? (v\&s-value v\&s)))
  v\&s?)
(defhandler 'true?
  (lambda (tms) (generic-true? (tms-query tms)))
  tms?)

(define generic-ignore-first
  (make-generic-operator 2 'ignore-first ignore-first))

(coerce-v\&s generic-ignore-first)
(coerce-tms generic-ignore-first)

;;; Yet another sophisticated conditional, from abstraction.scm

(define (conditional p if-true if-false output)
  (propagator (list p if-true if-false)
    (lambda ()
      (add-content output
        (apply generic-ternary-if (map content (list p if-true if-false)))))))

;; This seems to be the same as
(define conditional (function->propagator-constructor generic-ternary-if))
;; and may therefore be simpler to introduce in the one-armed form

(define generic-ternary-if
  (make-generic-operator 3 'ternary-if
   (lambda (predicate consequent alternative)
     (if (nothing? predicate)
	 nothing
	 (if (generic-true? predicate)
	     (generic-ignore-first predicate consequent)
	     (generic-ignore-first predicate alternative))))))

(assign-operation
 'ternary-if (virtual-copy-unpacking generic-ternary-if)
 virtual-copies? virtual-copies? virtual-copies?)

;;; Perhaps a yet other general version, that exposes Church booleans,
;;; might go like this:

(define (conditional p if-true if-false output)
  (propagator (list p if-true if-false output)
    (lambda ()
      (add-content output
	(generic-apply
	 (generic-normalize-to-Church-boolean (content p))
	 (map content (list if-true if-false)))))))

;;; both of these generics would then have appropriate methods for
;;; nothings (and virtual copies).  In particular, apply has to merge
;;; the "extra sctructure" of the procedure onto the "extra structure"
;;; of the argument, just like a monad.  The generic-ignore-first
;;; approach avoided this problem because application of a
;;; multiargument procedure did the structure merging (which of course
;;; is the same thing because of currying).


;;; Possible insight: In my world, a one-armed IF is one that just has
;;; a permanent nothing in its other arm.  Is the fact that I can get
;;; away with this equivalent to the fact that in my world, IF can 
;;; just be a function (modulo pulls)?
