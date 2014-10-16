;;;; RAA 
;;; Idea is to dismiss a hypothetical by denying the contrary...

;;; Want to stop worldview associated with contrary-premise
;;; if contrary premise finds a contradiction.  Then want to 
;;; reinstate the contrary belief in a new worldview if a 
;;; reason for the contradiction is lost.

(define (to-dismiss-hypothetical hypothetical-premise)
  (let ((agent (current-agent)) ; worldview and schedule
        (hcell (hypothetical-cell hypothetical-premise))
	(sign
	 (case (hypothetical-sign hypothetical-premise)	;stupid!
	   ((true) #t)
	   ((false) #f)
	   (else (error "Bad hypothetical sign"))))
	(state (premise-in? hypothetical-premise)) ; unused? bad!
	(contrary-premise
         (or (eq-get hypothetical-premise 'contrary-premise)
             (let ((cp (generate-uninterned-symbol 'contrary)))
               (eq-put! cp 'hypothetical-premise hypothetical-premise)
               (eq-put! hypothetical-premise 'contrary-premise cp)
               cp))))
    ;; Kick out the hypothetical and add the contrary premise to the
    ;; reasons why it should be out.
    (set-premise-nogoods! hypothetical-premise
     (lset-adjoin eq?
		  (premise-nogoods hypothetical-premise)
		  (list contrary-premise)))
    (kick-out! hypothetical-premise)

    ;; Assert the contrary premise, and use it to support the opposite
    ;; of the hypothetical being tested.
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
		   (add-content hcell
				(make-tms (contingent sign reasons)))
		   ;; deactivate unless a reason is retracted.
		   )))
	   'nothing-to-do)))

    (on-quiescence agent
     (lambda ()
       (if (premise-in? contrary-premise) ;could not find contradiction
           (kick-out! contrary-premise))  ;restore original situation
       ))
     )))