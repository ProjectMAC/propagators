;;; Client:

(define propagators-port 5390)

(define (client-connect password #!optional host port)
  (let ((client (create-rpc-client))
	(port (if (default-object? port) propagators-port port))
	(address (if (default-object? host) "localhost" host)))
    (connect-rpc-client client port address)
    (list 'propclient client password)))

(define (client-disconnect client)
  (disconnect-rpc-client (cadr client)))

(define (client-access-service client service-id #!optional password)
  ((bind-rpc-call (cadr client) "access-thing")
   service-id 
   (if (default-object? password) (caddr client)
       password)))

(define (get-remote-cell client cell-name)
  (let ((remote-entity
         ((client-access-service client 'get-cell)
          cell-name))
        (remote-invoker
         (client-access-service client 'cell-invoke)))
    (let ((proxycell
           (make-entity
            (lambda args
              (error "don't apply a remote cell!"))
            (lambda args
              (remote-invoker remote-entity args)))))
      (eq-put! proxycell 'cell #t)
      (register-diagram proxycell) ; Don't know if this is appropriate or not!
      proxycell)))
   

; FIXME: neighbors, who, etc don't behave reasonably as they do not proxy
; cells as above. also cells contaning cells aren't handled either.
        

(attach-special-object-id nothing "csail.mit.edu/ProjectMAC/Propagators/Nothing")
(register-portable-record-type
 (record-type-descriptor (make-interval 1 2)) 
 "csail.mit.edu/ProjectMAC/Propagators/Interval")


#|
;;;;  Demo
;;; Assume that the password is "<password>".

(define client (client-connect "<password>" "127.0.0.1" propagators-port))
;Value: client

(define testcell
  (get-remote-cell client 'testcell))
;Value: testcell

(content testcell)
;Value: #(*the-nothing*)

(nothing? (content testcell))
;Value: #t

(add-content testcell 123)
;Unspecified return value

(content testcell)
;Value: 123


(define testcell3 (get-remote-cell client 'testcell3))
;Value: testcell3

(content testcell3)
;Value: #(*the-nothing*)

(add-content testcell3 (make-interval 1 10))
;Unspecified return value

(content testcell3)
;Value: #[interval 1 10]

(add-content testcell3 (make-interval 2 20))
;Unspecified return value

(content testcell3)
;Value: #[interval 2 10]

...



(client-disconnect client)
|#