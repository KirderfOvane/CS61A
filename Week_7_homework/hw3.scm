#| 3. We are going to use objects to represent decks of cards. You are given the list
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
deck of 52 cards. |#


(define ordered-deck '(AH 2H 3H 4H 5H KC)) ;this should be 52 but for testing purpose i left it small.

(define (shuffle deck)
    (if (null? deck)
        '()
        (let ((card (nth (random (length deck)) deck)))
            (cons card (shuffle (remove card deck))) )
    )
)

(define-class (deck)
    (instance-vars (cards '()) (dealed-card '()))
    (initialize  (set! cards (shuffle ordered-deck)))
    (method (deal)
        (if (null? cards)
            '()
            (begin (set! dealed-card (car cards)) (set! cards (cdr cards)) dealed-card)
        )
    )
    (method (empty?)
        (null? cards)
    )
)

;testing
(define testdeck (instantiate deck))
(ask testdeck 'cards )
(ask testdeck 'deal )
(ask testdeck 'empty? );> #f
(ask testdeck 'deal )
(ask testdeck 'deal )
(ask testdeck 'deal )
(ask testdeck 'deal )
(ask testdeck 'deal )
(ask testdeck 'empty? );> #t