#| Problem 4 (Message passing)
Consider the following message-passing implementation of rational numbers:
(define (make-rat num den)
(define (dispatch msg)
(cond ((eq? msg ’numer) num)
((eq? msg ’denom) den)
(else (error "Unknown op -- MAKE-RAT" msg)) ))
dispatch)
Compare this with the complex number implementation on page 186 of the text. Suppose
we are given analogous procedures make-integer and make-real. You are going to modify
make-rat, and write some auxiliary procedures, to achieve three goals:
(a) In the conventional and data-directed styles of programming, we could take an arbitrary
number and find out what type it is, by using the type-tag function. This function would
return a symbol such as rational or complex to identify the type of its argument. In the
message-passing implementation, a number is no longer a pair whose car is the type name.
We want a type function that will allow us to find out the type of a message-passing-style
number.
(b) For homework you created a raise operation that could be applied to a number to
convert it to the next higher type in the tower of types. You did this in the context of
data-directed programming, using a table. We want to implement this raise operation in
message-passing style. In particular, we want to allow a rational number to be raised to
type real.
(c) Once we have the idea of raising numbers, it makes sense that we should be able to
ask the same questions about a given number that we could ask about higher types. For
example, we’d like
(real-part (make-rat 3 4)) =⇒ 0.75
(imag-part (make-rat 3 4)) =⇒ 0
But we don’t want to have to re-implement all the messages for real numbers and complex
numbers within make-rat. Instead, if make-rat doesn’t recognize a message, it should
raise the number and send the message to the raised number.
Rewrite make-rat to meet these three goals, and write the procedures type (for
goal a) and raise (for goal b). |#

;(a)
(define (make-rat num den)
    (lambda (msg)
            (cond ((eq? msg 'numer ) num)
                  ((eq? msg 'denom ) den)
                  ((eq? msg 'type ) 'rational )
                  (else (error "Unknown op -- MAKE-RAT" msg)) 
            )
    )
)
(define (operate op obj)
	(obj op)
)

(define test (make-rat 2 3))

(define (type shape)
	(operate 'type shape)
)
(type test);> rational

;(b)
(define (numer shape)
    (operate 'numer shape)
)
(define (denom shape)
    (operate 'denom shape)
)
(define (make-rat num den)
    (lambda (msg)
            (cond ((eq? msg 'numer ) num)
                  ((eq? msg 'denom ) den)
                  ((eq? msg 'type ) 'rational )
                  ((eq? msg 'raise ) (make-real (/ num den)) )
                  (else (error "Unknown op -- MAKE-RAT" msg)) 
            )
    )
)
(define (make-real num)
    (lambda (msg)
            (cond 
                  ((eq? msg 'type ) 'real )
                  ((eq? msg 'real-part ) num )
                  ((eq? msg 'imag-part ) 0 )
                  (else (error "Unknown op -- MAKE-REAL" msg)) 
            )
    )
)

(define (raise shape)
    (operate 'raise shape)
)

(define realtest (raise test))
(type realtest) ;> real

;(c)
(define (real-part shape)
    (operate 'real-part shape)
)
(define (imag-part shape)
    (operate 'imag-part shape)
)