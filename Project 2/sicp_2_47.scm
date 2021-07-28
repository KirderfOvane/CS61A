;Exercise 2.47: Here are two possible constructors for frames:

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

; For each constructor supply the appropriate selectors to produce an implementation for frames. 

;list-cons.
(define origin car)
(define edge1 cadr)
(define edge2 caddr)


;testing list-cons.
(define make-vect cons)
(define my-frame (make-frame (make-vect 0 0) (make-vect 3 4) (make-vect 4 5)))

;pair-cons.
(define origin car)
(define edge1 cadr)
(define edge2 cddr)

;testing pair-cons.
(define pair-frame (make-frame (make-vect 0 0) (make-vect 4 5) (make-vect 6 8)))