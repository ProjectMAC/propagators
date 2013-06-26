(define-record-type agent
  (agent:make-record worldview scheduler)
  agent?
  (worldview agent:worldview)
  (scheduler agent:scheduler))

(define *premise-outness*)

(define (agent:make #!optional name parent-worldview)
  (let ((new-worldview
         (if (default-object? parent-worldview)
             (clone-worldview *premise-outness*)
             (clone-worldview parent-worldview)))
        (name
         (if (default-object? name)
             (begin (set! *agent-number* (+ *agent-number* 1))
                    (symbol 'agent *agent-number*))
             name)))
    (let ((agent (agent:make-record new-worldview
                                    (make-scheduler))))
      (name! agent name)
      (for-each ((agent:scheduler agent) 'alert-one)
                (all-propagators))
      agent)))

(define *agent-number* 0)

(define (agent:make-initial)
  (let ((name
         (begin (set! *agent-number* 0)
                (symbol 'agent *agent-number*))))
    (let ((agent
           (agent:make-record (make-worldview)
                              (make-scheduler))))
      (name! agent name)
      agent)))

(define (install-agent! agent)
  (set! *scheduler* (agent:scheduler agent))
  (set! *premise-outness* (agent:worldview agent))
  (set! *current-agent* agent)
  ;; *abort-process*, *last-value-of-run* ?
  agent)


(define (current-agent)
  *current-agent*)


(define *premise-number* 0)

(define (agent:make-premise #!optional agent)
  (if (default-object? agent)
      (set! agent *current-agent*))
  (set! *premise-number* (+ *premise-number* 1))
  (symbol (name agent) "-premise-" *premise-number*))



(define (make-worldview)
  (make-eq-hash-table))

(define (clone-worldview premise-outness-table)
  (let ((new (make-eq-hash-table)))
    (hash-table/for-each premise-outness-table
                         (lambda (key datum)
                           (hash-table/put! new key datum)))
    new))