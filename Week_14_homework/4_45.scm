#| Exercise 4.45: With the grammar given above, the following sentence can be parsed in five different ways:
 “The professor lectures to the student in the class with the cat.” 
Give the five parses and explain the differences in shades of meaning among them.  |#


;Grammar
(define nouns 
  '(noun student professor cat class))

(define verbs 
  '(verb studies lectures eats sleeps))

(define articles '(article the a))

(define prepositions 
  '(prep for to in by with))


;Parsers
 (define (parse-sentence)
  (list 'sentence
         (parse-noun-phrase)
         (parse-verb-phrase)))

(define (parse-verb-phrase)
  (define (maybe-extend verb-phrase)
    (amb 
     verb-phrase
     (maybe-extend 
      (list 'verb-phrase
            verb-phrase
            (parse-prepositional-phrase)))))
  (maybe-extend (parse-word verbs)))

(define (parse-simple-noun-phrase)
  (list 'simple-noun-phrase
        (parse-word articles)
        (parse-word nouns)))

(define (parse-noun-phrase)
  (define (maybe-extend noun-phrase)
    (amb 
     noun-phrase
     (maybe-extend 
      (list 'noun-phrase
            noun-phrase
            (parse-prepositional-phrase)))))
  (maybe-extend (parse-simple-noun-phrase)))

(define (parse-prepositional-phrase)
  (list 'prep-phrase
        (parse-word prepositions)
        (parse-noun-phrase)))

(define (parse-word word-list)
  (require (not (null? *unparsed*))) ;unparse must not be empty
  (require (memq (car *unparsed*)  ;unparse must not be the same as cdr of word list
                 (cdr word-list)))
  (let ((found-word (car *unparsed*))) ;set found-word to first item
    (set! *unparsed* (cdr *unparsed*)) ;remove first item from list
    (list (car word-list) found-word))) ;put found word at the end of word-list

;Initialization
(define *unparsed* '())
(define (parse input)
  (set! *unparsed* input)
  (let ((sent (parse-sentence)))
    (require (null? *unparsed*))
    sent))






;;; Amb-Eval input:
;(parse '(the professor lectures to the student in the class with the cat))



;Below the 5 different parses

#| 
(sentence 
    (simple-noun-phrase (article the) (noun professor)) ;same
    (verb-phrase (verb-phrase (verb-phrase (verb lectures) 
    (prep-phrase (prep to) (simple-noun-phrase (article the) (noun student)))) 
    (prep-phrase (prep in) (simple-noun-phrase (article the) (noun class)))) 
    (prep-phrase (prep with) (simple-noun-phrase (article the) (noun cat))))
)

(sentence 
    (simple-noun-phrase (article the) (noun professor)) ;same
    (verb-phrase (verb-phrase (verb lectures) 
    (prep-phrase (prep to) 
    (simple-noun-phrase (article the) (noun student)))) 
    (prep-phrase (prep in) (noun-phrase (simple-noun-phrase (article the) (noun class)) 
    (prep-phrase (prep with) (simple-noun-phrase (article the) (noun cat))))))
)

(sentence 
    (simple-noun-phrase (article the) (noun professor)) ;same
    (verb-phrase (verb-phrase (verb lectures) (prep-phrase (prep to) 
    (noun-phrase (simple-noun-phrase (article the) (noun student)) 
    (prep-phrase (prep in) (simple-noun-phrase (article the) (noun class)))))) 
    (prep-phrase (prep with) (simple-noun-phrase (article the) (noun cat))))
)

(sentence 
    (simple-noun-phrase (article the) (noun professor)) ;same
    (verb-phrase (verb lectures) (prep-phrase (prep to) 
    (noun-phrase (noun-phrase (simple-noun-phrase (article the) (noun student)) 
    (prep-phrase (prep in) (simple-noun-phrase (article the) (noun class)))) 
    (prep-phrase (prep with) (simple-noun-phrase (article the) (noun cat))))))
)

(sentence 
    (simple-noun-phrase (article the) (noun professor)) ;same
    (verb-phrase 
        (verb lectures) 
        (prep-phrase 
            (prep to) 
            (noun-phrase 
                (simple-noun-phrase (article the) (noun student)) ;<- diff
                (prep-phrase 
                    (prep in) 
                    (noun-phrase (simple-noun-phrase (article the) (noun class)) 
                        (prep-phrase (prep with) (simple-noun-phrase (article the) (noun cat)))
                    )
                )
            )
        )
    )
) |#