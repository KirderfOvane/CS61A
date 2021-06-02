#| 6. Find the values of the expressions 
((t s) 0)                           
((t (t s)) 0)                           
(((t t) s) 0)

where t is defined as in question 2 above: (define (t f)(lambda (x) (f (f (f x)))) ) 
and s is defined as follows: 
(define (s x)(+ 1 x)) |#

; s is the same as 1+ in question 2 so the values/answers is exactly the same,just that 1+ is named s