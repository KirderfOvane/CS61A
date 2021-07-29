#| 
Exercise 2.49: Use segments->painter to define the following primitive painters:

The painter that draws the outline of the designated frame.
The painter that draws an “X” by connecting opposite corners of the frame.
The painter that draws a diamond shape by connecting the midpoints of the sides of the frame.
The wave painter. 
|#
(define xcor-vect car)
(define ycor-vect cdr)
(define make-vect cons)
(define make-segment cons)
(define start-segment car)
(define end-segment cdr)

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line 
            ((frame-coord-map frame) (start-segment segment))
            ((frame-coord-map frame) 
            (end-segment segment))
       )
     )
     segment-list)
  )
)
;outline
(segments->painter (list (make-segment (make-vect 0 0) (make-vect 0 1) (make-vect 1 1) (make-vect 1 0))))
;X
(segments->painter (list (make-segment (make-vect 0 0) (make-vect 1 1)) 
                         (make-segment (make-vect 0 1) (make-vect 1 0))
                   ))
;diamond
(segments->painter (list (make-segment (make-vect 0.5 0) (make-vect 0.5 0.5)) 
                         (make-segment (make-vect 0.5 1) (make-vect 0.5 0.5)) 
                         (make-segment (make-vect 0 0.5) (make-vect 0.5 0.5))
                         (make-segment (make-vect 1 0.5) (make-vect 0.5 0.5))
                   ))
;wave first curve segment, rest is the same but diff. coords.
(segments->painter (list (make-segment (make-vect 0.45 0) (make-vect 0.4 0.2) (make-vect 0.45 0.3) (make-vect 0.4 0.25)
                         (make-vect 0.2 0.48) (make-vect 0 0.3)
                         ))

