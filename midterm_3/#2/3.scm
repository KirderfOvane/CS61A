Problem 3 (Drawing environment diagrams).

Draw the environment diagram resulting from evaluating the following expressions, and
show the result printed by the last expression where indicated.
> (define foo
    (lambda (x f)
        (if f
            (f 7)
            (foo 5 (lambda (y) (+ x y))))))

> (foo 3 #f)

; a procedure point to (lambda (y) (+ x y) is the result.