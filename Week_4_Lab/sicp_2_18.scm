#| Exercise 2.18: Define a procedure reverse that takes a list as argument and returns a list of the same elements in reverse order:

(reverse (list 1 4 9 16 25))
(25 16 9 4 1) |#

(define (reverse li) 
    (define (length items)
        (define (length-iter a count)
            (if (null? a)
                count
                (length-iter (cdr a) 
                            (+ 1 count))))
        (length-iter items 0)
    )
    (define (iter li list-length)
        (if (> 1 list-length)
            li
            (append (iter (cdr li) (- list-length 1)) (list (car li)))
        )
    )
    (iter li (length li))
)

 
;testing
(reverse (list 1 4 9 16 25))