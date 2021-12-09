(define-class (line-object text)
	(method (put-back token)
		(set! text (append text (list token)))
		text)
	(method (remove)
		(if (null? text)
			(print "No more text to evaluate")
			(begin
			(set! text (cdr text))
			text))
	) 
    (method (empty?)
        (null? text)
    )
    ;NEXT:should return the next token waiting
	;to be read in the line, and remove
	;that token from the list.
    (method (next)
        (print text)
        (if (null? text)
            (print "there is nothing left to evaluate")
            (begin
			    (set! text (cdr text))
			    (if (null? text)
                    (print "there is nothing left to evaluate")
                    (car text)
                )
            )
        )
    )
)

;testing

#| (define text '(sum ( product 2 3 ) 4))
 (define line-obj (instantiate line-object text))  
 (ask line-obj 'empty? )
 (ask line-obj 'next )


 (ask line-obj 'put-back '(4) ) |#