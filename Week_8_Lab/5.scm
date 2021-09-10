#| This lab activity consists of example programs for you to run in Scheme. Predict the result before you try
each example. If you don’t understand what Scheme actually does, ask for help! Don’t waste your time by
just typing this in without paying attention to the results. |#

(define (make-adder n)
    (lambda (x) (+ x n))
)
(make-adder 3);> x is not assigned, returns a procedure that will need x provided to it.
(define test (make-adder 3))
(test 5);> 8

((make-adder 3) 5);> body: (+ 5 3) -> 8



(define (f x) (make-adder 3)) 
(f 5) ;> returns a procedure, but x/5 is never used. instead it will need to be provided at invokation.

(define g (make-adder 3))
(g 5) ;same as first program


(define (make-funny-adder n)
    (lambda (x)
        (if (equal? x 'new )
            (set! n (+ n 1))
            (+ x n)
        )
    )
)

(define h (make-funny-adder 3)) ;> returns a procedure
(h 'new ) ;> executes body (+ 3 1) and sets n to 4. returns 'okay 
(h 5) ;> executes (+ 5 3) -> 8 , returns 8.


(let ((a 3)) ;> a is assigned 3
    (+ 5 a)) ;> (+ 5 3) -> 8


(let ((a 3))
    (lambda (x) (+ x a)) ;> returns procedure. provide x and u get a result when invoking.
)

((let ((a 3))
    (lambda (x) (+ x a))) 
    5
)

;> (+ 5 3) -> 8 returns 8.



(
    (lambda (x)
        (let ((a 3))
            (+ x a)
        )
    )
    5
)

;same as earlier procedures, just lambda x is assigned in outer frame and a is assigned in the inner frame.

(define k
    (let ((a 3))
        (lambda (x) (+ x a))
    )
)

(k 5)
;earlier procedure is bound to k. (k 5) assigns x 5


(define m
    (lambda (x)
        (let ((a 3))
            (+ x a)
        )
    )
)
(m 5) ; same result as above proc.

(define p
    (let ((a 3))
        (lambda (x)
            (if (equal? x 'new )
                (set! a (+ a 1))
                    (+ x a))
        )
    )
)
; a is assigned 3 on p def.
; body is a proc. as lambda(x). 
; invoking (p 5) assigns x 5 and then body is evaluated.
; the biggest difference is that a is persistent as it's in a outer separate frame/environment.
; and we can reach this frame from the inner (lambda (x))-frame.
(p 5)
(p 'new ) ;> every time we call new a is incremented by 1.
(p 5)
(p 5)



(define r
    (lambda (x)
        (let ((a 3))
            (if (equal? x 'new )
                (set! a (+ a 1))
                (+ x a)
            )
        )
    )
)
(r 5)
(r 5)
(r 5)
(r 'new )
(r 5)
; every call to r is creating a new procedure with a new environment with a as 3.
; therefor, a is not persistant


(define s 
    (let ((a 3))
        (lambda (msg)
            (cond ((equal? msg 'new ) 
                    (lambda ()
                        (set! a (+ a 1))))
                  ((equal? msg 'add )
                    (lambda (x) (+ x a)))
                  (else (error "huh?"))
            )
        )
    )
)
; s returns a procedure with a persistent state for a.
; invoking s with a msg executes cond which is a switch for methods.
; new increments the persistant a.
; add takes the value of a and adds the provided x-val to it and returns.
(s 'add );> missing x assignment
(s 'add 5);> tries to assign a second lambda val in the (lambda (msg))-environment. fails
((s 'add ) 5) ; returns procedure (+ x a) and then invokes it with 5 -> (+ 5 3) if a is 3.
(s 'new );> returns a procedure and sets and do not increment a with 1.
((s 'add ) 5) ;>8
((s 'new )) ;> increments a with 1
((s 'add) 5) ;> 9

(define (ask obj msg . args)
    (apply (obj msg) args))

;abstraction/refactor to simplify things
;instead of 
((s 'add) 5) ;> 9
;we can now do:
(ask s 'add 5)
(ask s 'new )
(ask s 'add 5)

