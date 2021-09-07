#| 
Problem 2 (Tree recursion)
(a) Using the binary tree abstract data type as defined on page 115 of the text (with
selectors entry, left-branch, and right-branch and constructor make-tree), write the
predicate all-smaller? that takes two arguments, a binary tree of numbers and a single
number, and returns #t if every number in the tree is smaller than the second argument.
Examples:
> (define my-tree (make-tree 8 (make-tree 5 ’() ’())
(make-tree 12 ’() ’())))
> (all-smaller? my-tree 15)
#T
> (all-smaller? my-tree 10)
#F

(b) Using all-smaller? and, if you wish, a similar all-larger? (which you don’t have
to write), write a predicate bst? that takes a binary tree of numbers as its argument,
returning #t if and only if the tree is a binary search tree. (That is, your procedure should
return true only if, at every node, all of the numbers in that node’s left branch are smaller
than the entry at the node, and all of the numbers in the node’s right branch are larger
than the entry.) 
|#

;(a)
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))




(define (all-smaller? tree num)
        (if (list? tree)
            (if (> (entry tree) num)
                #f
               (all-smaller? (right-branch tree) num)
            )
            (if (> tree num)
                #f
                #t
            )
        )
)
(define (all-larger? tree num)
        (if (list? tree)
            (if (< (entry tree) num)
                #f
               (all-larger? (left-branch tree) num)
            )
            (if (< tree num)
                #f
                #t
            )
        )
)

;testing
(define testtree (make-tree 5 '() '())) ;>(5 () ())
(define testtree2 (make-tree 5 (make-tree 3 1 2) (make-tree 7 6 8))) ;>(5 (3 1 2) (7 6 8))
(define bst-tree (make-tree 5 (make-tree 3 1 4) (make-tree 7 6 8))) ;>(5 (3 1 4) (7 6 8))

(all-smaller? testtree2 6)
(all-smaller? testtree2 5)
(all-smaller? testtree2 9)
(all-larger? testtree2 9)
(all-larger? testtree2 1)
(all-larger? testtree2 2)


;(b)
(define (bst? tree)
    (if (list? tree)
        (and (all-smaller? (left-branch tree) (entry tree))
             (all-larger? (right-branch tree) (entry tree))
             (bst? (left-branch tree)) 
             (bst? (right-branch tree))   
        )
        #t    
    )  
)

(bst? testtree2) ;> #f
(bst? bst-tree) ;> #t


  


