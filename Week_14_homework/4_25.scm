(define (unless condition usual-value exceptional-value)
  (if condition 
      exceptional-value 
      usual-value
  )
)


#| Exercise 4.25: Suppose that (in ordinary applicative-order Scheme) we 
define unless as shown above and then define factorial in terms of unless as |#

(define (factorial n)
  (unless (= n 1)
          (* n (factorial (- n 1)))
          1))

#| What happens if we attempt to evaluate (factorial 5)? 
Will our definitions work in a normal-order language?  |#

;In applicative-order it won't work as unless is never evaluated to true and will end in endless loop.
;In applicative order the subexpressions is evaluated first,then the procedure. In this case
;one of the subexpressions is calling factorial again. It never gets to evaluate to the condition and can therefore
;never quit.

;Yes it will work as unless is a normal procedure and evaluated in normal order
;if used in a normal order language.
; In normal order every expression gets broken down to primitives before evaluation.
