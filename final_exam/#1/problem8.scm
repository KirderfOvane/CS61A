Problem 8 (Mutation).
Write the procedure interleave! that takes two lists (not streams!) as arguments and
returns the result of interleaving them. It must do its job by mutation, without
allocating any new pairs! Example:
> (define x (list ’a ’b ’c ’d ’e))
> (define y (list 1 2 3 4 5 6 7 8))
> (define z (interleave! x y))
> z
(a 1 b 2 c 3 d 4 e 5 6 7 8)
> x
(a 1 b 2 c 3 d 4 e 5 6 7 8)
> y
(1 b 2 c 3 d 4 e 5 6 7 8)
Note that either list might be shorter than the other; your procedure should handle this
situation correctly.
Our solution uses five lines of code; if yours takes more than ten, you’re probably not
thinking about this properly.

(define (interleave! li-x li-y)
    (define length-x (length li-x))
    (define length-y (length li-y))
    (define (loop iterator length-x length-y li-x li-y)
        (if (and (< length-x iterator) (< length-y iterator))
            li-x
            (begin
                (if (< length-x iterator) (set-cdr! (list-ref li-y iterator) (list-ref li-x iterator)))
                (if (< length-y (+ iterator 1)) (set-cdr! (list-ref li-x iterator) (list-ref li-y (+ iterator 1))))
                (loop (+ iterator 1) length-x length-y li-x li-y)
            )
        )
    )
    (loop 0 length-x length-y li-x li-y)
)


 (define x (list 'a 'b 'c 'd 'e ))
 (define y (list 1 2 3 4 5 6 7 8))