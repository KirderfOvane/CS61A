#| Exercise 3.48: Explain in detail why the deadlock-avoidance method described above, 
(i.e., the accounts are numbered, and each process attempts to acquire the smaller-numbered account first) 
avoids deadlock in the exchange problem. Rewrite serialized-exchange to incorporate this idea.
(You will also need to modify make-account so that each account is created with a number, 
which can be accessed by sending an appropriate message.)  |#

(define make-count
    (let ((glob 0))
        (lambda ()
           
                (lambda ()
                   
                    (set! glob (+ glob 1))
                    glob
                )
            
        )
    )
)


(define (make-account-and-serializer balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance 
                     (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let (
            (balance-serializer (make-serializer))
            (account-number ((make-count)))
       )
    (define (dispatch m)
      (cond ((eq? m 'withdraw ) 
             (balance-serializer withdraw))
            ((eq? m 'deposit ) 
             (balance-serializer deposit))
            ((eq? m 'balance ) 
             balance)
            ((eq? m 'serializer ) 
             balance-serializer)
            ((eq? m 'account-number ) 
              account-number)
            (else (error "Unknown request: 
                          MAKE-ACCOUNT"
                         m))))
    dispatch)
)



(define (deposit account amount)
  ((account 'deposit ) amount)
)


(define (make-serializer)
  (let ((mutex (make-mutex)))
    (lambda (p)
      (define (serialized-p . args)
        (mutex 'acquire )
        (let ((val (apply p args)))
          (mutex 'release )
          val))
      serialized-p)))


(define (make-mutex)
  (let ((cell (list false)))
    (define (the-mutex m)
      (cond ((eq? m 'acquire )
             (if (test-and-set! cell)
                 (the-mutex 'acquire ))) ; retry
            ((eq? m 'release ) (clear! cell))))
    the-mutex))
(define (clear! cell) (set-car! cell false))


(define (exchange account1 account2)
  (let ((difference (- (account1 'balance)
                       (account2 'balance))))
    ((account1 'withdraw) difference)
    ((account2 'deposit) difference)))


(define (serialized-exchange account1 account2)
  (let 
        (
            (serializer1 (account1 'serializer ))
            (serializer2 (account2 'serializer ))
        )
    
    
        
        (if (< (account1 'account-number ) (account2 'account-number ))
            (begin 
                (serializer1 (serializer2 exchange))
                account1
                account2
            )
            (begin 
                (serializer2 (serializer1 exchange))
                account2
                account1
            )
        )
        
    
  )
)


;testing
(define myacc (make-account-and-serializer 50))
(define secondaccount (make-account-and-serializer 50))

(myacc 'account-number ) ;> 1
(secondaccount 'account-number ) ;> 2

(serialized-exchange myacc secondaccount)