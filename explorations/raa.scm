;;;; RAA 
;;; Idea is to dismiss a hypothetical by denying the contrary...
;;; Problem is that global worldview prevents also using the 
;;; hypothetical if the contradiction is not forthcoming.

;;; Really want worldview associated with processes.  
;;; Split worldviews, *premise-outness* table should be allocated for
;;; each process, as a clone of the parent.

;;; So want to split the worldview rather than BRING-IN and KICK-OUT
;;; stuff.  Also want to avoid RUN.

;;; Want to stop worldview associated with contrary-premise
;;; if contrary premise finds a contradiction.  Then want to 
;;; reinstate the contrary belief in a new worldview if a 
;;; reason for the contradiction is lost.

(define (to-dismiss-hypothetical hypothetical-premise)
  (let ((hcell (hypothetical-cell hypothetical-premise))
	(sign
	 (case (hypothetical-sign hypothetical-premise)	;stupid!
	   ((true) #t)
	   ((false) #f)
	   (else (error "Bad hypothetical sign"))))
	(state (premise-in? hypothetical-premise))
	(contrary-premise (generate-uninterned-symbol 'contrary)))
    (eq-put! contrary-premise 'hypothetical-premise hypothetical-premise)
    (eq-put! hypothetical-premise 'contrary-premise contrary-premise)
    ;; Interlock for reader-writer
    (set-premise-nogoods! hypothetical-premise
     (lset-adjoin eq?
		  (premise-nogoods hypothetical-premise)
		  (list contrary-premise)))
    (kick-out! hypothetical-premise)
    ;; Interlock for reader-writer
    (add-content hcell
		 (make-tms
		  (contingent (not sign)
			      (list contrary-premise))))
    (bring-in! contrary-premise)
    
    ;; Attach: look at process-nogood! in search
    (tell-contradiction-handler		
     (lambda (a-nogood)
       (if (member contrary-premise a-nogood)
	   (let ((reasons (delete contrary-premise a-nogood)))
	     (if (or (not (null (filter hypothetical? reasons)))
		     (not (null (filter (lambda (x)
					  (eq-get x 'hypothetical-premise))
					reasons))))
		 'too-complicated
		 (begin
		   (kick-out! contrary-premise)
		   ;; Interlock for reader-writer
		   (add-content hcell
				(make-tms (contingent sign reasons)))
		   ;; deactivate unless a reason is retracted.
		   )))
	   'nothing-to-do)))
    (run)))