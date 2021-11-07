#| Exercise 3.68: Louis Reasoner thinks that building a stream of pairs from three parts is unnecessarily complicated. 
Instead of separating the pair ( S 0 , T 0 ) from the rest of the pairs in the first row, he proposes to work with the whole first row, 
as follows:

(define (pairs s t)
  (interleave
   (stream-map
    (lambda (x) 
      (list (stream-car s) x))
    t)
   (pairs (stream-cdr s)
          (stream-cdr t))
  )
)

Does this work? Consider what happens if we evaluate (pairs integers integers) using Louis’s definition of pairs.  |#

; Answer: First time s2 inside interleave is called , we call pairs inside of it. This results in an infinite loop inside s2,so first interleave is 
; never evaluated. This is because interleave is a normal procedure where both arguments is evaluated before doing the interleave-operation.

(define ones 
  (cons-stream 1 (stream-map + ones ))
)
(define integers
  (cons-stream 1 (stream-map + ones integers))
)

(define (stream-append s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream 
       (stream-car s1)
       (stream-append (stream-cdr s1) s2))))


(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream 
       (stream-car s1)
       (interleave s2 (stream-cdr s1)))
  )
)




