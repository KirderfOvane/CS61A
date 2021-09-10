#| 1. Given below is a simplified version of the make-account procedure on page 223 of Abelson and Sussman.
(define (make-account balance)
(define (withdraw amount)
(set! balance (- balance amount)) balance)
(define (deposit amount)
(set! balance (+ balance amount)) balance)
(define (dispatch msg)
(cond
((eq? msg ’withdraw) withdraw)
((eq? msg ’deposit) deposit) ) )
dispatch)
Fill in the blank in the following code so that the result works exactly the same as the make-account
procedure above, that is, responds to the same messages and produces the same return values. The differences
between the two procedures are that the inside of make-account above is enclosed in the let below, and
the names of the parameter to make-account are different.
(define (make-account init-amount)
(let ( )
(define (withdraw amount)
(set! balance (- balance amount)) balance)
(define (deposit amount)
(set! balance (+ balance amount)) balance)
(define (dispatch msg)
(cond
((eq? msg ’withdraw) withdraw)
((eq? msg ’deposit) deposit) ) )
dispatch) ) |#

(define (make-account init-amount)
    (let ((balance init-amount) )
        (define (withdraw amount)
            (set! balance (- balance amount)) balance)
        (define (deposit amount)
            (set! balance (+ balance amount)) balance)
        (define (dispatch msg)
            (cond
                ((eq? msg 'withdraw) withdraw)
                ((eq? msg 'deposit) deposit) 
            ) 
        )
        dispatch
    ) 
)

(define acc (make-account 100))
(ask acc 'withdraw 50)



#| 2. Modify either version of make-account so that, given the message balance, it returns the current
account balance, and given the message init-balance, it returns the amount with which the account
was initially created. For example: |#

#| > (define acc (make-account 100))
acc
> (acc ’balance)
100 |#

(define (make-account init-amount)
    (let ((balance init-amount) )
        (define (withdraw amount)
            (set! balance (- balance amount)) balance)
        (define (deposit amount)
            (set! balance (+ balance amount)) balance)
        (define (dispatch msg)
            (cond
                ((eq? msg 'withdraw ) withdraw)
                ((eq? msg 'deposit ) deposit) 
                ((eq? msg 'balance ) balance) 
            ) 
        )
        dispatch
    ) 
)

(define acc2 (make-account 100))
(acc2 'balance )


#| 3. Modify make-account so that, given the message transactions, it returns a list of all transactions
made since the account was opened. For example:
> (define acc (make-account 100))
acc
> ((acc ’withdraw) 50)
50
> ((acc ’deposit) 10)
60
> (acc ’transactions)
((withdraw 50) (deposit 10)) |#

(define (make-account init-amount)
    (let ((balance init-amount) (transactions (list)))
        (define (withdraw amount)
            (begin 
                (set! transactions (cons (list 'withdraw amount) transactions ))
                (set! balance (- balance amount)) balance)
            )
        (define (deposit amount)
            (begin 
                (set! transactions (cons (list 'deposit amount) transactions))
                (set! balance (+ balance amount)) balance)
            )
            
        (define (dispatch msg)
            (cond
                ((eq? msg 'withdraw ) withdraw)
                ((eq? msg 'deposit ) deposit) 
                ((eq? msg 'balance ) balance) 
                ((eq? msg 'transactions ) transactions) 
            ) 
        )
        dispatch
    ) 
)

(define acc3 (make-account 100))
(ask acc3 'withdraw 50)
(acc3 'transactions )
(ask acc3 'deposit 250)
(acc3 'transactions )