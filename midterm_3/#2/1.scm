#| Problem 1 (box and pointer).

What will the Scheme interpreter print in response to the last expression in each of the
following sequences of expressions? Also, draw a “box and pointer” diagram for the result
of each printed expression. If any expression results in an error, circle the expression
that gives the error message. Hint: It’ll be a lot easier if you draw the box and pointer
diagram first! |#
(let ((x (list 1 2 3)))
(set-cdr! (car x) 4) ; error. set-cdr! need a list or pair to operate on, (car x) => 1 ,so error.
x)

(let ((x (list 1 2 3))) ; (1 2 3)
(set-cdr! x 4) ; (1 . 4)
x) ; (1 . 4)                         ->| 1 | - | --->| 4 | / |

(let ((x (list 1 2 3))) ; (1 2 3)
(set-car! (cdr x) x) ; (1 (1 2 3)), error: it points to itself => infinite loop error.
x)  ;                                   ->| 1 | - |---> points to the 1 again.

(define a ((lambda (z) (cons z z)) (list 'a ))) ; ((a) . (a))
(set-cdr! (car a) '(b)) ; ((a b) . (a))
a ; ->| : | - | -> | : | / |
;       :            :
;       :            > | a | / |
;       :
;       > | a | -> | b | / |