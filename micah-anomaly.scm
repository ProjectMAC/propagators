#|
(initialize-scheduler)
(set! *avoid-false-true-flips* #f) ; turn off hysteresis so amb has real defaulting

(define-cell in1)
(define-cell in2)
(define-cell aux1)
(define-cell aux2)
(define-cell out)

(p:id in1 aux1)
(p:id in1 out)
(p:amb in1)

(p:id in2 aux2)
(p:id in2 out)
(p:amb in2)

(inquire out) ; --> #t
;Value: ((out) has #(value=#t,
;   premises=((hypothetical 23 true in #[entity 24] in1)),
;   informants=((amb-choose))))

(tell! aux1 #f 'temp1) ; force ambs to false via in1

(inquire out) ; --> #f
;Value: ((out) has #(value=#f,
;   premises=((hypothetical 25 false in #[entity 24] in1)),
;   informants=((amb-choose))))

(kick-out! 'temp1)

(tell! aux2 #f 'temp2) ; force ambs to false via in2

(inquire out) ; --> #f
;Value: ((out) has #(value=#f,
;   premises=((hypothetical 25 false in #[entity 24] in1)),
;   informants=((amb-choose))))

(kick-out! 'temp2)

(inquire out) ; --> #f ?! What happened to default-true??
;Value: ((out) has #(value=#f,
;   premises=((hypothetical 25 false in #[entity 24] in1)),
;   informants=((amb-choose))))



(pp (content aux1))
#(tms
  (#(value=#(*the-contradiction*),
     premises=(temp1 (hypothetical 23 true out #[entity 24] in1)),
     informants=((amb-choose) user))
   #(value=#f,
     premises=(temp1),
     informants=(user))
   #(value=#t,
     premises=((hypothetical 23 true out #[entity 24] in1)),
     informants=((amb-choose)))
   #(value=#f,
     premises=((hypothetical 25 false in #[entity 24] in1)),
     informants=((amb-choose)))))


(pp (content aux2))
#(tms
  (#(value=#(*the-contradiction*),
     premises=(temp2 (hypothetical 28 true out #[entity 27] in2)),
     informants=((amb-choose) user))
   #(value=#f,
     premises=(temp2),
     informants=(user))
   #(value=#t,
     premises=((hypothetical 28 true out #[entity 27] in2)),
     informants=((amb-choose)))
   #(value=#f,
     premises=((hypothetical 26 false in #[entity 27] in2)),
     informants=((amb-choose)))))


(pp (content out))
#(tms
  (#(value=#(*the-contradiction*),
     premises=((hypothetical 23 true out #[entity 24] in1) (hypothetical 26 false in #[entity 27] in2)),
     informants=((amb-choose) (amb-choose)))
   #(value=#(*the-contradiction*),
     premises=((hypothetical 25 false in #[entity 24] in1) (hypothetical 28 true out #[entity 27] in2)),
     informants=((amb-choose) (amb-choose)))
   #(value=#f,
     premises=((hypothetical 25 false in #[entity 24] in1)),
     informants=((amb-choose)))
   #(value=#t,
     premises=((hypothetical 23 true out #[entity 24] in1)),
     informants=((amb-choose)))
   #(value=#t,
     premises=((hypothetical 28 true out #[entity 27] in2)),
     informants=((amb-choose)))
   #(value=#f,
     premises=((hypothetical 26 false in #[entity 27] in2)),
     informants=((amb-choose)))))
|#

;;; To find out what non-hypothetical premises support a hypothetical

(define (ultimate-support hyp)
  (let ((visited '()))
    (define (walk-one hyp)
      (if (not (memq hyp visited))
	  (begin (set! visited (cons hyp visited))
		 (append-map (lambda (premise-nogood)
			       (sort (if (any hypothetical? premise-nogood)
					 (let* ((s (divide-list hypothetical?
								premise-nogood))
						(hyps (car s)) (roots (cadr s)))
					   (append-map (lambda (sub)
							 (lset-union eq? roots sub))
						       (map walk-one hyps)))
					 (list premise-nogood))
				     premise<?))
			     (hypothetical-support hyp)))		 
	  '()))
    (delete-duplicates (walk-one hyp))))

(define (hypothetical-support hyp)
  (filter all-premises-in?
	  (premise-nogoods (eq-get hyp 'opposite))))

(define (divide-list p? lst)
  (let lp ((l lst) (true '()) (false '()))
    (cond ((null? l)
	   (list true false))
	  ((p? (car l))
	   (lp (cdr l) (cons (car l) true) false))
	  (else
	   (lp (cdr l) true (cons (car l) false))))))
