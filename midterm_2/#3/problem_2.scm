#| Problem 2 (Tree recursion)
The following definition comes from page 116 of SICP:
(define (accumulate op initial sequence)
(if (null? sequence)
initial
(op (car sequence)
(accumulate op initial (cdr sequence)))))
In this problem you’re going to extend the idea of accumulation from sequences to “deep
lists”: lists of lists of lists to arbitrary depth. Write deep-accumulate, a function of three
arguments: a two-argument function, an initial value, and a list structure. It should work
like this:
> (deep-accumulate + 0 ’(3 (4 (5) ((6) 7) 8) (9 10)))
52 |#



(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence))
        )
    )
)



(define (deep-accumulate op initial sequence)
    (if (null? sequence)
        initial
        (if (list? (car sequence))
            (op (deep-accumulate op initial (car sequence)) 
                (deep-accumulate op initial (cdr sequence))
            )
            (op (car sequence)
                (deep-accumulate op initial (cdr sequence))
            )
        )
    )
)

(deep-accumulate + 0 '(3 (4 (5) ((6) 7) 8) (9 10)))