3. We are going to use objects to represent decks of cards. You are given the list
ordered-deck containing 52 cards in standard order:
(define ordered-deck ’(AH 2H 3H ... QH KH AS 2S ... QC KC))
You are also given a function to shuffle the elements of a list:
(define (shuffle deck)
(if (null? deck)
    '()
(let ((card (nth (random (length deck)) deck)))
(cons card (shuffle (remove card deck))) )))
A deck object responds to two messages: deal and empty?. It responds to deal by
returning the top card of the deck, after removing that card from the deck; if the deck is
empty, it responds to deal by returning (). It responds to empty? by returning #t or #f,
according to whether all cards have been dealt.
Write a class definition for deck. When instantiated, a deck object should contain a shuffled
deck of 52 cards.


(define ordered-deck '(AH 2H 3H 4H 5H 6H 7H 8H 9H 10H JH QH KH AS 2S 3S 4S 5S 6S 7S 8S 9S 10S JS QS KS QC KC))

(define (shuffle deck)
    (if (null? deck)
        '()
        (let ((card (nth (random (length deck)) deck)))
            (cons card (shuffle (remove card deck))) )
    )
)

(define-class (deck)
    (instance-vars (cards (shuffle ordered-deck)) (dealed-card '()))
    (method (deal)
        (begin ((set! dealed-card (car cards)) (set! cards (cdr cards)) )
    )
)

;testing
(define testdeck (instantiate deck))
(ask testdeck 'cards )
(ask testdeck 'deal )