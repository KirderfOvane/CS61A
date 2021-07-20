#| 
Exercise 2.27: Modify your reverse procedure of Exercise 2.18 to produce a deep-reverse procedure that takes a list as argument 
and returns as its value the list with its elements reversed and with all sublists deep-reversed as well. 

For example,  
|#


(define x (list (list 1 2) (list 3 4)))
x ;> ((1 2) (3 4))

(define (reverse li)
    (if (null? li)
        '()
         (list (car (cdr li)) (car li))
    )
)
(reverse x)
((3 4) (1 2))

(deep-reverse x)
((4 3) (2 1))

(define (reverse li) 
    (define (length items)
        (define (length-iter a count)
            (if (null? a)
                count
                (length-iter (cdr a) 
                            (+ 1 count))))
        (length-iter items 0)
    )
    (define (iter li list-length)
        (if (> 1 list-length)
            li
            (append (iter (cdr li) (- list-length 1)) (list (car li)))
        )
    )
    (iter li (length li))
)
(define (deep-reverse li)
    (if (null? (cdr li))
        (reverse (car li))
        (deep-reverse (cdr li))
    )
)
 (define (dr li)
    (print (car li))
    (if (null? li)
        li
        (dr (cdr li))
    )
)
;testing
(reverse (list 1 4 9 16 25))

 (define (length items)
        (define (length-iter a count)
            (if (null? a)
                count
                (length-iter (cdr a) 
                            (+ 1 count))))
        (length-iter items 0)
    )
(length '((3 4) (1 2)))
(reverse '((3 4) (1 2)))


#| 
below, process to reach result
(null? (cdr '((3 4) (1 2))))
(define l '((3 4) (1 2)))
(define large '((3 4) (1 2) (4 6) (6 9)))
(define deepli '((1 4 5) (1 (2 5)) (5 (5 4 (2 4 6)))) )
(define ls '(1 2 3 4))

(map car l)

(null? (cddr '((3 4) (1 2))))
(length (map cadr large))
(map print (map cadr deepli))
(map list? li)
(for-each (lambda (x) (print (car x))) (list (list 3 1) (list 2 3)))
(for-each (lambda (x) (print (list? (car x)))) large)
(for-each (lambda (li) 
            (if (list? li)
                li
                (append )
            )
          ) 
          l
)
(define (dr2 li)
    (for-each (lambda (lst) 
            (if (list? (car lst))
                (append (dr2 (car lst)))
                (append dr2 (car lst))
            )
          ) 
          li
    )
)
(define (dr3 li)
    (print "start list")
    (print li)
    (for-each (lambda (lst) 
            (print "new for-each for list:")
            (print lst)
            (if (pair? (cddr lst))
                (dr3 (cdr lst))
                (append (reverse lst))
            )
          ) 
          li
    )
)
(define (dr3 li)
    (print "start list")
    (print li)
    (let 
        (
            (my-list '())
        )
        (define (inner provided-list rev-li)
            (for-each (lambda (lst) 
                    (print rev-li)
                    (print "new for-each for list:")
                    (print lst)
                    (if (pair? (cddr lst))
                        (inner (cdr lst))
                        (cons (reverse lst) rev-li)
                    )
                ) 
                provided-list
            )
        )
        (inner li my-list)
        (print "end")
        (print my-list)
    )
)
(define (dr3 li)
    (let
        (
            (my-list '())
        )
    
        (for-each (lambda (lst)
                (if (null? lst)
                    (print lst)
                    (if (pair? (cddr lst))
                        (dr3 (cdr lst))
                        (print (cons (reverse lst) my-list))
                    )
                )
            ) 
            li
        )
        
    )
)
(map print deepli) 
(map reverse deepli)
|#

;below correct result. Solution was map and not for-each.

(define (dr li)
    (if (pair? li)
        (map dr (reverse li))
        li
    )
)
