#| Problem 6 (Concurrency).

(a) Suppose we say

> (define baz 10)

> (define s (make-serializer))

> (parallel-execute (s (lambda () (set! baz (/ baz 2))))
                    (s (lambda () (set! baz (+ baz baz)))))

What are the possible values of baz after this finishes? |#

; Only 10


#| (b) Now suppose that we change the example to leave out the serializer, as follows:
> (define baz 10)

> (parallel-execute (lambda () (set! baz (/ baz 2)))
                    (lambda () (set! baz (+ baz baz))))

What are all of the possible values of baz this time? |#

; 5 ,10, 15 and 20.