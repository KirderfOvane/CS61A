Exercise 3.65: Use the series
ln ⁡ 2 = 1 − 1 / 2 + 1 / 3 − 1 / 4 + …
to compute three sequences of approximations to the natural logarithm of 2, 
in the same way we did above for π . 
How rapidly do these sequences converge? 


(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0 (stream-map (lambda (guess) (sqrt-improve guess x)) guesses))
  )
  guesses
)

(define (sqrt-improve guess x)
  (average guess (/ x guess)))

  (define (average x y) 
  (/ (+ x y) 2))

  (display-stream (sqrt-stream 2))


  (define (pi-summands n)
  (cons-stream 
   (/ 1.0 n)
   (stream-map - (pi-summands (+ n 2)))))


(define (scale-stream stream factor)
  (stream-map
   (lambda (x) (* x factor))
   stream))

(define (partial-sums s)
  (define (iter s sum)
    (cons-stream sum (iter (stream-cdr s) (+ sum (stream-car s))))
  )
  (iter (stream-cdr s) (stream-car s))
)

(define pi-stream
  (scale-stream 
   (partial-sums (pi-summands 1)) 4))



(define (ln n i)
   ;(let (
    ;        (i 0)
     ;   )
        (cons-stream 
            (/ n (+ i 1)) 
                (stream-map (if (even? i) - +) (ln (+ n 1) (+ i 1)) )
        )
    ;) 
)

(define (ln n)

        (cons-stream 
            (/ 1.0 n ) 
                (stream-map - (ln (+ n 1) ) )
        )
)

(define ln2-stream
    (partial-sums (ln 1))
)