#| Exercise 3.52: Consider the sequence of expressions

(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq 
  (stream-map 
   accum 
   (stream-enumerate-interval 1 20)))

(define y (stream-filter even? seq))

(define z 
  (stream-filter 
   (lambda (x) 
     (= (remainder x 5) 0)) seq))

(stream-ref y 7)
(display-stream z)

What is the value of sum after each of the above expressions is evaluated? 
What is the printed response to evaluating the stream-ref and display-stream expressions?


Would these responses differ if we had implemented 

(delay ⟨exp⟩) simply as (lambda () ⟨exp⟩) 

without using the optimization provided by memo-proc? Explain. 
;yes they would as z-procedure is using lambda.

;breakdown
(define sum 0)
;0
(define (accum x)
  (set! sum (+ x sum))
  sum)
;0

(ss (stream-map 
   accum 
   (stream-enumerate-interval 1 20)) 20)
;(1 3 6 10 15 21 28 36 45 55 66 78 91 105 120 136 153 171 190 210)

(ss (stream-filter even? (stream-enumerate-interval 1 20)) 20)
;(2 4 6 8 10 12 14 16 18 20)

 (ss (stream-filter 
   (lambda (x) 
     (= (remainder x 5) 0)) (stream-filter even? (stream-enumerate-interval 1 20))))
;(10 20) |#