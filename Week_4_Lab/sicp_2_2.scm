(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

;segment
(define (make-segment p1 p2)
    (cons p1 p2)
)

;segment selectors
(define (start-segment segment)
    (car segment)
)
(define (end-segment segment)
    (cdr segment)
)
;points
(define (make-point xcor ycor)
    (cons xcor ycor)
)
;midpoint
(define (midpoint-segment segment)
    (cons
        (/ (+ (car (start-segment segment)) (car (end-segment segment))) 2.0)
        (/ (+ (cdr (start-segment segment)) (cdr (end-segment segment))) 2.0)
    )
)
;exec /testing
(define p1 (make-point 1.0 2.0))
(define p2 (make-point 6.0 9.0))
(define myseg (make-segment p1 p2))
(start-segment myseg)
(end-segment myseg)
(car (end-segment myseg))
; final answer
(midpoint-segment myseg)