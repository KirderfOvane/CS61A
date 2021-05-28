#| 3.Write a procedure switch that takes a sentence as its argument and returns a sentence in which every instance of the words I or me is replaced by you, 
while every instance of you is replaced by me except at the beginning of the sentence, where it’s replaced by I.
(Don’t worry about capitalization of letters.) 

Example:
> (switch '(You told me that I should wake you up))
(i told you that you should wake me up) |#



; My solution:

; recursion
(define (hw x)
        (cond ((or (equal? (first x) 'me) (equal? (first x) 'i)) (se 'you (basecase (bf x))))
              ((equal? (first x) 'you) (se 'me (basecase (bf x))))
              ( (se (first x)(basecase (bf x))) ))
    ))

; base case 
(define (basecase x)
(if (not (equal? x '()))
    (hw x)
    x))

 ; check for you in sentence start then call the recursive function
(define (switch sent)
(if (and (equal? (first sent) 'you))
    (se 'I (basecase (bf sent)))
    (se (first sent) (basecase (bf sent)))
    ))

; test sentence
(define sent '(You told me that i should wake you up))