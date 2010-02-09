(declare (usual-integrations))

(define-structure (symbolic-metadata (conc-name symbolic-))
  variable-order
  substitutions
  residual-equations)

(define (empty-metadata)
  (make-symbolic-metadata '() '() '()))

(define (same-metadata? meta1 meta2)
  (and (equal? (symbolic-variable-order meta1)
	       (symbolic-variable-order meta2))
       (equal? (symbolic-substitutions meta1)
	       (symbolic-substitutions meta2))
       (equal? (symbolic-residual-equations meta1)
	       (symbolic-residual-equations meta2))))

(define (combine-variable-orders order1 order2)
  (append
   order1
   (filter (lambda (v)
	     (not (member v order1 same-variable?)))
	   order2)))

(define (same-variable? var1 var2)
  (eq? var1 var2))

(define (unify-metadata meta1 meta2)
  (let ((new-variable-order (combine-variable-orders
			     (symbolic-variable-order meta1)
			     (symbolic-variable-order meta2))))
    (let ((solution
	   (solve-incremental
	    (append
	     (substs->equations (symbolic-substitutions meta2))
	     (symbolic-residual-equations meta1)
	     (symbolic-residual-equations meta2))
	    new-variable-order
	    (symbolic-substitutions meta1))))
      ;; TODO Check the solution for being contradictory
      (make-symbolic-metadata
       new-variable-order
       (substitutions solution)
       (residual-equations solution)))))

(define (list-unify-metadata metadatas)
  (reduce unify-metadata (empty-metadata) metadatas))

(define-structure (symbolic (constructor %make-symbolic))
  expression
  metadata)

(define (make-symbolic expression metadata)
  (%make-symbolic
   (simplify (apply-substitutions expression (symbolic-substitutions metadata)))
   metadata))

(define (same-symbolic? symb1 symb2)
  ;; TODO I really want good generic equality!
  (and (symbolic? symb1)
       (symbolic? symb2)
       (equal? (symbolic-expression symb1)
	       (symbolic-expression symb2))
       (same-metadata? (symbolic-metadata symb1)
		       (symbolic-metadata symb2))))

(define (symbolic-merge symb1 symb2)
  (let* ((new-metadata (unify-metadata (symbolic-metadata symb1)
				       (symbolic-metadata symb2)))
	 (expr1 (symbolic-expression symb1))
	 (expr2 (symbolic-expression symb2))
	 (equation (symb:- expr1 expr2))
	 (solution
	  (solve-incremental
	   (cons (make-equation equation '())
		 (symbolic-residual-equations new-metadata))
	   (symbolic-variable-order new-metadata)
	   (symbolic-substitutions new-metadata))))
    (cond ((eqn-contradiction? solution)
	   the-contradiction)
	  (else
	   (let ((answer
		  (make-symbolic
		   expr1
		   (make-symbolic-metadata
		    (symbolic-variable-order new-metadata)
		    (substitutions solution)
		    (residual-equations solution)))))
	     (cond ((same-symbolic? symb1 answer) symb1)
		   ;; This comparison may be spuriously wrong sometimes
		   ;; because the answer is made from expr1
		   ((same-symbolic? symb2 answer) symb2)
		   (else answer)))))))

(defhandler merge symbolic-merge symbolic? symbolic?)

;;; Two ways to add symbolic expressions as a partial information type.
;;; One way is to use the nary-unpacking machinery:

(defhandler generic-unpack
  (lambda (symbolic function)
    (%make-symbolic ; The simplify in make-symbolic chokes on nothings
     (generic-bind (symbolic-expression symbolic) function)
     (symbolic-metadata symbolic)))
  symbolic? any?)

(defhandler generic-flatten
  (lambda (symbolic)
    (make-symbolic ; Invoke the simplify that didn't happen in generic-unpack
     (symbolic-expression symbolic)
     (symbolic-metadata symbolic)))
  symbolic?)

(defhandler generic-flatten
  (lambda (symb1)
    (generic-flatten
     (make-symbolic
      (generic-flatten (symbolic-expression (symbolic-expression symb1)))
      (unify-metadata (symbolic-metadata symb1)
		      (symbolic-metadata (symbolic-expression symb1))))))
  (lambda (thing) (and (symbolic? thing) (symbolic? (symbolic-expression thing)))))

(defhandler generic-flatten
  (lambda (thing) nothing)
  (lambda (thing) (and (symbolic? thing) (nothing? (symbolic-expression thing)))))

(defhandler generic-flatten
  (lambda (symbolic)
    (let ((the-tms (generic-flatten (symbolic-expression symbolic))))
      (let ((the-value (tms-query the-tms)))
	(if (nothing? the-value)
	    nothing
	    (generic-flatten
	     (make-tms
	      (supported
	       (generic-flatten
		(%make-symbolic
		 (generic-flatten (v&s-value the-value))
		 (symbolic-metadata symbolic)))
	       (v&s-support the-value))))))))
  (lambda (thing) (and (symbolic? thing) (tms? (symbolic-expression thing)))))

;;; The other way is the old school, adding methods to every generic
;;; operation:
#;
(define (symbolic-unpacking f)
  (lambda args
    (make-symbolic
     (apply f (map symbolic-expression args))
     (list-unify-metadata (map symbolic-metadata args)))))

#;
(define (coerce-symbolic operator)
  (case (operator-arity operator)
    ((1)
     (defhandler operator (symbolic-unpacking operator) symbolic?))
    ((2)
     (defhandler operator (symbolic-unpacking operator) symbolic? symbolic?)
     (defhandler operator (coercing ->symbolic operator) symbolic? symbolizable?)
     (defhandler operator (coercing ->symbolic operator) symbolizable? symbolic?))))
#;
(for-each coerce-symbolic
 (list generic-+ generic-- generic-* generic-/
       generic-= generic-< generic-> generic-<= generic->=
       generic-and generic-or
       generic-abs generic-square generic-sqrt generic-not))

;;; The old school method is annoying because one needs to maintain a
;;; complete list of all the generic operations one might want to
;;; augment, and it doesn't really scale to applications like teaching
;;; car to handle TMSes.  On the other hand, the new school method is
;;; annoying because it's asymmetric in the arguments (there's no good
;;; way to say "if either argument is nothing, don't bother me"), and
;;; because repacked but not yet flattened structures often seem to
;;; violate that data type's invariants.  TMSes and symbolic
;;; expressions are a case in point: they are not written to handle
;;; having a nothing for payload, but generic-unpack shoves it right
;;; in so that generic-flatten can take it back out again.  Maybe this
;;; is why Haskell chose bind as the fundamental monadic operation.

;;; The asymmetry can be largely solved by defining
;;; generic-binary-unpack (which is used inside a binary bind,
;;; followed by the same flatten).

;;; The new school method also has the problem that it isn't really
;;; very good for the comparison operators, because this data type is
;;; really only applicable to numbers, not to boolean values (unless I
;;; change it to be applicable to boolean values too...)

(define (->symbolic thing)
  (if (symbolic? thing)
      thing
      (make-symbolic
       thing
       (empty-metadata))))

(define (symbolizable? thing)
  (and (flat? thing)
       (not (boolean? thing))
       (not (symbolic? thing))))

(specify-flat symbolic?)

(defhandler merge (coercing ->symbolic symbolic-merge) symbolic? symbolizable?)
(defhandler merge (coercing ->symbolic symbolic-merge) symbolizable? symbolic?)

(define (make-variable)
  (generate-uninterned-symbol 'x))

(define (variable->symbolic variable)
  (make-symbolic
   variable
   (make-symbolic-metadata (list variable) '() '())))

(define (plunker cell #!optional variable)
  (let ((my-var (if (default-object? variable)
		    (make-variable)
		    variable)))
    ((constant (variable->symbolic my-var)) cell)))
