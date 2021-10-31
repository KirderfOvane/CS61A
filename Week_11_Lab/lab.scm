#| 1. What is the type of the value of (delay (+ 1 27))? What is the type of the value of (force (delay
(+ 1 27)))?  |#

;answer: 28


#| 2. Evaluation of the expression
(stream-cdr (stream-cdr (cons-stream 1 '(2 3))))
produces an error. Why? |#

; 3 is not a promise, which stream-cdr is looking for.
; (cdr (stream-cdr (cons-stream 1 '(2 3)))) works though.


#| 3. Consider the following two procedures.

(define (enumerate-interval low high)
    (if (> low high)
    '()
    (cons low (enumerate-interval (+ low 1) high)) ) )

(define (stream-enumerate-interval low high)
    (if (> low high)
    the-empty-stream
    (cons-stream low (stream-enumerate-interval (+ low 1) high)) ) )

What’s the difference between the following two expressions?
(delay (enumerate-interval 1 3))
(stream-enumerate-interval 1 3) |#

;first expression has whole interval inside one stream step, from 1-3. All sequences.
;second expression has one sequence "loaded" (1-2) , rest is delayed and only loads when invoked (2-3).

#| 4. An unsolved problem in number theory concerns the following algorithm for creating a sequence of positive
integers s1, s2, ...
Choose s1 to be some positive integer.
For n > 1,
if sn is odd, then sn+1 is 3sn + 1;
if sn is even, then sn+1 is sn/2.
No matter what starting value is chosen, the sequence always seems to end with the values 1, 4, 2, 1, 4, 2,
1, ... However, it is not known if this is always the case.

4a. Write a procedure num-seq that, given a positive integer n as argument, returns the stream of values
produced for n by the algorithm just given. For example, (num-seq 7) should return the stream representing
the sequence 7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1, 4, 2, 1, ... |#


(define (num-seq n)
    (if (> n 1)
        (if (even? n)
           (cons-stream (/ n 2) (num-seq (/ n 2)))
           (cons-stream (+ (* n 3) 1) (num-seq (+ (* n 3) 1)))
        )
    )   
)


#| 4b. Write a procedure seq-length that, given a stream produced by num-seq, returns the number of values
that occur in the sequence up to and including the first 1. For example, (seq-length (num-seq 7)) should
return 17. You should assume that there is a 1 somewhere in the sequence. |#

(define (seq-length num-seq-stream)
    (define (iter seq count)
            (if (= 1 (stream-car seq)) 
                (+ count 1)
                (iter (stream-cdr seq) (+ count 1))
            )
    )
    (iter num-seq-stream 0)
)

