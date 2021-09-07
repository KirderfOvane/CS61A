#| Problem 3 (Tree recursion)
Write the function datum-filter which, given a predicate and a Tree, returns a list of
all the datums in the Tree that satisfy the predicate (in any order). We are using general
Trees (trees that can have any number of children) as defined in lecture. We are not using
binary trees. The function should return the empty list for any Tree in which no datums
satisfy the predicate. You may use helper procedures.
For example:
(datum-filter even?    ( 5 ) )
                        / \
                    ( 12 ) ( 19 )
                    / | \
                   /  |  \
             ( 4 ) ( 22 ) ( 27 )

returns the list (12 4 22) in any order. |#


(define make-tree list)
(define datum car)
(define children cdr)

(define (datum-filter pred tree)
    (define (iter pred tree filter)
        (if (null? tree)
            filter
            (if (list? (datum tree))
                (iter pred (datum tree) filter)
                (if (pred (datum tree))
                    (iter pred (children tree) (append (make-tree (datum tree)) filter))
                    (iter pred (children tree) filter)
                )
            )
        )
    )
    (iter pred tree '())
)


(datum-filter even? '((5 (12 4 22 27) 19)))