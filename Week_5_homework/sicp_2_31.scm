;map/recursive implementation
(define (tree-map fn tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map fn sub-tree)
             (fn sub-tree)))
       tree))

(define (square x)
  (* x x)
)
(define (add x)
  (+ x x)
)

 (define (addition-tree tree) 
  (tree-map add tree))

(define (square-tree tree) 
  (tree-map square tree))

  (square-tree (list 1
      (list 2 (list 3 4) 5)
       (list 6 7)))
;(1 (4 (9 16) 25) (36 49))

(addition-tree (list 1
      (list 2 (list 3 4) 5)
       (list 6 7)))
;(2 (4 (6 8) 10) (12 14))