#| 2. In this exercise we learn what a continuation is. 
Suppose we have the following definition: |#

(define (square x cont)
    (cont (* x x)))

#| Here x is the number we want to square, 
and cont is the procedure to which we want to pass the result.
Now try these experiments: |#

> (square 5 (lambda (x) x)) ; (* 5 5) then return x

> (square 5 (lambda (x) (+ x 2))) ; (* 5 5) then add 2 to x

> (square 5 (lambda (x) (square x (lambda (x) x)))) ; (* 5 5) then square the result

> (square 5 display) ; (* 5 5) then display it

> (define foo 3) 

> (square 5 (lambda (x) (set! foo x))) ; (* 5 5) then set foo to result->25

> foo ;> 25

#| Don’t just type them in – make sure you understand why they work! 
The nondeterministic evaluator works
by evalutating every expression with two continuations, 
one used if the computation succeeds, and one used
if it fails. |#

(define (reciprocal x yes no)
    (if (= x 0)
        (no x)
        (yes (/ 1 x))))

> (reciprocal 3 (lambda (x) x) (lambda (x) (se x '(cannot reciprocate))))
> (reciprocal 0 (lambda (x) x) (lambda (x) (se x '(cannot reciprocate))))

;two branches that is delayed.
