(define (double value) (* 2 value))

(define (apply-twice fn value) (fn (fn value)))

