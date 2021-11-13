#| Draw the environment diagram resulting from evaluating the following expressions, and
show the result printed by the last expression where indicated.
> (define x 4)

> (define (baz x)
    (define (* a b) (+ a b))
    (lambda (y) (* x y)))
    
> (define foo (baz (* 3 10)))

> (foo (* 2 x)) |#


; 32