#| 
Problem 4 (Recursive procedures).
Write a procedure every-nth that takes two arguments, a number n and a sentence.
 It should return the sentence formed by choosing every nth element of the sentence.  
 For example:
 
 > (every-nth 3 '(the rain in spain stays mainly on the plain))
 (in mainly plain)
 
 > (every-nth 2 '(in the town where i was born lived a man who sailed to sea))
 (the where was lived man sailed sea)

> (every-nth 4 '(you think you lost your love well i saw her yesterday))
(lost i)

Your procedure should work for sentences of any length. |#

(define (every-nth n sent)
        (define (iter n count sent new-sent)
                    (if (empty? sent)
                        new-sent
                        (if (= count 1)
                            (iter n n (bf sent) (se new-sent (first sent)))
                            (iter n (- count 1) (bf sent) new-sent)
                        )
                    )
        )
        (iter n n sent '()) 
)

(every-nth 3 '(the rain in spain stays mainly on the plain))