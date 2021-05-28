#| 5.Write a procedure ends-e that takes a sentence as its argument 
and returns a sentence containing only those words of the argument 
whose last letter is E:

> (ends-e '(please put the salami above the blue elephant))
(please the above the blue)
|#

; test sentence
(define sent '(please put the salami above the blue elephant))

; recursive part
(define (recursion sent)
    (if (equal? (last (first sent)) 'e) 
    (se (first sent) (ends-e (bf sent))) 
    (ends-e (bf sent)))
)

; base case part
(define (ends-e sent)
(if (not (empty? sent)) (recursion sent) '())
)