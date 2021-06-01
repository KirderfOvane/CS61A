#| 2. Write a procedure substitute that takes three arguments:
 a sentence, an old word, and a new word. It should return a copy of the sentence,
  but with every occurrence of the old word replaced by the new word.
  For example:
> (substitute ’(she loves you yeah yeah yeah) ’yeah ’maybe)(she loves you maybe maybe maybe) |#

(define sent2 '(she loves you yeah yeah yeah))

(define (substitute sent oldword newword) 
    (if (empty? sent)
    '()
    (if (equal? (first sent) oldword) 
    (se newword (substitute (bf sent) oldword newword))
        (se (first sent) (substitute (bf sent) oldword newword))))
)