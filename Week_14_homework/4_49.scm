#| Exercise 4.49: Alyssa P. Hacker is more interested in generating interesting sentences than in parsing them. 
She reasons that by simply changing the procedure parse-word so that it ignores 
the “input sentence” and instead always succeeds and generates an appropriate word, 
we can use the programs we had built for parsing to do generation instead. 
Implement Alyssa’s idea, and show the first half-dozen or so sentences generated. |#
(load "ambeval.scm")
(mce)
; open 4_45.scm and define code into amb-eval console:  

(define (parse-word word-list)
  (require (not (null? *unparsed*))) ;unparse must not be empty
  (let ((found-word (car *unparsed*))) ;set found-word to first item
    (set! *unparsed* (cdr *unparsed*)) ;remove first item from list
    (list (car word-list) found-word))) ;put found word at the end of word-list

    ;(parse '(the professor lectures to the student in the class with the cat))
    ;(parse-word '(the professor lectures to the student))

;I've failed here, below is correct solution

(define (parse-word word-list)
  (define (iter words)
    (if (null? words)
	(amb)
	(amb (car words) (iter (cdr words)))))
  (list (car word-list) (iter (cdr word-list))))