#| 
Problem 3 (Normal and applicative order).
Imagine that there is a primitive procedure called counter, with no arguments,
 that returns 1 the first time you call it, 2 the second time, and so on.  
 (The multiplication procedure*, used below, is also primitive.)
Supposing that counter hasn’t been called until now, what is the value of the expression

(* (counter) (counter))

under applicative order? ;> (* 1 1) -> 1

under normal order? ;> (* 1 2) -> 2
|#