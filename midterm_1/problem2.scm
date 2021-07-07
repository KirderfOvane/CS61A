#| Problem 2 (Orders of growth).
(a) Indicate the order of growth in time of foo below:
(define (foo n)
    (if (< n 2)
        1
        (+ (baz (- n 1))
           (baz (- n 2)) ) ))
           
(define (baz n)(+ n (- n 1)) )


Θ(1) Θ(n) Θ(n2) Θ(2n)
;> 0(n2)


(b) Indicate the order of growth in time of garply below:
(define (garply n)
    (if (= n 0)
        0
        (+ (factorial n) (garply (- n 1)))))
        
(define (factorial n)
    (if (= n 0)
    1
    (* n (factorial (- n 1)))))
    

Θ(1) Θ(n) Θ(n2) Θ(2n) 
;> 0(2n)
|#