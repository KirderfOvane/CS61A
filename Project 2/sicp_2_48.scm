#| 
Exercise 2.48: A directed line segment in the plane can be represented as a pair of vectors—the 
vector running from the origin to the start-point of the segment,
and the vector running from the origin to the end-point of the segment. 
Use your vector representation from Exercise 2.46 to define a representation 
for segments with a constructor make-segment and selectors start-segment and end-segment.  
|#

(define xcor-vect car)
(define ycor-vect cdr)
(define make-vect cons)
(define (add-vect v1 v2)
    (make-vect 
        (+ (xcor-vect v1) (xcor-vect v2))
        (+ (ycor-vect v1) (ycor-vect v2))
    )
)

(define make-segment cons)
(define start-segment car)
(define end-segment cdr)



;testing
(define directed-line-segment s)
(make-segment (make-vector 0 0) (make-vector 1 2))
(make-segment (make-vector 0 0) (make-vector 3 4))

