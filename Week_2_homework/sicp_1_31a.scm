#| Exercise 1.31 a.  The sum procedure is only the simplest of a vast number of similar abstractions
that can be captured as higher-order procedures.
Write an analogous procedure called product that returns the product of 
the values of a function at points over a given range. 
Show how to define factorial in terms of product. 
Also use product to compute approximations to π using the formula
π / 4 = 2 ⋅ 4 ⋅ 4 ⋅ 6 ⋅ 6 ⋅ 8 ⋅ ⋯
        3 ⋅ 3 ⋅ 5 ⋅ 5 ⋅ 7 ⋅ 7 ⋅ ⋯ 
 |#

; product over range
(define (product lowerRange upperRange)
    (if (>= lowerRange upperRange)
    lowerRange
    (* lowerRange (product (+ lowerRange 1) upperRange)))
  )

;factorial
(define (factorial num)
  (if (= num 1)
  num
  (* num (factorial (- num 1))))
)

; pi approximations:
(define (sumEven a s e)
(if (>= s e)
a
(if (= (remainder s 2) 0)
  (* a (sumEven (+ a 2) (+ s 1) e))
  (* a (sumEven a (+ s 1) e)))))


(define (sumOdd a s e)
(if (>= s e)
a
(if (= (remainder s 2) 0)
  (* a (sumOdd a (+ s 1) e))
  (* a (sumOdd (+ a 2) (+ s 1) e)))))

(define (product start steps) (* 4 (/ (sumeven start 0 steps) (sumodd (+ start 1) 0 steps))))
; (product 2 155) is around what it can handle


