(load "3.scm")

;5. Define a procedure+rat to add two rational numbers, in the same style as*rat above.
(define (+rat a b)
    (make-rational (+ (numerator a) (numerator b))
                   (+ (denominator a) (denominator b)))
)

(print-rat (+rat (make-rational 2 3) (make-rational 1 4))) ;> "3/7"