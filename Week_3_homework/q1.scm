#| 2. A “perfect number” is defined as a number equal to the sum of all its 
factors less than itself. 
For example, the first perfect number is 6, 
because its factors are 1, 2, 3, and 6,and 1+2+3=6. 
The second perfect number is 28, because 1+2+4+7+14=28. 
What is the third perfect number? 
Write a procedure (next-perf n) that tests numbers starting with n and 
continuing with n+1,n+2, etc. 
until a perfect number is found.  

Then you can evaluate(next-perf 29)
to solve the problem. 
Hint: you’ll need a sum-of-factors subprocedure.
[Note: If you run this program when the system is heavily loaded, 
it may take half an hour to compute the answer! 
Try tracing helper procedures to make sure your program is ontrack, 
or start by computing(next-perf 1)and see if you get 6.] |#

(define (factoring num i s)
    (if (> i num)
        s
        (if (integer? (/ num i))
            (+ s (factoring num (+ i 1) (/ num i)) )
            (factoring num (+ i 1) s)
        )
    )
)

(define (next-perf num i)
    (if (<= num 0)
        (- i 1)
        (if (= (/ (factoring i 1 0) 2) i)
            (next-perf (- num 1) (+ i 1))
            (next-perf num (+ i 1))
        )
    )
)
; rank 5 perfect number:
;((lambda (x) (= (/ (factoring x 1 0) 2) x)) 33550336)

; Major misunderstanding here, read the question too fast, so i 
; thought we were supposed to find the 29nth perfect number, not the 3rd.
; factoring time can be cut in half but i was looking for something more substantial to
; get (next-perf 29 1) to finish... in my lifetime.

; to use:
(next-perf 3 1)