#| Exercise 3.14: The following procedure is quite useful, although obscure:

(define (mystery x)
  
  (loop x '())
)
(define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x)))
)

Loop uses the “temporary” variable temp to hold the old value of the cdr of x, 
since the set-cdr! on the next line destroys the cdr. 
Explain what mystery does in general. Suppose v is defined by 
(define v (list 'a 'b 'c 'd )). 
Draw the box-and-pointer diagram that represents the list to which v is bound. 
Suppose that we now evaluate (define w (mystery v)). 
Draw box-and-pointer diagrams that show the structures v and w after evaluating this expression. 
What would be printed as the values of v and w?  |#


; Mystery reverses the list by shifting the value of x-list to the front of y-list.
; Only mutation so only pointers redirected.

;loop execution-steps:
;(null? (a b c d))
; #f
; temp = (b c d)
; (set-cdr! (b c d) '())
; v = (a)
; (loop (b c d) (a))

#| 
STk> (mystery v)
.. -> loop with x = (a b c d),  y = ()
.... -> loop with x = (b c d),  y = (a)
...... -> loop with x = (c d),  y = (b a)
........ -> loop with x = (d),  y = (c b a)
.......... -> loop with x = (),  y = (d c b a)
.......... <- loop returns (d c b a)
........ <- loop returns (d c b a)
...... <- loop returns (d c b a)
.... <- loop returns (d c b a)
.. <- loop returns (d c b a)
(d c b a) 
|#