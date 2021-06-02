#| 5. Find the values of the expressions
((t 1+) 0)
((t (t 1+)) 0)                          
(((t t) 1+) 0)


where 1+ is a primitive procedure that adds 1 to its argument, 
and t is defined as follows:
(define (t f)(lambda (x) (f (f (f x)))) )
Work this out yourself before you try it on the computer!
|#


(define (1+ x) (+ x 1))
(define (t f)(lambda (x) (f (f (f x)))) )

((t 1+) 0) -> ((lambda (x) (1+ (1+ (1+ x)))) 0) -> x = 0 -> 3
------------------------------------------------------
((t (t 1+)) 0) -> ((lambda (x) (1+ (1+ (1+ x))))       -> 9
                   ((lambda (x) (1+ (1+ (1+ x))))
                    ((lambda (x) (1+ (1+ (1+ x)))) 0)))
----------------------------------------------------------
(((t t) 1+) 0) -> (t t):part = (t (lambda (x) (t (t  (t x) ) ) ) ) -> ((t t) 1+):part = (t (t (t (t 1+)))) -> (t 1+) is 3 and (t (t 1+)) is 9 so -> 3 * 9 = 27