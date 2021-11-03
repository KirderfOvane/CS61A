#| Exercise 3.55: 

Define a procedure partial-sums that takes as argument a stream S 
and returns the stream whose elements are 
S 0 , S 0 + S 1 , S 0 + S 1 + S 2 , … . 

For example, (partial-sums integers) should be the stream 1, 3, 6, 10, 15, ….  |#


(define (partial-sums s)
  (define (iter s sum)
    (cons-stream sum (iter (stream-cdr s) (+ sum (stream-car s))))
  )
  (iter (stream-cdr s) (stream-car s))
)

;testing

(ss (partial-sums integers))



