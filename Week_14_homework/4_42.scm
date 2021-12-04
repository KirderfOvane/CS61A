#| Exercise 4.42: Solve the following “Liars” puzzle (from Phillips 1934):

Five schoolgirls sat for an examination. Their parents—so they thought—showed an undue degree of interest in the result. 
They therefore agreed that, in writing home about the examination, each girl should make one true statement and one untrue one. 
The following are the relevant passages from their letters:

    Betty: “Kitty was second in the examination. I was only third.”
    Ethel: “You’ll be glad to hear that I was on top. Joan was second.”
    Joan: “I was third, and poor old Ethel was bottom.”
    Kitty: “I came out second. Mary was only fourth.”
    Mary: “I was fourth. Top place was taken by Betty.” 

What in fact was the order in which the five girls were placed?  |#

(load "ambeval.scm")

;run (mce)

(define (one-need-to-be-true x y)
    (if (eq? x #t)
        (if (eq? y #t) 
            #f
            #t
        )
        (if (eq? y #t)
            #t
            #f
        )
    )
)

(define (distinct? li)
    (define (iter li new-li)
        (if (null? li)
            new-li
            (if (member? (car li) (cdr li))
                    (iter (cdr li) new-li)
                    (iter (cdr li) (append new-li (list (car li))))
            )
        )
    )
     (iter li '())
)

(define (member? x li)
    (if (null? li)
        #f
        (if (eq? x (car li))
            #t
            (member? x (cdr li))
        )
    )
)


(define examination-result 
    ;Five schoolgirls
    ;each girl should make one true statement and one untrue one
    (let
        (
            (betty (amb 1 2 3 4 5))
            (ethel (amb 1 2 3 4 5))
            (joan (amb 1 2 3 4 5))
            (kitty (amb 1 2 3 4 5))
            (mary (amb 1 2 3 4 5))
        )
         ;only one occurance per choice path
        (require (distinct? (list betty ethel joan kitty mary)))

        ;Betty: “Kitty was second in the examination. I was only third.”
        (require (one-need-to-be-true (= kitty 2) (= betty 3)))
        ;Ethel: “You’ll be glad to hear that I was on top. Joan was second.”
        (require (one-need-to-be-true (= ethel 5) (= joan 2)))
        ;Joan: “I was third, and poor old Ethel was bottom.”
        (require (one-need-to-be-true (= joan 3) (= ethel 1)))
        ;Kitty: “I came out second. Mary was only fourth.”
        (require (one-need-to-be-true (= kitty 2) (= mary 4)))
        ;Mary: “I was fourth. Top place was taken by Betty.” 
        (require (one-need-to-be-true (= mary 4) (= betty 5)))


        (list (list 'betty betty)
                (list 'ethel ethel)
                (list 'joan joan)
                (list 'kitty kitty)
                (list 'mary mary))
    )
)



;testing
;(define kitty 2)
;(define betty 2)

;(one-need-to-be-true (= kitty 2) (= betty 3))



;(examination-result)--> ((betty 3) (ethel 1) (joan 2) (kitty 1) (mary 4))