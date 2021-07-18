#| Exercise 2.37: Suppose we represent vectors v = (vi) as sequences of numbers, and matrices m = (mij) as sequences of 
vectors (the rows of the matrix). For example, the matrix
146257368469
is represented as the sequence ((1 2 3 4) (4 5 6 6) (6 7 8 9)).
With this representation, we can use sequence operations to concisely express the basic matrix and vector operations.
These operations (which are described in any book on matrix algebra) are the following:
(dot-product v w)
(matrix-*-vector m v)
(matrix-*-matrix m n)
(transpose m)
returns the sumΣiviwi;
returns the vectort,
whereti=Σjmijvj;
returns the matrix p,where pij=Σkmiknkj;
returns the matrixn,wherenij=mji.
We can define the dot product as 

(define (dot-product v w)
  (accumulate + 0 (map * v w)))
Fill in the missing expressions in the following procedures for computing the other matrix operations. 
(The procedure accumulate-n is defined in Exercise 2.36.)

(define (matrix-*-vector m v)
  (map ⟨??⟩ m))

(define (transpose mat)
  (accumulate-n ⟨??⟩ ⟨??⟩ mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map ⟨??⟩ m))) |#


(define (accumulate fn init li)
  (if (null? li)
     init
      (fn (car li) (accumulate fn init (cdr li)))
  )
)
(define (accumulate-n fn init li)
  (if (null? li)
      init
      (if (null? (cdr li))
          (accumulate fn init (car li))
          (accumulate-n fn init (cdr li))
      )
  )
)
(define (accumulate-n fn init li) 
  (if (null? (car li))
      '()
      (cons
       (accumulate fn init (map car li))
       (accumulate-n fn init (map cdr li))
      )
  )
)

(define (dot-product v w)
  (accumulate + 0 (map * v w)))


 (define (matrix-*-vector m v)
    (map (lambda (row) (dot-product row v)) m)
  )

(define (transpose mat)
  (accumulate-n cons '() mat)
)
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row) 
          (matrix-*-vector cols row)
         ) m)
  )
)
;testing
 (define matrix (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9)))
 (define vector (list 4 5 6))
 (matrix-*-vector matrix vector)
 (matrix-*-matrix matrix matrix)