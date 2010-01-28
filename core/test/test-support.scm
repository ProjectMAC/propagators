(define (->significant-figures places number)
  (define (round-down? digit-trail)
    (or (null? digit-trail)
	(memq (car digit-trail) '(#\0 #\1 #\2 #\3 #\4))
	(and (eq? (car digit-trail) #\.)
	     (or (null? (cdr digit-trail))
		 (memq (cadr digit-trail) '(#\0 #\1 #\2 #\3 #\4))))))
  (define (decimal-increment reversed-digit-list)
    (cond ((null? reversed-digit-list)
	   '(#\1))
	  ((eq? (car reversed-digit-list) #\.)
	   (cons (car reversed-digit-list)
		 (decimal-increment (cdr reversed-digit-list))))
	  ((eq? (car reversed-digit-list) #\9)
	   (cons #\0 (decimal-increment (cdr reversed-digit-list))))
	  (else 
	   (cons (integer->char (+ 1 (char->integer (car reversed-digit-list))))
		 (cdr reversed-digit-list)))))
  (let ((digits (string->list (number->string number))))
    (let loop ((result '())
	       (more-digits digits)
	       (places places)
	       (zeros-matter? #f))
      (cond ((null? more-digits)
	     (string->number (list->string (reverse result))))
	    ;; TODO This relies on being after the decimal point
	    ((= places 0)
	     (string->number
	      (list->string
	       (reverse
		(if (round-down? more-digits)
		    result
		    (decimal-increment result))))))
	    ((eq? #\. (car more-digits))
	     (loop (cons (car more-digits) result)
		   (cdr more-digits)
		   places
		   zeros-matter?))
	    ((eq? #\0 (car more-digits))
	     (loop (cons (car more-digits) result)
		   (cdr more-digits)
		   (if zeros-matter? (- places 1) places)
		   zeros-matter?))
	    (else
	     (loop (cons (car more-digits) result)
		   (cdr more-digits)
		   (- places 1)
		   #t))))))

(define-method generic-match ((pattern <vector>) (object <vector>))
  (reduce boolean/and #t (map generic-match
			      (vector->list pattern)
			      (vector->list object))))

(define-method generic-match ((pattern <pair>) (object <pair>))
  (and (generic-match (car pattern) (car object))
       (generic-match (cdr pattern) (cdr object))))

(define-method generic-match ((pattern <inexact>) (object <inexact>))
  (or (= pattern object)
      (= pattern (->significant-figures 5 object))))
