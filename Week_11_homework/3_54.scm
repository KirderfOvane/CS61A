#| 
Exercise 3.54: Define a procedure mul-streams, analogous to add-streams, 
that produces the elementwise product of its two input streams. 
Use this together with the stream of integers to complete the following definition 
of the stream whose n th element (counting from 0) is n + 1 factorial:

(define factorials 
  (cons-stream 1 (mul-streams ⟨??⟩ ⟨??⟩))
) 
|#

(define (integers-starting-from n)
  (cons-stream 
   n (integers-starting-from (+ n 1))))
(define integers (integers-starting-from 1))

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define factorials (cons-stream 1 (mul-streams factorials integers)))


;testing
(define stream1 (stream-enumerate-interval 0 10))
(define stream2 (stream-enumerate-interval 10 20))
(ss (mul-streams stream1 stream2));> (0 11 24 39 56 75 96 119 144 171 ...)
(ss integers) ;> (1 2 3 4 5 6 7 8 9 10 ...)
(ss (mul-streams factorials integers));> (1 2 6 24 120 720 5040 40320 362880 3628800 ...)
