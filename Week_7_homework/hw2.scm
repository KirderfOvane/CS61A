#| 2. Define the class coke-machine. The instantiation arguments for a coke-machine are
the number of Cokes that can fit in the machine and the price (in cents) of a Coke:
(define my-machine (instantiate coke-machine 80 70))
creates a machine that can hold 80 Cokes and will sell them for 70 cents each. The machine
is initially empty. Coke-machine objects must accept the following messages:

(ask my-machine ’deposit 25) means deposit 25 cents. You can deposit several coins
and the machine should remember the total.
(ask my-machine ’coke) means push the button for a Coke. This either gives a Not
enough money or Machine empty error message or returns the amount of change you get.
(ask my-machine ’fill 60) means add 60 Cokes to the machine.
Here’s an example:
(ask my-machine ’fill 60)
(ask my-machine ’deposit 25)
(ask my-machine ’coke)
NOT ENOUGH MONEY
(ask my-machine ’deposit 25) ;; Now there’s 50 cents in there.
(ask my-machine ’deposit 25) ;; Now there’s 75 cents.
(ask my-machine ’coke)
5 ;; return val is 5 cents change.
You may assume that the machine has an infinite supply of change. |#

(define-class (coke-machine num-cokes price)
    (instance-vars (balance 0))
    (method (deposit number)
        (begin (set! balance (+ balance number)) balance) 
    )
    (method (coke)
        (if (> num-cokes 0)
            (if (> balance price)
                (begin (set! balance (- balance price)) (set! num-cokes (- num-cokes 1)) balance)
                (error "Not enough money deposited, missing: " (abs (- balance price)))
            )
            (error "Machine is empty")
        )
    )
    (method (fill number)
        (begin (set! num-cokes (+ num-cokes number)) num-cokes)
    )
)


;testing
(define my-machine (instantiate coke-machine 5 70))
(ask my-machine 'deposit 25)
(ask my-machine 'coke ) ;> not enough money, missing: 
(ask my-machine 'deposit 50)
(ask my-machine 'coke ) ;> 5 change
(ask my-machine 'coke ) ; not enoug money..
(ask my-machine 'deposit 5000)
(ask my-machine 'coke ) 
(ask my-machine 'coke ) 
(ask my-machine 'coke ) 
(ask my-machine 'coke ) 
(ask my-machine 'coke ) ; machine is empty
(ask my-machine 'fill 60)
(ask my-machine 'coke ) 