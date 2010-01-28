(define (name thing)
  (let ((name-property (eq-get thing 'name)))
    (if name-property
	(name name-property)
	thing)))

(eq-put! generic-+ 'name '+)
(eq-put! generic-- 'name '-)
(eq-put! generic-* 'name '*)
(eq-put! generic-/ 'name '/)

(eq-put! generic-abs    'name 'abs)
(eq-put! generic-square 'name 'square)
(eq-put! generic-sqrt   'name 'sqrt)
(eq-put! generic-=      'name '=)
(eq-put! generic-<      'name '<)
(eq-put! generic->      'name '>)
(eq-put! generic-<=     'name '<=)
(eq-put! generic->=     'name '>=)

(eq-put! generic-not 'name 'not)
(eq-put! generic-and 'name 'and)
(eq-put! generic-or  'name 'or)

(eq-put! switch-function 'name 'switch)

(define (neighbors element)
  (if (cell? element)
      (element 'neighbors)
      (let ((neighbors-property (eq-get element 'neighbors)))
	(if neighbors-property
	    neighbors-property
	    ;; Fail over
	    '()))))

