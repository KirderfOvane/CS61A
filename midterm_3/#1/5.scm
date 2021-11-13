#| Problem 5 (Vectors).

Suppose there are N students taking a midterm. Suppose we have a vector of size N,
and each element of the vector represents one student’s score on the midterm. Write a
procedure (histogram scores) that takes this vector of midterm scores and computes
a histogram vector. That is, the resulting vector should be of size M+1, where M is the
maximum score on the midterm (it’s M+1 because scores of zero are possible), and element
number I of the resulting vector is the number of students who got score I on the midterm.
For example:

> (histogram (vector 3 2 2 3 2))

#(0 0 3 2) ;; no students got 0 points, no students got 1 point, 3 students got 2 points, and 2 students got 3 points.
> (histogram (vector 0 1 0 2))

#(2 1 1) ;; 2 students got 0 points, 1 student got 1 point, and 1 student got 2 points.
Do not use list->vector or vector->list.
Note: You may assume that you have a procedure vector-max that takes a vector of
numbers as argument, and returns the largest number in the vector. |#

(define (histogram scores)
    (let 
        (
            (hi-vi (make-vector (vector-max scores) 0))
        )
        (define (iter-scores i p scores count)
            (if (> i 0)
                (if (= (vector-ref scores i) p)
                    (iter-scores (- i 1) p scores (+ count 1))
                    (iter-scores (- i 1) p scores count)
                )
                count
            )
        )
        (define (iter-points p hi-vi) 
            (if (> p 0)
                (vector-set! hi-vi p (iter-scores (vector-length scores) scores 0))
                hi-vi
            )
        )
        (iter-points (vector-length scores) hi-vi)
    )
    
)
