#| Problem 5 (Vectors).

Write a program rotate! that rotates the elements of a vector by one position. The
function should alter the existing vector, not create a new one. It should return the
vector. For example:

> (define v (make-vector 4))
> (vector-set! v 0 ’a)
okay
> (vector-set! v 1 ’b)
okay
> (vector-set! v 2 ’c)
okay
> (vector-set! v 3 ’d)
okay
> v
#(a b c d)
> (rotate! v)
#(d a b c) |#




(define (rotate! v)
    (define (iter i v)
        (if (< i 1)
            v
            (let
                (
                    (tmp (vector-ref v (- i 1)))
                )
                (begin
                    (vector-set! v (- i 1) (vector-ref v i))
                    (vector-set! v i tmp)
                    (iter (- i 1) v)
                )
            )
        )
    )
    (iter (- (vector-length v) 1) v)
)


(define v (make-vector 4))
(vector-set! v 0 'a )
(vector-set! v 1 'b )
(vector-set! v 2 'c )
(vector-set! v 3 'd )