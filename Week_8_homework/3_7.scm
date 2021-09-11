#| 
Exercise 3.7: Consider the bank account objects created by make-account, 
with the password modification described in Exercise 3.3. 
Suppose that our banking system requires the ability to make joint accounts. 
Define a procedure make-joint that accomplishes this. 
Make-joint should take three arguments. 
The first is a password-protected account. 
The second argument must match the password with which the account was defined in order 
for the make-joint operation to proceed. The third argument is a new password. 
Make-joint is to create an additional access to the original account using the new password. 
For example, if peter-acc is a bank account with password open-sesame, 
then

(define paul-acc
  (make-joint peter-acc 
              'open-sesame 
              'rosebud))

will allow one to make transactions on peter-acc using the name paul-acc 
and the password rosebud. 
You may wish to modify your solution to Exercise 3.3 to accommodate this new feature.  |#


(define (make-account balance password)
  (define countdown 7)
  (define (count-down x)
    (set! countdown (- countdown x))
  )
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount)) balance)
        "Insufficient funds"
    )
  )
  (define (deposit amount) (set! balance (+ balance amount)) balance )
  (define (call-the-cops) (error "Calling the cops!"))
  (define (create-joint additional-password)
    (if (list? password)
        (error "This account is already a joint account")
        (set! password (list password additional-password))
    )
  )
  (define (dispatch p m)
    (begin 
        ;authorization
        (cond 
            ((list? password) (if (member? p password)
                                    'authorized
                                    (if (= countdown 0)
                                        (call-the-cops)
                                        (begin 
                                            (count-down 1)
                                            (error "Incorrect password")
                                        )
                                    )
            ))
            ((if (eq? p password)
                    'authorized
                    (if (= countdown 0)
                        (call-the-cops)
                        (begin 
                            (count-down 1)
                            (error "Incorrect password")
                        )
                    )
            ))
        )
        ; message dispatch after authorized
        (cond 
            ((eq? m 'withdraw ) withdraw)
            ((eq? m 'deposit ) deposit)
            ((eq? m 'make-joint ) create-joint )
            (else (error "Unknown request: 
                    MAKE-ACCOUNT" m))
        )
    )
  )
  dispatch
)

(define (make-joint existing-account-name existing-account-password your-access-password)
    (begin ((existing-account-name existing-account-password 'make-joint ) your-access-password)
            existing-account-name
    )
)

(define peter-acc (make-account 100 'open-sesame ))
((peter-acc 'open-sesame 'withdraw ) 40)

(define paul-acc
  (make-joint peter-acc 
              'open-sesame 
              'rosebud )
)

((paul-acc 'rosebud 'withdraw ) 20)
((paul-acc 'rosebud 'deposit ) 1000)
((peter-acc 'open-sesame 'withdraw ) 500)
((peter-acc 'open-sesame 'deposit ) 525)
((paul-acc 'rosebud 'withdraw ) 1064)