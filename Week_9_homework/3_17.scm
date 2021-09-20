#| Exercise 3.17: Devise a correct version of the count-pairs procedure of 
Exercise 3.16 that returns the number of distinct pairs in any structure.
(Hint: Traverse the structure, maintaining an auxiliary data structure 
that is used to keep track of which pairs have already been counted.)  |#

(define (count-pairs y)
    (let ((visited '()))
        (define (inner-iter x)
            (print visited)
            (if (not (pair? x))
                0
                (+ 
                    (if (contains? (car x) visited)
                        0
                        (begin 
                            (set! visited (cons (car x) visited) )
                            (inner-iter (car x))
                        )
                    )
                    (if (contains? (cdr x) visited)
                        0
                        (begin 
                            (set! visited (cons (cdr x) visited) )
                            (inner-iter (cdr x))
                        )
                    )
                    1)
            )
        )
        (inner-iter y)
    )
)

(define (contains? val-ue li-st)
    (define (iter val li)
        (if (null? li)
            #f
            (if (eq? val (car li))
                #t
                (iter val (cdr li))
            )
        )
    )
    (iter val-ue li-st)
)

;contains-testing
(contains? 'a (list 'a 'b 'c 'd ))
(contains? 'e (list 'a 'b 'c 'd ))

(trace contains?)

(define x (list 1))
(define y (cons x x))
(define c (cons y y))

;count-pairs-testing
(count-pairs c) ;> 3

(count-pairs '(1 2 3) )

(define b (list 1 2 3))
(set-car! (cdr b) (cddr b))
(count-pairs b)


(count-pairs (list 'a 'b 'c 'd 'e 'f )) ;> 6
(count-pairs (list 'a (list 'w 'g 'z ) 'c 'd 'e 'f ));> 9




