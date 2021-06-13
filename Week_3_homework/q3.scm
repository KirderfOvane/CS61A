(define (expt b n)
    (expt-iter b n 1)
)
(define (expt-iter b counter product)
    (if (= counter 0)
        product
        (expt-iter b (- counter 1) (* b product))
    )
)
; given base b and n exponents and starting number (product), we can find sum of b^n.
(expt 2 2) => 4