Problem 9 (Concurrency).
Consider the following three procedures and two serializers.
(define (incr) (set! x (+ x 1))) ;input can be: 0 => 1
(define (decr) (set! x (- x 1))) ;input can be: 0,1,2 => -1,0,1
(define (double) (set! x (* x 2))) ;input can be 0,1,-1 => 0,2,-2 => it can only be 0 if incr and decr executed before.
(define s (make-serializer))
(define t (make-serializer))
In each of the following situations, what outcomes are possible? For each case, choose the
single best answer.
(define x 0)
(parallel-execute (s (t incr)) (s (t decr)) double) 
x is -1, 0, or 1 
x is -1, 0, or 1, or possible deadlock
x is -2, -1, 0, 1, or 2 ;<-- correct answer
x is -2, -1, 0, 1, or 2, or possible deadlock
(define x 0)
(parallel-execute (s incr) (s (t decr)) (s double))
x is -1, 0, or 1 ;<-- correct answer
x is -1, 0, or 1, or possible deadlock
x is -2, -1, 0, 1, or 2
x is -2, -1, 0, 1, or 2, or possible deadlock 


