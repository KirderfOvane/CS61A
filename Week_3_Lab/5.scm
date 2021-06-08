#| 5. We really don’t want to have to use type-check explicitly every time. 
Instead, we’d like to be able to use a safe-sqrt procedure:

> (safe-sqrt ’hello)
#f
> (safe-sqrt 4)
2

Don’t write safe-sqrt! Instead, write a procedure make-safe that you can use this way:
> (define safe-sqrt (make-safe sqrt number?))

It should take two arguments, a function and a type-checking predicate,
 and return a new function that returns #f if its argument doesn’t satisfy the predicate. |#


 (define (make-safe FN type-to-check) 
 (lambda (x) (if (type-to-check x)
 (FN x)
 #f)))


(define safe-sqrt (make-safe sqrt number?))

(safe-sqrt 4)
(safe-sqrt 'hello)
