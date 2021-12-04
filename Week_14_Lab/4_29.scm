#| Exercise 4.29: Exhibit a program that you would expect to run much more
slowly without memoization than with memoization. 
Also, consider the following interaction, 
where the id procedure is defined as in Exercise 4.27 
and count starts at 0: |#

(define (square x) (* x x))

;;; L-Eval input:
(square (id 10))

;;; L-Eval value:
;⟨response⟩ ;> 100

;;; L-Eval input:
count 

;;; L-Eval value:
;⟨response⟩ ;> 1

;Give the responses both when the evaluator memoizes and when it does not. 


; Programs witch call same procedure many times would be faster with memoization.
; For examp:
(define (fib n) 
     (if (<= n 2)
         1 
         (+ (fib (- n 1)) (fib (- n 2))))) 
; This recursion will end up calling same procedure many times in it subproblems.

