#| Problem 12 (Lazy evaluator).
Suppose that the following expressions are entered into the lazy interpreter in the order
shown.
;;; L-Eval input:
(define (truth x y) (display (+ x 1)) y)
                                            <----- point A
;;; L-Eval input:
(define beauty (truth (* 6 7) (- 5 2)))
                                            <----- point B
;;; L-Eval input:
beauty
                                            <----- point C
The three primitives +, *, and - will each be executed exactly once at some point during
the session. Indicate when each of them will occur.
+ will be executed at point answer: b
* will be executed at point answer: b
- will be executed at point answer: c 
|#