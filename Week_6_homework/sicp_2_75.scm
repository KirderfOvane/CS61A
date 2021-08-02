#| Exercise 2.75: Implement the constructor make-from-mag-ang in message-passing style. 
This procedure should be analogous to the make-from-real-imag procedure given above.  |#

(define (make-from-mag-ang r a)
	(lambda (message)
		(cond ((eq? message 'real-part ) (* r (cos a)))
			  ((eq? message 'imag-part ) (* r (sin a)))
              ((eq? message 'magnitude ) r)
              ((eq? message 'angle ) r )
			  (else (error "Unknown message"))
		)
	)
)



