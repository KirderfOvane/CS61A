#| 
Problem 3 (Normal/applicative order).
If an expression produces an error, just say “error”
if it returns a procedure, just say “procedure.” 

Given the following definitions: 
|#

(define (mountain x) 'done)
(define (dew) (dew))

#| 
(a) What will be the result of the expression (mountain (dew))
in normal order?  -> 'done
in applicative order?  -> error, infinite loop calling (dew)
|#

#| 
(b) What will be the result of the expression(mountain dew)
in normal order?  -> 'done
in applicative order?  -> error, no such thing as dew, only (dew)
|#