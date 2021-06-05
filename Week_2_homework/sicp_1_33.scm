#| You can obtain an even more general version of accumulate (Exercise 1.32) by introducing the notion of a filter on the terms to be combined. 
That is, combine only those terms derived from values in the range that satisfy a specified condition. 
The resulting filtered-accumulate abstraction takes the same arguments as accumulate, 
together with an additional predicate of one argument that specifies the filter. 
Write filtered-accumulate as a procedure. 
Show how to express the following using filtered-accumulate:

    the sum of the squares of the prime numbers in the interval a to b (assuming that you have a prime? predicate already written)

    the product of all the positive integers less than n that are relatively prime to n 
    (i.e., all positive integers i < n such that GCD ( i , n ) = 1 ).  
    
    |#


; filter-accumulate
(define (filter-accumulate combiner filter null-value term a next b)
  (if (> a b)
      null-value
      (if (filter a)
      (combiner (term a) (filter-accumulate combiner filter null-value term (next a) next b))
       (filter-accumulate combiner filter null-value term (next a) next b))))

(define (sum term a next b) (filter-accumulate + prime? 0 term a next b))
(define (sumRelativePrime n) (filter-accumulate * (lambda (x) (= 1 (gcd x n))) 1 (lambda (x) x) 1 inc n ))
; this is a incomplete prime-tester. It needs to go through all prime n below a and divide with n to check if real prime.
(define (prime? a)
    (or (= a 2) (and (> a 1) (not (= (remainder a 2) 0))))
)

; helper procedures
(define (inc n) (+ n 1))
(define (cube x) 
    (* x x x)
)
(define (square x) (* x x))
(define (add x) (+ x x))


;calling..
;(sum square 1 inc 5) => 38
;(sumrelativeprime 8) => 105


  


;;;; abstraction definition / generic
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b)))
)

; incremental helper procedure
(define (inc n) (+ n 1))
; helper procedure / term
(define (cube x) 
    (* x x x)
)

; abstraction
(define (sum-cubes a b)
    (sum cube a inc b)
)
