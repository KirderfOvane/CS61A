#| Exercise 3.46: Suppose that we implement test-and-set! using an ordinary procedure as shown in the text,
without attempting to make the operation atomic. 
Draw a timing diagram like the one in Figure 3.29 to demonstrate 
how the mutex implementation can fail by allowing two processes 
to acquire the mutex at the same time.  |#

;answer:

#| Two threads can execute this function and be 
between this: |#
;(define (test-and-set! cell)
 ; (if (car cell)
  

;  and this:

 ;     true
  ;    (begin (set-car! cell true)
   ;          false)))

; both will get false and both will claim the mutex, breaking the serializer.
; get and set must change at the same time so another process can't sneak in.