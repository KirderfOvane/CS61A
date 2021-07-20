#| 
4. Each person individually make up a procedure named mystery that, 
given two lists as arguments, returns the result of applying exactly two of cons,append, or list to mystery’s arguments, 
using no quoted values or other procedure calls. 
Here are some examples of what is and is not fair game
:okay                               not okay
(define (mystery L1 L2)            (define (mystery L1 L2)
    (cons L1 (append L2 L1)))          (cons L1 (cons L2 (cons L1 L2))))

(define (mystery L1 L2)            (define (mystery L1 L2)
    (list L1 (list L1 L1)))            (cons L1 L2))

(define (mystery L1 L2)            (define (mystery L1 L2)
    (append (cons L2 L2) L1))          (append L1 (cons L1 ’(A B C))))

Type your mystery definition into a file, and have one of your partners load it into Scheme and try to guess what it is by trying it out with various arguments.
After everyone has tried someone else’s procedure, 
decide with your partners which procedure was hardest to guess and why, and what test cases were most and least helpful in revealing the definitions. 
|#
(define (mystery L1 L2) ;ok
    (cons L1 (append L2 L1))) ;> ((1 2) 3 4 1 2)

(define (mystery L1 L2)  ; not okay
    (cons L1 (cons L2 (cons L1 L2)))) ;> ((1 2) (3 4) (1 2) 3 4)

(define (mystery L1 L2) ;ok
    (list L1 (list L1 L1))) ;> ((1 2) ((1 2) (1 2)))

(define (mystery L1 L2) ;not okay
        (cons L1 L2) ;> ((1 2) 3 4)
)

(define (mystery L1 L2)  ; ok          
    (append (cons L2 L2) L1)) ;> ((3 4) 3 4 1 2)

(define (mystery L1 L2) ;not okay
    (append L1 (cons L1 '(A B C)))) ;> (1 2 (1 2) a b c)

;exec
;(mystery (list 1 2) (list 3 4))    
; the ones with cons is harder to guess, append and cons makes the brackets hard to predict.