#| Problem 2 (Orders of growth, iterative/recursive processes). |#

(define (garply n)
    (if (< n 20)
        n
        (+ (foo n) (garply (- n 1)) )
    ) 
)

#| 
Assuming foo is defined somewhere, please circle True or False, and in one sentence explain your choice.
True or False: 
We have enough information to determine the order of growth of garply.
;> False, we need to know the order of growth of foo. If foo is 0(1) then garply is 0(n).


True or False: 
No matter how foo is defined,garply will always have an order of growth greater than or equal to Θ(n). 
True, garply is 0(n) even if foo is 0(1).
|#


; True or False: garply has an order of growth in Θ(n2) if foo is defined as:
(define (foo n)
    (if (< n 100)
        121
        (+ (* n 100) (foo (- n 1)))
    )
)
; True, foo is called n-times every time it's called in garply. 0(n^2)


; True or False:garply generates a iterative process.

; False, garply is not the last function call in garply, as + is the last procedure that is called in (+ (foo n) (garply (- n 1))). Therefore it's not a tail recursive call and therefore not
; converted internally by scheme to a iterative procedure.