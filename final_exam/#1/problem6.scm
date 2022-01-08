#| Problem 6 (Object oriented programming).
Here is a definition in OOP language of the class line-obj from project 4: |#
(define-class (line-obj text)
    (method (next)
        (let ((result (car text)))
            (set! text (cdr text))
            result))
    (method (empty?) (null? text))
    (method (put-back token) (set! text (cons token text))) 
)

#| Write an equivalent program in ordinary Scheme without using the OOP language. Here
is an example of how your program will be used:
> (define logo-line (make-line-obj ’(print 3 print 4 print 5)))
okay
> (logo-line ’next)
print
> (logo-line ’next)
3
> (logo-line ’empty?)
#f
> ((logo-line ’put-back) ’hello) ;note double parentheses
okay
> (logo-line ’next)
hello
> (logo-line ’next)
print
Don’t check for errors. Here is the first line of the program, continue from here: |#

(define (make-line-obj text)
    (define next '() )
    (define (set-next text)
            (begin (set! next (car text))
                   (set! text (cdr text))
                   next
            )
    )
    (define (put-back el text)
        (set! text (append (list el) text))
    )
    (lambda (message) 
        (cond ((eq? message 'next ) (set-next text))
              ((eq? message 'empty? ) (null? text))
              ((eq? message 'put-back ) (lambda (el) (put-back el)))
              (else 'errormessage )
        )
    )
)