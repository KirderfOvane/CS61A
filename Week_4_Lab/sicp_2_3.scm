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

;rectangle
(define (make-rectangle width-seg height-seg)
    (cons
        (cons width-seg height-seg)
        (cons width-seg height-seg)
    )
)
;rectangle perimeter, works only on positive point coordinates
(define (rect-perimeter rectangle)
    (+
        (* 
            (- 
                (car (cdr (car (car rectangle)))) ;p2 x
                (car (car (car (car rectangle)))) ;p1 x
            )
            2
        )
        (*
            (- 
                (cdr (car (cdr (cdr rectangle)))) ;p3 y
                (cdr (cdr (cdr (cdr rectangle)))) ;p2 y
            )
            2
        )
    )
)
;rectangle area
(define (rect-area rectangle)
    (+
        (* 
            (- 
                (car (cdr (car (car rectangle)))) ;p2 x
                (car (car (car (car rectangle)))) ;p1 x
            )
            (- 
                (cdr (car (cdr (cdr rectangle)))) ;p3 y
                (cdr (cdr (cdr (cdr rectangle)))) ;p2 y
            )
        )
    )
)
;testing
(define p1 (make-point 1.0 6.0))
(define p2 (make-point 6.0 6.0))
(define p3 (make-point 6.0 3.0))
(define rect-width-seg (make-segment p1 p2))
(define rect-height-seg (make-segment p2 p3))
(define rectangle (make-rectangle rect-width-seg rect-height-seg))
(rect-perimeter rectangle) ;>16.0
(rect-area rectangle) ;>15.0