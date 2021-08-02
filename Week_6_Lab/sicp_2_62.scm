;Exercise 2.62: Give a Θ ( n ) implementation of union-set for sets represented as ordered lists.

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))


(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))






; (1 2 3 4 5)
; (9 10 11)





(define (union-set oli newli)
    (let 
         (
            (org-new-li newli)
         )
         (define (larger-newli o-list new-li)
            (if (empty? new-li)
                #f
                (if (> (last o-list) (car new-li))
                    (larger-newli o-list (cdr new-li))
                    (append o-list new-li)
                )
            )
         )
         (define (smaller-newli o-list new-li)
            (if (empty? new-li)
                #f
                (if (< (last o-list) (car new-li))
                    (smaller-newli o-list (cdr new-li))
                    (append new-li o-list)
                )
            )
         )
        (define result (larger-newli oli newli))
        (if (equal? result #f)
            (smaller-newli oli org-new-li)
            result
        )    
        
    )
)


;testing
(define (make-listset num)
    (define (iter num set)
        (if (= num 0)
            set
            (iter (- num 1) (adjoin-set num set))
        )
    )
     (iter num '())
)

(union-set (list 1 2 3 4 5) (list 9 10 11))
(union-set (list 9 10 11) (list 1 2 3 4 5))
(union-set (list 9 10 11) (list 10 11 12 13 15))
(union-set  (list 10 11 12 13 15) (list 9 10 11))


