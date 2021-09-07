#| Problem 3 (Project 2 data abstraction)
This question concerns the picture project. The midpoint of a segment is the point halfway
between its two ends. The midpoint of a frame is the point in that frame corresponding
to the point (0.5, 0.5) in the unit square:
We want a procedure named midpoint that takes either a segment or a frame as argument,
and returns the vector from the origin to the midpoint of the argument. We’ll accomplish
this in stages.
(a) Write new versions of the constructor make-segment and the selectors start-segment
and end-segment that include the word segment as a type tag in the internal representa-
tion.
(b) We’ll assume that the constructor and selectors for frames have been modified similarly
so that the word frame is included as a type tag in frames; you need not write these
procedures. Now write the procedure midpoint that takes either a segment or a frame
as its argument, and returns the vector from the origin to the midpoint of the argument.
Respect all relevant data abstractions. If the argument is neither a segment nor a
frame, your procedure should return #f. |#


;(a)

(define make-point cons)
(define Xcor car)
(define Ycor cdr)
(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (make-segment start-segment end-segment)
    (attach-tag 'segment (list start-segment end-segment))
)
(define type car)
(define content cdr)

(define start-segment cadr)
(define end-segment caddr)


(define test (make-segment (make-point 1 6) (make-point 2 13)) )

;(b)

(define (midpoint segment-or-frame)
    (if (eq? (type segment-or-frame) 'segment )
        (make-point 
            (/ 
                (+ (Xcor (start-segment segment-or-frame))
                   (Xcor (end-segment segment-or-frame))
                )
                2
            )
            (/ 
                (+ (Ycor (start-segment segment-or-frame))
                   (Ycor (end-segment segment-or-frame))
                )
                2
            )
        )
        (if (eq? (type segment-or-frame) 'frame )
            (cons 
                (/ (Xcor (content segment-or-frame)) 2)
                (/ (Ycor (content segment-or-frame)) 2)
            )
            #f
        )
    )
)


(midpoint test)

