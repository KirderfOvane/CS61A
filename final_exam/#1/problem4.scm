#| Problem 4 (Trees).
Consider the following program:
(define (cost tree)
    (cost-help tree 0))

(define (cost-help tree above)
    (let ((new (+ (datum tree) above)))
        (make-node new
                    (map (lambda (child) (cost-help child new))
                         (children tree)))))

If cost is called with the following Tree as its argument, draw the Tree that it returns.
             3
            / \
           /   \
          2     1
         / \   / \
        1   0 5   3 |#



;new = 3
;child new = 3 + 2
;child2 1 + 5 = 6
;child3 1 + 6 = 7
;child4 0 + 7 = 7
;child5 5 + 7 = 12
;child6 3 + 12 = 15

         3
        / \
       /   \
      5     6
     / \   / \
    7   7 12  15