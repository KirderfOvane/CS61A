#| 2. Write vector-filter, which takes a predicate function and a vector as arguments,
and returns a new vector containing only those elements of the argument vector for which
the predicate returns true. The new vector should be exactly big enough for the chosen
elements. Compare the running time of your program to this version: |#

(define (vector-filter-list pred vec)
    (list->vector (filter pred (vector->list vec)))
)

(vector-filter-list number? (vector 'a 'b 'c 1 2 3 4 5))


(define (vector-filter pred vec)
    (define (count-true-values pred vec count i)
            (if (< i 0)
                count
                (if (pred (vector-ref vec i))
                    (count-true-values pred vec (+ count 1) (- i 1))
                    (count-true-values pred vec count (- i 1))
                )
            )        
    )
    
    (define (loop newvec n index)
        (if (< n 0)
            newvec
                (if (pred (vector-ref vec n))
                    (begin (vector-set! newvec index (vector-ref vec n)) (loop newvec (- n 1) (- index 1)))
                    (loop newvec (- n 1) index)
                    
                )  
        )
    )
    
   (loop 
        (make-vector (count-true-values pred vec 0 (- (vector-length vec) 1))) ;newvec
        (- (vector-length vec) 1) ;n
        (- (count-true-values pred vec 0 (- (vector-length vec) 1)) 1) ;index
    )
)




(vector-filter number? (vector 'a 'b 'c 1 2 3 4 5))
(vector-filter number? (vector 'a 'b 'c 1 2 3 4 5 'c 'd 4 6 66))
(vector-filter odd? (vector 1 2 3 1 2 3 4 5 6 5 4 6 66))