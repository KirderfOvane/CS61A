#| Problem 4 (Tree recursion)
This question concerns Trees, using the constructor make-tree and the selectors datum
and children as discussed in lecture.
Suppose we are dealing with Trees in which the datum at every node is a number. Write a
procedure maxpath that takes such a Tree as its argument, and returns the largest possible
sum of numbers along a path from the root node to some leaf node. For example, in the
Tree
the largest such sum is 5 + 2 + 9, so the procedure should return 16.
Respect the data abstraction!
You may use, without defining it, the procedure biggest that takes a nonempty list of
numbers as its argument and returns the largest number in the list:
> (biggest ’(10 23 7 5))
23 |#

(define make-tree list)
(define datum car)
(define children cdr)


;(make-tree 5 (make-tree 7 1 3) (make-tree 2 9 (make-tree 5 3 1)))
;(5 (7 1 3) (2 9 (5 3 1)))

(define (traverse tree)
    (if (list? (datum tree))
        (accumulate + (datum tree) (traverse (children tree)))
        (traverse (cdr tree))
    )
)
(biggest (map traverse (make-tree 5 (make-tree 7 1 3) (make-tree 2 9 (make-tree 5 3 1)))))

(define t (make-tree 5 (make-tree 7 1 3) (make-tree 2 9 (make-tree 5 3 1))))