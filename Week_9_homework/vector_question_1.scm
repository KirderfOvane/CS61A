#| 1. Write vector-append, which takes two vectors as arguments and returns a new vector
containing the elements of both arguments, analogous to append for lists. |#

(define (vector-append vec1 vec2)
    (let 
        ( 
            (new-vec (make-vector (+ (vector-length vec1) (vector-length vec2))))
        )
        (define (copy-vectors vec index startindex)
                (if (< (+ startindex index) (+ startindex 0))
                    new-vec
                    (begin 
                        (vector-set! new-vec (+ startindex index) (vector-ref vec index))
                        (copy-vectors vec (- index 1) startindex)
                    )
                )
                
            
        )
        (begin  
                (copy-vectors vec1 (- (vector-length vec1) 1) 0)
                (copy-vectors vec2 (- (vector-length vec2) 1) (vector-length vec1) )
                new-vec
        )
        
    )
    
)

(define test (vector-append (vector 'one 'two 'three 4 5 6 7) (vector 1 2 3 9 22 5 5 5)))
(print test)