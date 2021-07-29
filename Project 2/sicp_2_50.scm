#| 
Exercise 2.50: Define the transformation flip-horiz, which flips painters horizontally, 
and transformations that rotate painters counterclockwise by 180 degrees and 270 degrees.  |#

(define (flip-horiz painter)
  (let ((flipped-painter (transform-painter  ;flip horizontal
                                painter
                                (make-vect 1.0 0.0)   ; new origin
                                (make-vect 0.0 0.0)   ; new end of edge1
                                (make-vect 1.0 1.0)   ; new end of edge2
                         )
       ))
    (
        (transform-painter flipped-painter ;rotate 180
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 0.0)
        )
    )
  )
)


