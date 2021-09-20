#| 2. Suppose that the following definitions have been provided.
(define x (cons 1 3))
(define y 2)
A CS 61A student, intending to change the value of x to a pair with car equal to 1 and cdr equal to 2,
types the expression (set! (cdr x) y) instead of (set-cdr! x y) and gets an error. Explain why. |#

; set! (cdr x) -> (cdr x) is evaluated before set! as it is an subexp. and therefore cdr x is 1.
; set! then tries to set 1 to 2 which it can't.
;set-cdr! points to the cdr-location inside the pair of x and sets/mutate/change it to 2.