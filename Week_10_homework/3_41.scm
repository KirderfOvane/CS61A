#| Exercise 3.41: Ben Bitdiddle worries that it would be better to implement the bank account as follows
(where the commented line has been changed):

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin 
          (set! balance 
                (- balance amount))
          balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((protected (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) 
             (protected withdraw))
            ((eq? m 'deposit) 
             (protected deposit))
            ((eq? m 'balance)
             ((protected 
                (lambda () 
                  balance)))) ; serialized
            (else 
             (error 
              "Unknown request: 
               MAKE-ACCOUNT"
              m))))
    dispatch))

because allowing unserialized access to the bank balance can result in anomalous behavior. 
Do you agree? Is there any scenario that demonstrates Ben’s concern?  |#

; We should be able to access balance without serializing if we just wan't to read balances value. 
; We can't read the value if someone is about to write a new value with Bens implementation.
; Maybe it's better to see the new value than the old value that is about to be changed.

; But only thinking working code, it's writing to account that should be protected/serialized as it changes values.