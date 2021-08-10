#| 
Exercise 2.83: Suppose you are designing a generic arithmetic system for dealing with the tower of types shown in 
Figure 2.25: integer, rational, real, complex. For each type (except complex), 
design a procedure that raises objects of that type one level in the tower. 
Show how to install a generic raise operation that will work for each type (except complex). |#


;datatype structure:
;integer, level 1, raise-int
;rational, level 2, raise-rat
; real, level 3, raise-real
; complex , level 4, raise-complex


;first, we need additional tags to our object:
 (define (tag x) (attach-tag 'rational x))
 (define (level-tag x) (attach-tag '1 x))
 
;second, put raise-proc into table
 (put 'int-to-rational (lambda (x) (tag (cons x 1)))) 
 (put 'rational-to-real (lambda (x) (tag (/ (car x) (cdr x))))) 
 (put 'real-to-complex (lambda (x) (tag (+ x 0)))) 
 
; generic apply proc
(define (raise-proc x) 
    ((lambda (fn) (fn x)) (get (cadr x)))
)
(define (level x) (car x))

; main raise procedure, adjusts level with raise-procedures until level is equal.
(define (raise type1 type2)
    (if (= (level type1) (level type2))
        (print "same level")
        (if (> (level type1) (level type2))
            (raise type1 (raise-proc type2))
            (raise (raise-proc type1) type2)
        )
    )  
)


;required helper procedures

(define attach-tag cons)
(define type-tag car)
(define contents cdr)