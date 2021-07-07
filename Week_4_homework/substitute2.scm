#| 
Now write substitute2 that takes a list, a list of old words, and a list of new words; 
the last two lists should be the same length. It should return a copy of the first argument, 
but with each word that occurs in the second argument replaced by the corresponding word of the third argument:
> (substitute2 '((4 calling birds) (3 french hens) (2 turtledoves)) '(1 2 3 4) '(one two three four))
((four calling birds) (three french hens) (two turtle doves)) 
|#



(define (substitute2 li old-word-li new-word-li)
    (define (for-each proc lst old-word-li new-word-li)
                (if (null? lst)
                #t
                (let ((ignored-result (proc (car lst) old-word-li new-word-li)))
            (for-each proc (cdr lst) old-word-li new-word-li)))
    )
    

        (for-each 
            (lambda (x y z) 
                (if (list? x)
                            (find x y z) 
                             
                             
                            
                            
                )
                (newline)
                
                (display (find x y z))
            ) 
            li old-word-li new-word-li
        )
)

    (define (find char-li li new-word-li)
        (if (null? char-li)
            #f
            (if (member? (car char-li) li)
                (list (find-and-replace li new-word-li (car char-li)) 
                (find (cdr char-li) li new-word-li)
            )
        )
    )
    (define (find-and-replace old-word-li new-word-li w)
        (if (null? old-word-li)
            #f
            (if (equal? (car old-word-li) w)
                (car new-word-li)
                (find-and-replace (cdr old-word-li) (cdr new-word-li) w)
            )
        )
    )

;testing
(define t '(4 calling birds))
(substitute2 '((4 calling birds) (3 french hens) (2 turtledoves)) '(1 2 3 4) '(one two three four))


