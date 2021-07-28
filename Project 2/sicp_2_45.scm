#| Exercise 2.45: Right-split and up-split can be expressed as instances of a general splitting operation. 
Define a procedure split with the property that evaluating

(define right-split (split beside below))
(define up-split (split below beside))

produces procedures right-split and up-split with the same behaviors as the ones already defined.  |#

(define right-split (split beside below))
(define up-split (split below beside))


(define (split fn1 fn2)
  (lambda (painter)
    (let (
          (fn1-result-painter (fn1 painter painter)) ;let-var
         )
          (fn2 fn1-result-painter painter) ;body
    )
  )
)




