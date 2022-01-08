#| Problem 1 (Higher order procedures).
Write a procedure ordinal that takes a nonnegative integer argument n. It should return
a procedure that takes a list as argument and returns the nth element of the list (counting
from one):
> (define third (ordinal 3))
> (third ’(John Paul George Ringo))
George
Hint: list-ref |#

(define (ordinal n)
    (lambda (li) (list-ref li (- n 1))
)