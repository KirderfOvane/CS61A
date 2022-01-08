Problem 13 (Nondeterministic evaluator).
Here is a program written for the non-deterministic evaluator:
(define b 1)
(define (clue)
    (let ((a (amb 1 2 3 4 5)))
     (require (= 0 (remainder a 2)))
     (set! b (+ b a))
    b)
)
Fill in the results from the non-determinisitic evaluator:
Amb-Eval input: (clue)
Amb-Eval value: 3
Amb-Eval input: try-again
Amb-Eval value: 5