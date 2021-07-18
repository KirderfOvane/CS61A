;This library contains common sequence operators

;map -> param -> operation -> data / list
(map (lambda (i) (print i)) '(1 2 3))


;enumurate
(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low 
            (enumerate-interval 
             (+ low 1) 
             high)))
)
;(enumerate-interval 1 5)


;accumulate
(define (accumulate fn init li)
  (if (null? li)
      init
      (fn (car li) (accumulate fn init (cdr li)))
  )
)
;(accumulate + 0 (list 1 2 3))


;accumulate list of lists
(define (accumulate-n fn init li)
  (if (null? (car li))
      '()
      (cons
          (accumulate fn init (map car li))
          (accumulate-n fn init (map cdr li))
      )
  )
)
;(accumulate-n + 0 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))


;fold-left
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest)) (cdr rest))
    )
  )
  (iter initial sequence)
)


;fold-right
(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence) (fold-right op initial (cdr sequence)))
  )
)


;traverse a tree.
(define (tree-map fn tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map fn sub-tree)
             (fn sub-tree)))
       tree))


;filter by boolean/predicate-function.
(define (filter predicate sequence)
  (cond ((null? sequence) '())
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate 
                       (cdr sequence))))
        (else  (filter predicate 
                       (cdr sequence)))
  )
)
;(filter odd? (list 1 2 3 4 5 6 7 8 9))


;loop trough ,combine and then flatten.
(define (flatmap proc seq)
  (accumulate append '() (map proc seq))
)

  (flatmap       
    (lambda (i)
      (map (lambda (j) 
                (list i j))
                (enumerate-interval 1 (- i 1))
      )
    ) 
    (list 1 2 3 4 5)
  )

;remove one item from a list/sequence
(define (remove item sequence)
  (filter (lambda (x) (not (= x item)))
          sequence)
)
;(remove 3 (list 1 2 3 4))


;does list x contain item(string) 
(define (memq item x)
  (cond ((null? x) #f)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

;(memq 'apple '(banana apple orange))