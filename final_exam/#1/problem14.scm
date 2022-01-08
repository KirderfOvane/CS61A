Problem 14 (Nondeterministic evaluator).
Here is a program written for the non-deterministic evaluator:
(define (mystery)
    (let (
            (a (an-integer-starting-at 1))
            (b (an-integer-starting-at 1))
         )
         (require (= b (* a a)))
         (list a ’squared ’= b))
)
(define (an-integer-starting-at n)
    (amb n (an-integer-starting-at (+ n 1)))
)
Fill in the results from the non-deterministic evaluator:
Amb-Eval input: (mystery)
Amb-Eval value: (1 squared = 1)
Amb-Eval input: try-again
Amb-Eval value: no more values, evaluator hangs in infinite loop