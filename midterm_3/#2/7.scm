#| Problem 7 (Streams).

We want to change the stream abstraction so that an ordinary list can be used as a stream.
That is, we want the selectors stream-car and stream-cdr to accept either an ordinary
list or a stream as argument. Write the new versions of stream-car and stream-cdr. |#



(define (stream-car s-or-li)
    (car s-or-li)
)

(define (stream-cdr s-or-li)
    (if (list? s-or-li)
        (cdr s-or-li)
        (force (cdr s-or-li))
    )
)

