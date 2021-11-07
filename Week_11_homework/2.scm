#| Write and test two functions to manipulate nonnegative proper fractions. The first
function, 

fract-stream, will take as its argument 
a list of two nonnegative integers, the numerator and the denominator, in which the numerator is less than the denominator.

It will return an infinite stream of decimal digits representing the decimal expansion of the
fraction. 

(define (fract-stream li)
    (cons-stream li (stream-map * integers powers))
)

The second function, approximation, will take 

two arguments: a fraction stream and a nonnegative integer numdigits. 

It will return a list (not a stream) containing the first numdigits digits of the decimal expansion. |#

#| 
(fract-stream '(1 7)) should return the stream representing the decimal expansion of 1 / 7 , which is 0.142857142857142857...
(stream-car (fract-stream '(1 7))) should return 1.
(stream-car (stream-cdr (stream-cdr (fract-stream '(1 7))))) should return 2.
(approximation (fract-stream '(1 7)) 4) should return (1 4 2 8).
(approximation (fract-stream '(1 2)) 4) should return (5 0 0 0). |#

(define ones (cons-stream 1 (stream-map + ones)))
(define tens (cons-stream 10 (stream-map + tens)))
(define integers (cons-stream 1 (stream-map + integers ones)))
  
(define (fract-stream li)           
  (cons-stream (quotient (* (car li) 10) (cadr li)) ; 1 4
               (fract-stream (list (remainder (* (car li) 10) (cadr li)) (cadr li)))
  )
)
(ss (fract-stream '(1 7) ))

(define (approximation s n)
        (define (iter s n li)
            (if (= n 0)
                li
                (iter (stream-cdr s) (- n 1) (append li (list (stream-car s)) ))
            )
        )
        (iter s n '() )
)

(approximation (fract-stream '(1 7)) 4)
(approximation (fract-stream '(1 2)) 4) 