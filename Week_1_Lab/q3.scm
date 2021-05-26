

(define (lw a b)
(if (<= a b) a b))

(define (findLowestNumOfThree a b c)
(lw (lw a b) c))

(define (square x)(* x x))

(define (sumOfSquareOfTwoLargestNumber a b c)
    (+ 
        (square (if (not (= a (findLowestNumOfThree a b c))) a 0)) 
        (square (if (not (= b (findLowestNumOfThree a b c))) b 0)) 
        (square (if (not (= c (findLowestNumOfThree a b c))) c 0))
    )
)

