#| 
Exercise 2.49: Use segments->painter to define the following primitive painters:

The painter that draws the outline of the designated frame.
The painter that draws an “X” by connecting opposite corners of the frame.
The painter that draws a diamond shape by connecting the midpoints of the sides of the frame.
The wave painter. 
|#

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
(segments->painter (list (make-segment 0 0) (make-segment 0 1) (make-segment 1 1)))
