
(define *propserver* (create-rpc-server))


; alist of name . cell
 
(define *propserver-public-cells*
  '())

(define (propserver-publish-cell! name cell)
  (let ((v (assoc name *propserver-public-cells*)))
    (if v
        (set-cdr! v cell)
        (set! *propserver-public-cells*
              (cons (cons name cell)
                    *propserver-public-cells*)))
    'ok))

(define (propserver-get-cell cell-name)
  (let ((v (assoc cell-name *propserver-public-cells*)))
    (if v
        (cdr v) ;; todo lock wrapper entity here?
        (error "unpublished cell" cell-name))))

(define (run-interlocked)
  (with-lock *propserver-global-lock*
             run))

(define *propserver-global-lock* (make-lock))
; TODO: console operations must be protected by lock!
; TODO: cell entity operations must be protected by lock!!

(define propagators-port 5390)
(define propagators-salt "MgF2")
(define propagators-salted-key "�3�+c$\226\206�y\022�\036\\\005") ; yes this is ridiculous :P

; id symbol, salt, password hash, procedure

(define *propserver-service-table*
  `(
    (get-cell      ,propagators-salt ,propagators-salted-key
                   ,(lambda (cell-name)
                      (propserver-get-cell cell-name)))
    (cell-invoke   ,propagators-salt ,propagators-salted-key
                   ,(lambda (cell dispatchargs)
                      (let ((result
                             (apply (entity-extra cell) dispatchargs)))
                        (if (and (procedure? result) (not (cell? result))) ; kludge
                            (lambda args ; return an interlocked procedure
                              (with-lock *propserver-global-lock* 
                                         (lambda ()
                                           (if (equal? dispatchargs '(new-neighbor!))
                                               (for-each mark-remote-proc-async! args))
                                           (apply result args))))
                            result))))
    (run           ,propagators-salt ,propagators-salted-key
                   ,run-interlocked)
    ))


(define (propserver-accessor requested-thing-id password)
  (let ((thing-record (assoc requested-thing-id *propserver-service-table*)))
    (if (not thing-record)
        (error 'unknown-service-id requested-thing-id)
        (let* ((salt (cadr thing-record))
               (salted-pw (string-append propagators-salt password))
               (salted-hash (md5-string salted-pw)))
          (if (string=? salted-hash (caddr thing-record))
              (cadddr thing-record)
              (begin
                (sleep-current-thread 1000)
                (error 'unauthorized)))))))

(register-rpc-procedure *propserver* "access-thing" propserver-accessor)


(define (propserver-start #!optional port address)
  (let ((port (if (default-object? port) propagators-port port))
        (address (if (default-object? address) (host-address-any) address)))
    (write-line "About to start rpc server")
    (start-rpc-server *propserver* port address)
    (write-line "Started rpc server")))

(define (propserver-stop)
  (stop-rpc-server *propserver*))

(define (propserver-connect-to password host #!optional port)
  (let ((client (create-rpc-client))
        (port (if (default-object? port) propagators-port port)))
    (server-connect-outbound *propserver* client port host)
    (list 'propclient client password)))



(attach-special-object-id nothing "csail.mit.edu/ProjectMAC/Propagators/Nothing")
(register-portable-record-type
 (record-type-descriptor (make-interval 1 2)) 
 "csail.mit.edu/ProjectMAC/Propagators/Interval")


#|
;;;;  Demo

(propserver-start)
"About to start rpc server"
"Started rpc server"
;Unspecified return value

(define testcell (make-cell))
;Value: testcell

(propserver-publish-cell! 'testcell testcell)
;Value: ok

(define testcell3 (make-cell))
;Value: testcell3

(propserver-publish-cell! 'testcell3 testcell3)
;Value: ok


...


|#