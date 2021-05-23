; Exercise 1.4.  Observe that our model of evaluation allows for combinations whose operators are compound expressions. 
; Use this observation to describe the behavior of the following procedure:

 (define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

  ; if b is more than zero, return + on a and b --> a + b
  ; else b is less than zero, return - on a and b --> a -b. As b is a negative also , two minus is equal to +.