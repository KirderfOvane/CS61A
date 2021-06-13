#| 
A card is represented as a word, such as 10s for the ten of spades. 
(Ace, jack, queen, and king are a,j,q, and k.) 
Picture cards are worth 10 points, an ace is worth either 1 or 11 at the player’s option.  
|#


;Invoking(twenty-one strategy) plays a game using the given strategy and a 
; randomly shuffled deck, and returns 1, 0, or −1 according to whether the customer won, tied, or lost.
(define (twenty-one strategy)
   ; Each player is dealt two cards, with one of the dealer’s cards face up. 
   ; The dealer always takes another card(“hits”) if he has 16 or less,and always stops (“stands”) with 17 or more.
  (define (play-dealer customer-hand dealer-hand-so-far rest-of-deck)
    (cond ((> (best-total dealer-hand-so-far) 21) 1)
	  ((< (best-total dealer-hand-so-far) 17)
	   (play-dealer customer-hand
			(se dealer-hand-so-far (first rest-of-deck))
			(bf rest-of-deck)))
	  ((< (best-total customer-hand) (best-total dealer-hand-so-far)) -1)
	  ((= (best-total customer-hand) (best-total dealer-hand-so-far)) 0)
	  (else 1)))

  (define (play-customer customer-hand-so-far dealer-up-card rest-of-deck)
    (cond ((> (best-total customer-hand-so-far) 21) -1) ;best-total konverterar ("5s" "4h") till siffror och jämför med 21. Om över 21 return -1, förlust. Om inte, kör strategy.
	  ((strategy customer-hand-so-far dealer-up-card)                      ;The customer’s hand is represented as a sentence in which each word is a card
	   (play-customer (se customer-hand-so-far (first rest-of-deck))	   ;the dealer’s face-up card (dealer-up-card) is a single word (not a sentence).
			  dealer-up-card
			  (bf rest-of-deck)))
	  (else
	   (play-dealer customer-hand-so-far
			(se dealer-up-card (first rest-of-deck))
			(bf rest-of-deck)))))

  (let ((deck (make-deck)));("5s" "4h" jc "4c" "8c" "9c" "5h" ks jh qh "6s" "8h" ad "7d" "10d" ah "6d" "6h" ac "7h" "2s" "4d" "3s" qd qc jd "2c" "8s" "3d" "3h" "4s" "3c" "7s" "8d" "9h" kd "10h" "10c" qs kh "2d" js "10s" "7c" kc "2h" "5d" "5c" "9s" "6c" "9d" as)
    (play-customer (se (first deck) (first (bf deck))) ; play/deal the first 2 cards in the deck to the customer -> ("5s" "4h")
		   (first (bf (bf deck))) ;third card in deck dealed as the up card.-> jc
		   (bf (bf (bf deck))))) ) ;rest of the deck -> "4c" "8c" "9c".....

; #####################################################################
(define (make-ordered-deck)
  (define (make-suit s)
    (every (lambda (rank) (word rank s)) '(A 2 3 4 5 6 7 8 9 10 J Q K)) )
  (se (make-suit 'H) (make-suit 'S) (make-suit 'D) (make-suit 'C)) ) 
  ;(ah "2h" "3h" "4h" "5h" "6h" "7h" "8h" "9h" "10h" jh qh kh 
  ; as "2s" "3s" "4s" "5s" "6s" "7s" "8s" "9s" "10s" js qs ks
  ; ad "2d" "3d" "4d" "5d" "6d" "7d" "8d" "9d" "10d" jd qd kd 
  ; ac "2c" "3c" "4c" "5c" "6c" "7c" "8c" "9c" "10c" jc qc kc)
  ;####################################################################

 ;we reshuffle the deck after each round, so strategies based on remembering which cards were dealt earlier are not possible.
(define (make-deck)
  (define (shuffle deck size)
    (define (move-card in out which)
      (if (= which 0)
	  (se (first in) (shuffle (se (bf in) out) (- size 1)))
	  (move-card (bf in) (se (first in) out) (- which 1)) ))
    (if (= size 0)
	deck
    	(move-card deck '() (random size)) ))
  (shuffle (make-ordered-deck) 52) )
; ("10d" "3s" "8s" "3c" "9s" kd ad "9c" ac qs kh "5h" ah as "6c" "7s" js 
; "4c" "2h" "7c" qh qc "10h" jc "5s" "10s" "10c" "4s" "2c" "7h" "7d" qd 
; "3d" "5c" jd "2d" "4d" "3h" "6s" "9d" "6h" "8c" "6d" kc "9h" "5d" "8d" 
;  jh "4h" ks "8h" "2s")


#| The strategy function should return a true or false output, which tells whether or not the customer wants another card.
(The true value can be represented in a program as #t, while false is represented as #f.) |#
;The customer’s hand is represented as a sentence in which each word is a card
;the dealer’s face-up card (dealer-up-card) is a single word (not a sentence).

  (define (strategy customer-hand-so-far dealer-up-card)
	()
  )

#| 
  For each of the steps below, you must provide a transcript indicating enough testing of 
  your procedure to convince the readers that you are really sure your procedure works. 
  These transcripts should include trace output where appropriate. 
|#


#| 1. The program in the library is incomplete. 
It lacks a procedure best-total that takes a hand (a sentence of card words) as argument, and returns the total number of points in the hand. 
It’s called best-total because if a hand contains aces, it may have several different totals. 
The procedure should return the largest possible total that’s less than or equal to 21, if possible. 
For example:
> (best-total '(ad 8s))    ; in this hand the ace counts as 11
19
> (best-total '(ad 8s 5h)) ; here it must count as 1 to avoid busting
14
> (best-total '(ad as 9h)) ; here one counts as 11 and the other as 1 21

Write best-total. |#

; working with ace ,picture cards ,regular cards and has a ace-checker.
(define (best-total sent)
	(define (total sent)
		(if (equal? sent '())
		0
		(if (equal? (bl (first sent)) 'a ) 
			(+ 11 (best-total (bf sent))) 
			(if (or (equal? (bl (first sent)) 'k ) (equal? (bl (first sent)) 'q ) (equal? (bl (first sent)) 'j )) 
				(+ 10 (best-total (bf sent))) 
				(+ (bl (first sent)) (best-total (bf sent)))
			)
		)
		)
	)
	(define (ace-check sent points)
		(if (< points 21)
			points
			(iter sent points)
		)
	)
	(define (ace-check-iter sent points)
		(if (equal? sent '())
			points
			(if (and (equal? (bl (first sent)) 'a ) (> points 21))
				(ace-check-iter (bf sent) (- points 10))
				(ace-check-iter (bf sent) points)
			)
		)
	)
	(ace-check sent (total sent))
)
; testing
(best-total '(ad 8s))
(best-total '(ad kd))
(best-total '(ad kd qd jd 3s 5d 4h kh ad))
(best-total '(ad 8s kd))
(best-total '(ad 3s kd))




; 2. Define a strategy procedure stop-at-17 that’s identical to the dealer’s, i.e., takes a card if and only if the total so far is less than 17.

(define (stop-at-17)
	()
)


#| 3. Write a procedure play-n such that (play-n strategy n)plays n games with a given strategy and returns the number of games that the customer won minus the number that s/he lost. 
Use this to exercise your strategy from problem 2,as well as strategies from the problems below. 
To make sure your strategies do what you think they do,trace them when possible.
Don’t forget: a “strategy” is a procedure! We’re asking you to write a procedure that takes another procedure as an argument. This comment is also relevant to parts 6 and 7 below. |#

(define (play-n strategy n)
	()
)


#| 4. Define a strategy named dealer-sensitive that “hits” (takes a card) if (and only if) the dealer has an ace, 7, 8, 9, 10, or picture card showing, and the customer has less than 17, 
or the dealer has a 2, 3, 4, 5, or 6 showing, and the customer has less than 12. 
(The idea is that in the second case, the dealer is much more likely to “bust” (go over 21), since there are more 10-pointers than anything else.) |#

(define (dealer-sensitive)
	()
)

#| 5. Generalize part 2 above by defining a function stop-at. (stop-at n) should return a strategy that keeps hitting until a hand’s total is no r more. 
For example, (stop-at 17) is equivalent to the strategy in part 2. |#

(define (stop-at n)
	()
)

#| 6. On Valentine’s Day, your local casino has a special deal: If you win a round of 21 with a heart in your hand, they pay double. 
You decide that if you have a heart in your hand, you should play more aggressively than usual. 
Write a valentine strategy that stops at 17 unless you have a heart in your hand, in which case it stops at 19. |#

(define (valentine hand)
	()
)

#| 7. Generalize part 6 above by defining a function suit-strategy that takes three arguments: a suit (h,s,d, orc), a strategy to be used if your hand doesn’t include that suit,
and a strategy to be used if your hand does include that suit. 
It should return a strategythat behaves accordingly. 
Show how you could use this function and the stop-at function from part 5 to redefine the valentine strategy of part 6. |#

(define (suit-strategy)
	()
)

#| 8. Define a function majority that takes three strategies as arguments and produces a strategy as a result, 
such that the result strategy always decides whether or not to “hit” by consulting the three argument strategies, 
and going with the majority. That is, the result strategy should return #t if and only if at least two of the three argument strategies do. 
Using the three strategies from parts 2, 4, and 6 as argument strategies, play a few games using the “majority strategy” formed from these three. |#

(define (majority s1 s2 s3)
	()
)

#| 9. Some people just can’t resist taking one more card. 
Write a procedure reckless that takes a strategy as its argument and returns another strategy. 
This new strategy should take one more card than the original would. 
(In other words, the new strategy should stand if the old strategy would stand on the butlast of the customer’s hand.) |#

(define (reckless strat)
	()
)

#| 10. Copy your Scheme file to a new file, 
named joker.scm, before you begin this problem.
We are going to change the rules by adding two jokers to the deck. 
A joker can be worth any number of points from 1 to 11. 
Modify whatever has to be modified to make this work. 
(The main point of this exercise is precisely for you to figure out which procedures must be modified.)  |#

(load "joker.scm")

#| You will submit both this new file and the original, non-joker version for grading. 
You don’t have to worry about making strategies optimal just be sure nothing blows up and the hands are totalled correctly. |#