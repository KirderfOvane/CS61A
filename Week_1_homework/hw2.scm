#| 2.Write a procedure squares that takes a sentence of numbers 
as its argument andreturns a sentence of the squares of the numbers: 
>(squares ’(2 3 4 5))
(4 9 16 25) |#

(define (square x)
    (* x x))
(define (squares sent)
(if (equal? sent '()) '() 
    (se (square (first sent)) 
    (squares (bf sent)))))

; trick here is to use se (sentence) to do two functions in the else.