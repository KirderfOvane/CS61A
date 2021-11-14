#| Problem 4 (List mutation).

Write merge!, a procedure that takes two arguments, each of which is a list of numbers in
increasing order. It returns a combined, ordered list of all the numbers:
> (merge! (list 3 5 22 26) (list 2 7 10 30))

(2 3 5 7 10 22 26 30)

Your procedure must do its work by mutation, changing the pointers between pairs to
create the new combined list. The original lists will no longer exist after your procedure
is finished.

Note: Do not allocate any new pairs in your solution. Rearrange the existing pairs. |#

(define (merge li1 li2)
    (if (null? li1)
        li2
         (if (null? li2)
            li1
            (begin
                (if (> (car li1) (car li2))
                    (begin (set-cdr! li1 (merge (cdr li1) li2)) li1)
                    (begin (set-cdr! li2 (merge li1 (cdr li2))) li2)
                )
            )
         )
    ) 
)


(define x (list 3 5 22 26))
(define y (list 2 7 10 30))



