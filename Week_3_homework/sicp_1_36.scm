#| 
An infinite continued fraction is an expression of the form
f = N 1 D 1 + N 2 D 2 + N 3 D 3 + … .
As an example, one can show that the infinite continued fraction expansion with the N i and the D i all equal to 1 produces 1 / φ , 
where φ is the golden ratio (described in 1.2.2). One way to approximate an infinite continued fraction is to 
truncate the expansion after a given number of terms. Such a truncation—a so-called finite continued fraction k-term finite continued fraction—has the form
N 1 D 1 + N 2 ⋱ + N k D k .
Suppose that n and d are procedures of one argument (the term index i ) that return the N i and D i of the terms of the continued fraction. 
Define a procedure cont-frac such that evaluating (cont-frac n d k) computes the value of the k -term finite continued fraction. 
Check your procedure by approximating 1 / φ using

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           k)

for successive values of k. 
How large must you make k in order to get an approximation that is accurate to 4 decimal places?  
|#

; recursive part
(define (cont-frac n d k)
    (if (<= k 0) 
             k
            (/ n (+ d (cont-frac (+ n 1) (+ d 1) (- k 1))) )
        
    )
)
(define tolerance 0.001)

(define (iter i) ; i needs to be over 1. No check of this is implemented.
    (if (< (abs (- 1 (/ 1 (cont-frac i i i)))) tolerance)
    i
    (iter (+ i 1)))
)


