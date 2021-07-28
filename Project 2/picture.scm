#| 
A painter draws an image that is shifted and scaled to fit 
within a designated parallelogram-shaped frame.  
|#

;there’s a primitive painter we’ll call WAVE that makes a crude line drawing
; The actual shape of the drawing depends on the frame

;The primitive painter called ROGERS paints a picture of MIT’s founder, William Barton Rogers

;To combine images, we use various operations that construct new painters from given painters
#| For example, the BESIDE operation takes two painters and produces a new, 
compound painter that draws the first painter’s image in the left half of 
the frame and the second painter’s image in the right half of the frame |#
#|  Similarly, BELOW takes two painters and produces a compound painter that 
 draws the first painter’s image below the second painter’s image. |#


 #| Some operations transform a single painter to produce a new painter |#
 #| For example, 
 FLIP-VERT takes a painter and produces a painter that draws its image upside-down, 
 FLIP-HORIZ produces a painter that draws the original painter’s image left-to-right reversed. |#


 ;Abstract constructs based on above procedures

 ;step 1
 (define wave2 (beside wave (flip-vert wave)))

 ;step 2
 (define wave4 (below wave2 wave2))

 ; why this works is because all procedures is closed procedures. it returns a complete painter.
 ; like geometry modifiers in 3ds max

 ; we can abstract the pattern in wave4 even more as:

 (define (flipped-pairs painter)
  (let ((painter2 
         (beside painter 
                 (flip-vert painter))))
    (below painter2 painter2)))

; and define wave4 as an instance of this pattern:

(define wave4 (flipped-pairs wave))


#| 
We can also define recursive operations. 
Here’s one that makes painters split and branch towards the right |#

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1)))) ;let-var
           (beside painter (below smaller smaller)) ;body
      )
  )
)

#| We can produce balanced patterns by branching upwards as well as towards the right |#
(define (corner-split painter n)
  (if (= n 0)
      painter
      (let (
            (up (up-split painter (- n 1))) ;let-var
            (right (right-split painter (- n 1))) ;let-var
           )
        (let (
              (top-left (beside up up))  ;let-var
              (bottom-right (below right right)) ;let-var
              (corner (corner-split painter (- n 1))) ;let-var
             )
          (beside (below painter top-left) (below bottom-right corner)) ;body
        )
      )
  )
)

;up-split procedure from exec 2.44:
(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1)))) ;let-var
           (below painter (beside smaller smaller)) ;body
      )
  )
)

; higher order function abstraction

;takes 4 procedures as arguments and returns an compound function with one argument input, the painter to use it on.
(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let (
          (top (beside (tl painter) (tr painter))) ;let-var
          (bottom (beside (bl painter) (br painter))) ;let-var
         )
          (below bottom top) ;body
    )
  )
)

; to use above abstraction we save it to a var flipped-pairs:
(define (flipped-pairs painter)
  (let (
        (combine4 (square-of-four identity flip-vert identity flip-vert)) ;let-var
       )
    (combine4 painter) ;body
  )
)

;square-limit using square of four
(define (square-limit painter n)
  (let (
            (combine4 (square-of-four flip-horiz identity rotate180 flip-vert))  ;let-var
       )
            (combine4 (corner-split painter n)) ;body
  )
)

; generic split procedure from exercise 2_45:
(define right-split (split beside below))
(define up-split (split below beside))


(define (split fn1 fn2)
  (lambda (painter)
    (let (
          (fn1-result-painter (fn1 painter painter)) ;let-var
         )
          (fn2 fn1-result-painter painter) ;body
    )
  )
)

; Frames
; frame consists of three vectors.
; an origin vector and 2 edge vectors.
; the origin vector values describe it's relative position to origo in the world.
; if the edges are perpendicular ,the frame will be rectangular, else it will be a parallelogram.

#| there is a constructor make-frame, which takes three vectors and produces a frame, 
and three corresponding selectors origin-frame, edge1-frame, and edge2-frame  |#

; With each frame we associate the images with a frame coordinate map which will 
; be used to shift and scale images to fit the frame.
; coordinates will be (x,y) with range 0-1.
; the mapping formula is:
; Origin(frame) + x * Edge1(frame) + y * Edge2(frame)

; frame coordinate map creator procedure:
(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
        (origin-frame frame)
        (add-vect 
            (scale-vect (xcor-vect v) (edge1-frame frame))
            (scale-vect (ycor-vect v) (edge2-frame frame))
        )
    )
  )
)

;frame constructor
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

;frame selectors
(define origin car)
(define edge1 cadr)
(define edge2 caddr)

;vectors
(define xcor-vect car)
(define ycor-vect cdr)
(define make-vect cons)
(define (add-vect v1 v2)
    (make-vect 
        (+ (xcor-vect v1) (xcor-vect v2))
        (+ (ycor-vect v1) (ycor-vect v2))
    )
)

;draw-line: draws a line on the screen between two specified points, a segment.

;painter takes a frame as argument and draws a particular image shifted and scaled to fit the
;frame

;with draw-line we can then render with painter using lists of line segments.

;create painter using a segment-list
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

#| 
The segments are given using coordinates with respect to the unit square. For each segment in the list, 
the painter transforms the segment endpoints with the frame coordinate map and 
draws a line between the transformed points.  
|#

#| Any procedure can serve as a painter, provided that it takes a frame as argument and draws something scaled to fit the frame. |#