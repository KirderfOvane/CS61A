#| Suppose we want to write a procedure prev that takes as its argument a procedure proc
of one argument. Prev returns a new procedure that returns the value returned by the
previous call to proc. The new procedure should return #f the first time it is called. For
example:

> (define slow-square (prev square))

> (slow-square 3)

#f

> (slow-square 4)

9

> (slow-square 5)

16

Which of the following definitions implements prev correctly? Pick only one.
______ (define (prev proc)
        (let ((old-result #f))
            (lambda (x)
(let ((return-value old-result))
(set! old-result (proc x))
return-value)))) |#

______ (define prev ; <--- correct implementation!
        (let (
                (old-result #f)
             )
             (lambda (proc)
                (lambda (x)
                (let ((return-value old-result))
                (set! old-result (proc x))
                return-value))
             )
        )
       )

#| ______ (define (prev proc)
(lambda (x)
(let ((old-result #f))
(let ((return-value old-result))
(set! old-result (proc x))
return-value))))

______ (define (prev)
(let ((old-result #f))
(lambda (proc)
(lambda (x)
(let ((return-value old-result))
(set! old-result (proc x))
return-value))))) |#