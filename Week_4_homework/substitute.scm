#| 
Write a procedure substitute that takes three arguments: a list, an old word, and a new word. 
It should return a copy of the list, but with every occurrence of the old word replaced by the new word, even in sublists. 
For example:
> (substitute '((lead guitar) (bass guitar) (rhythm guitar) drums) 'guitar 'axe)
((lead axe) (bass axe) (rhythm axe) drums) 
|#



(define (substitute li old-word new-word)
    (define (for-each proc lst old-word new-word)
                (if (null? lst)
                #t
                (let ((ignored-result (proc (car lst) old-word new-word)))
            (for-each proc (cdr lst) old-word new-word)))
    )
        (for-each 
            (lambda (x y z) 
                (display (if (list? x)
                            (if (equal? (list y) (cdr x))
                                (list (car x) z)
                                x
                            )
                            x
                        )
                )
                            
            ) 
            li old-word new-word
        )
)

;testing
(substitute '((lead guitar) (bass guitar) (rhythm guitar) drums) 'guitar 'axe ) ;> ((lead axe) (bass axe) (rhythm axe) drums) 
(substitute '((lead guitar) (bass guitar) (rhythm guitar) (rhythm piano) drums) 'guitar 'axe ) ;>((lead axe) (bass axe) (rhythm axe) (rhythm piano) drums)



