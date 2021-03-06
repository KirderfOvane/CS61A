#| Exercise 3.40: Give all possible values of x that can result from executing

(define x 10)
(parallel-execute 
 (lambda () (set! x (* x x)))
 (lambda () (set! x (* x x x)))) |#

 ;answer: 100,1000,10000,100000,1000000


#| 
 Which of these possibilities remain if we instead use serialized procedures:

(define x 10)
(define s (make-serializer))
(parallel-execute 
 (s (lambda () (set! x (* x x))))
 (s (lambda () (set! x (* x x x))))) |#

 ;answer: 1000000