#| 4. Given this definition:
(define (plus1 var)
    (set! var (+ var 1))
    var)
Show the result of computing
(plus1 5)
using the substitution model. That is, show the expression that results from substituting 5 for var in the
body of plus1, and then compute the value of the resulting expression. What is the actual result from
Scheme? |#


(define (plus1 var)
    (set! var (+ var 1)) var)


;substitution model:
(plus1 5) 
(set! 5 (+ 5 1) ...) ; <- it fails after set! as we try to assign 5+1 to the number 5.
;environment model:
(plus1 5) 
; a new environment is created where var = 5
(set! var (+ 5 1)) ; -> var is set to 6.