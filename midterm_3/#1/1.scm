Problem 1 (box and pointer).

What will the Scheme interpreter print in response to the last expression in each of the
following sequences of expressions? Also, draw a “box and pointer” diagram for the result
of each printed expression. If any expression results in an error, circle the expression
that gives the error message. Hint: It’ll be a lot easier if you draw the box and pointer
diagram first!

(let ((x (list 1 2 3)))
    (set-car! x (list ’a ’b ’c)) ;((a b c) 2 3)
    (set-car! (cdar x) ’d); (a d) 2 3)
    x) 

; (a d) 2 3)

(define x 3)
(define m (list x 4 5))
(set! x 6)
m 
; (3 4 5)

(define x (list 1 ’(2 3) 4))
(define y (cdr x)) ; ((2 3) 4)
(set-car! y 5)
x 
; (1 (2 3) 4)

(let ((x (list 1 2 3))) ;(1 2 3)
    (set-cdr! (cdr x) x) ; (2 3) -> (1 2 3) -> (1 (1 2 3))
    x)

;(1 (1 2 3))