;Problem 5 (Object-Oriented Programming)

(define-class (scoop flavor)
    ; maybe (parent (cone)) -- see part (A) below
)

(define-class (vanilla)
    (parent (scoop 'vanilla ))
)
(define-class (chocolate)
    (parent (scoop 'chocolate ) )
)
(define-class (cone)
    ; maybe (parent (scoop)) -- see part (A) below
    (instance-vars (scoops '()))
    (method (add-scoop new)
        (set! scoops (cons new scoops))
    )
    (method (flavors)
        (map see (B) below scoops)
    )
)

#| 
(A) Which of the parent clauses shown above should be used?
The scoop class should have (parent (cone)). ; <-- this should be used.
The cone class should have (parent (scoop)).
Both.
Neither.
(B) What is the missing expression in the flavors method?  ; (map print scoops)
(C) Which of the following is the correct way to add a scoop of vanilla ice cream to a cone
named my-cone? 
(ask my-cone ’add-scoop ’vanilla) ;<-- correct way
(ask my-cone ’add-scoop vanilla)
(ask my-cone ’add-scoop (instantiate ’vanilla))
(ask my-cone ’add-scoop (instantiate vanilla)) |#