Exercise 4.27: Suppose we type in the following definitions to the lazy evaluator:

(define count 0)
(define (id x) (set! count (+ count 1)) x)

Give the missing values in the following sequence of interactions, and explain your answers.242

(define w (id (id 10)))

;;; L-Eval input:
count

;;; L-Eval value:
⟨response⟩ ;> 1

;;; L-Eval input:
w 

;;; L-Eval value:
⟨response⟩ ;> 10

;;; L-Eval input:
count ;> 2

;;; L-Eval value:
⟨response⟩ ;> 10

;Every time id is called, count gets 1 added. Then returns x.
;Steps when w is defined:
; id is called with 10, count = 1
; w is returned with 10 and it's inner body is a thunk/promise. 
; id is called with 10 again,
; now it's thunk body is evaluated and so count becomes 2
; w returns 10

