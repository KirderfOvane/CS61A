;direct implementation
(define (square-tree tree)
  (cond ((null? tree) 0)
        ((not (pair? tree)) 
         (square tree))
        (else
         (cons (square-tree (car tree))
               (square-tree (cdr tree) 
                           ))))
)
(define (square x)
  (* x x)
)

(square-tree
 (list 1
      (list 2 (list 3 4) 5)
       (list 6 7)))
;(1 (4 (9 16) 25) (36 49))

;map/recursive implementation
(define (square-tree tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree sub-tree)
             (* sub-tree sub-tree)))
       tree))

(define (square x)
  (* x x)
)

(square-tree
 (list 1
      (list 2 (list 3 4) 5)
       (list 6 7)))
;(1 (4 (9 16) 25) (36 49))