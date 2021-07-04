#| Exercise 2.12: Define a constructor make-center-percent that takes a center and a percentage tolerance and produces the desired interval. 
You must also define a selector percent that produces the percentage tolerance for a given interval. 
The center selector is the same as the one shown above.  |#

(define (make-interval a b) (cons a b))
(define (upper-bound interval)
    (cdr interval)
)
(define (lower-bound interval)
    (car interval)
)


(define (make-center-percent center percentage-tolerance)
    (make-interval 
        (- center (* center (* percentage-tolerance 0.01)) )
        (+ center (* center (* percentage-tolerance 0.01)) )
    )
)

;testing
(make-center-percent 100.0 15) ;> (85.0 . 115.0)


