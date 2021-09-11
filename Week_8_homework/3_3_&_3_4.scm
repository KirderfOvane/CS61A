#| 
Exercise 3.3: Modify the make-account procedure so that it creates password-protected accounts. 
That is, make-account should take a symbol as an additional argument, as in

(define acc (make-account 100 'secret-password ))

The resulting account object should process a request only if it is accompanied 
by the password with which the account was created, 
and should otherwise return a complaint:

((acc 'secret-password 'withdraw ) 40)
60

((acc 'some-other-password 'deposit ) 50)
"Incorrect password" 
|#

(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount)) balance)
        "Insufficient funds"
    )
  )
  (define (deposit amount) (set! balance (+ balance amount)) balance )
  (define (dispatch p m)
    (if (eq? p password)
        (cond ((eq? m 'withdraw ) withdraw)
          ((eq? m 'deposit ) deposit)
          (else (error "Unknown request: 
                 MAKE-ACCOUNT" m))
        )
        (error "Incorrect password")
    )
    
  )
  dispatch
)

(define acc (make-account 100 'secret-password ))
(acc 'secret-password )
((acc 'secret-password 'withdraw ) 40)
((acc 'some-other-password 'deposit ) 50)



#| Exercise 3.4: Modify the make-account procedure of Exercise 3.3 by adding another local state 
variable so that, if an account is accessed more than seven consecutive 
times with an incorrect password, it invokes the procedure call-the-cops.  |#


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
  (define (dispatch p m)
      (if (eq? p password)
          (cond ((eq? m 'withdraw ) withdraw)
            ((eq? m 'deposit ) deposit)
            (else (error "Unknown request: 
                  MAKE-ACCOUNT" m))
          )
          (if (= countdown 0)
              (call-the-cops)
              (begin 
                (count-down 1)
                (error "Incorrect password")
              )
          )
          
      )
  )
  dispatch
)

(define acc (make-account 100 'secret-password ))
((acc 'secret-password 'withdraw ) 40)
((acc 'some-other-password 'deposit ) 50)
((acc 'some-other-password 'deposit ) 50)
((acc 'some-other-password 'deposit ) 50)
((acc 'some-other-password 'deposit ) 50)
((acc 'some-other-password 'deposit ) 50)
((acc 'some-other-password 'deposit ) 50)
((acc 'some-other-password 'deposit ) 50)
((acc 'some-other-password 'deposit ) 50)