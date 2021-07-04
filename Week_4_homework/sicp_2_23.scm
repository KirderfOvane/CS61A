#| Exercise 2.23: The procedure for-each is similar to map. It takes as arguments a procedure and a list of elements. However, 
rather than forming a list of the results, for-each just applies the procedure to each of the elements in turn, from left to right. 
The values returned by applying the procedure to the elements are not used at all—for-each is used with procedures that perform an action, 
such as printing. For example,

(for-each 
 (lambda (x) (newline) (display x))
 (list 57 321 88))

57
321
88

The value returned by the call to for-each (not illustrated above) can be something arbitrary, such as true. 
Give an implementation of for-each.  |#

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

(define (iter fn li new-li)
            (if (null? (cdr li))
                (reverse (cons (fn (car li)) new-li))
                (iter fn (cdr li) (cons (fn (car li)) new-li))        
            )     
)
(define (foreach fn li)    
    (iter fn li (list))
)

(define (square x) (* x x))


;testing
(foreach square (list 1 2 3)) ;> (1 4 9)
