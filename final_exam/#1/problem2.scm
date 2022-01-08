#| Problem 2 (Iterative and recursive processes).
The following recursive procedure takes a list of integers and returns the number of elements
that are even.
(define (count-evens ints)
    (cond ((null? ints) 0)
          ((even? (car ints)) (+ 1 (count-evens (cdr ints))))
          (else (count-evens (cdr ints)))))

Rewrite this as an iterative procedure by filling in the blanks below. |#
(define (count-evens ints)
    (define (helper ints counter)
        (cond ((null? ints) counter)
              ((even?) (car ints) (helper (cdr ints) (+ counter 1)))
              (else (helper (cdr ints) counter))

        ))
    (helper ints 0))