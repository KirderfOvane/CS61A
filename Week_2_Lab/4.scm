#| 4. For each of the following expressions, 
what must f be in order for the evaluation of the expression to succeed, 
without causing an error?  
For each expression, give a definition of f such that evaluating the expression will not cause an error, 
and say what the expression’s value will be, given your definition.

|#


f -> (define f 3) > f -> 3
(f) -> (define (f) 3) > (f) -> 3
(f 3) -> (define (f x) (+ x)) > (f 3) -> 3
((f)) -> (define (f) (lambda () 'hello)) > ((f)) -> 'hello
(((f)) 3) -> (define (f) (lambda () (lambda (x) (+ x x)))) > (((f)) 3) -> 6
