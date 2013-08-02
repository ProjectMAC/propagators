(define-record-type agent
  (agent:make-record worldview scheduler)
  agent?
  (worldview agent:worldview)
  (scheduler agent:scheduler))

(define (agent:make #!optional name parent)
  (let ((name
         (if (default-object? name)
             (begin (set! *agent-number* (+ *agent-number* 1))
                    (symbol 'agent *agent-number*))
             name))
        (new-worldview
         (if (default-object? parent)
             (worldview:make *current-agent*)
             (worldview:make parent))))
    (let ((agent
           (agent:make-record new-worldview (make-scheduler))))
      (name! agent name)
      ;;(eq-put! new-worldview 'agent agent)
      (for-each ((agent:scheduler agent) 'alert-one)
                (all-propagators))
      agent)))

(define *agent-number*)

(define (agent:make-initial)
  (set! *agent-number* 0)
  (agent:make 'top-level-agent #f))

(define premise-in?)
(define mark-premise-in!)
(define mark-premise-out!)

(define (install-agent! agent)
  (set! *scheduler* (agent:scheduler agent))
  (set! *current-agent* agent)
  (set! premise-in? ((agent:worldview agent) 'premise-in?))
  (set! mark-premise-in! ((agent:worldview agent) 'mark-premise-in!))
  (set! mark-premise-out! ((agent:worldview agent) 'mark-premise-out!))
  ;; *abort-process*, *last-value-of-run* ?

  ;; Probably should go away with good tracking of new stuff.b

  (for-each ((agent:scheduler agent) 'alert-one)
            (all-propagators))
  agent)


(define (current-agent)
  *current-agent*)

(define *premise-number* 0)

(define (agent:make-premise #!optional description agent)
  (if (default-object? agent)
      (set! agent *current-agent*))
  (if (default-object? description)
      (set! description ""))
  (set! *premise-number* (+ *premise-number* 1))
  (let ((premise (symbol description "-by-" (name agent) "-premise-" *premise-number*)))
    ;;this probably breaks garbage collection (make weak ref?)
    (eq-put! premise 'agent agent) ; FIXME 

    ;; default is IN within agent's scope.
    (((agent:worldview agent) 'mark-premise-in!) premise)
    premise))

(define (premise:creator-agent premise)
  (eq-get premise 'agent))
  

(define (worldview:make parent-agent)
  (let ((pi? (if parent-agent
                 ((agent:worldview parent-agent) 'premise-in?)
                 (lambda (premise)      ;top-level: unknown 
                   (if (premise:creator-agent premise)
                       #f ; private premises assumed out outside of scope.
                       #t)))) ; top-level premises assumed in.
        
        (premise-status (make-eq-hash-table)))
    
    (define (premise-in? premise)
      (let ((status
             (hash-table/get premise-status premise 'unknown)))
        (cond ((eq? status 'unknown) (pi? premise)) ;ask parent
              (else status))))
        
    (define (mark-premise-in! premise)
      (hash-table/put! premise-status premise #t))

    (define (mark-premise-out! premise)
      (hash-table/put! premise-status premise #f))

    (define (me message)
      (case message
        ((premise-in?) premise-in?)
        ((mark-premise-in!) mark-premise-in!)
        ((mark-premise-out!) mark-premise-out!)
        (else
         (error "unknown message -- WORLDVIEW"
                message))))
    me))
