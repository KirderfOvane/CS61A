#|
Exercise 2.46: A two-dimensional vector v running from the origin to a point can be represented 
as a pair consisting of an x -coordinate and a y -coordinate. 

Implement a data abstraction for vectors by giving a constructor make-vect 
and corresponding selectors xcor-vect and ycor-vect. 
In terms of your selectors and constructor, implement 
procedures add-vect, sub-vect, and scale-vect that perform the operations 
vector addition, vector subtraction, and multiplying a vector by a scalar:
( x 1 , y 1 ) + ( x 2 , y 2 ) = ( x 1 + x 2 , y 1 + y 2 ) , 
( x 1 , y 1 ) − ( x 2 , y 2 ) = ( x 1 − x 2 , y 1 − y 2 ) , 
s ⋅ ( x , y ) = ( s x , s y ) . 

|#

(define (xcor-vect) 
    (lambda (x) x)
)

(define (ycor-vect)
    (lambda (y) y)
)

(define (make-vect xcor-vect ycor-vect)
    (cons xcor-vect ycor-vect) 
)

(define (add-vect v x y)
    (cons (+ (car v) x) (+ (cdr v) y))
)



;alt
(define xcor-vect car)
(define ycor-vect cdr)
(define make-vect cons)
(define (add-vect v1 v2)
    (make-vect 
        (+ (xcor-vect v1) (xcor-vect v2))
        (+ (ycor-vect v1) (ycor-vect v2))
    )
)