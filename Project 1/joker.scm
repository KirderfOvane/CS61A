#| 
A card is represented as a word, such as 10s for the ten of spades. 
(Ace, jack, queen, and king are a,j,q, and k.) 
Picture cards are worth 10 points, an ace is worth either 1 or 11 at the player’s option.  
|#

(define (twenty-one strategy)
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
    (cond ((> (best-total customer-hand-so-far) 21) -1) 
	  ((strategy customer-hand-so-far dealer-up-card)                      
	   (play-customer (se customer-hand-so-far (first rest-of-deck))	   
			  dealer-up-card
			  (bf rest-of-deck)))
	  (else
	   (play-dealer customer-hand-so-far
			(se dealer-up-card (first rest-of-deck))
			(bf rest-of-deck)))))

  (let ((deck (make-deck)))
    (play-customer (se (first deck) (first (bf deck))) 
		   (first (bf (bf deck))) 
		   (bf (bf (bf deck))))) ) 


(define (make-ordered-deck)
  (define (make-suit s)
    (every (lambda (rank) (word rank s)) '(A 2 3 4 5 6 7 8 9 10 J Q K)) )
  (define (make-jokers)
  	 (word 'xj ) )
  (se (make-suit 'H ) (make-suit 'S ) (make-suit 'D ) (make-suit 'C ) (make-jokers) (make-jokers) )  ; <-- added 2 jokers
)


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
  (shuffle (make-ordered-deck) 54) )  ; <-- added 2 cards


#| The strategy function should return a true or false output, which tells whether or not the customer wants another card.
(The true value can be represented in a program as #t, while false is represented as #f.) |#
;The customer’s hand is represented as a sentence in which each word is a card
;the dealer’s face-up card (dealer-up-card) is a single word (not a sentence).

  (define (strategy customer-hand-so-far dealer-up-card)
	(< (best-total customer-hand-so-far) 21)
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
					(+ 11 (total (bf sent))) 
					(if (equal? (bl (first sent)) 'x ); added check for joker card here. If found, set 11 and continue
						(+ 1 (total (bf sent)))
						(if (or (equal? (bl (first sent)) 'k ) (equal? (bl (first sent)) 'q ) (equal? (bl (first sent)) 'j )) 
							(+ 10 (total (bf sent))) 
							(+ (bl (first sent)) (total (bf sent)))
						)
					)
			)
		)
	)
	(define (ace-check sent points)
		(if (< points 21)
			points
			(ace-check-iter sent points)
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
	(define (joker-count sent counter) ; count jokers
		(if (equal? sent '())
			counter
			(if (equal? (bl (first sent)) 'x ) 
				(joker-count (bf sent) (+ counter 1))
				(joker-count (bf sent) counter)
			)
		)
	)
	(define (joker-adjust sent points count)
		(define (joker-adjust-iter sent points count)
			(if (or (equal? sent '()) (= count 0))
				points
				(if (and (= count 1) (> points 11)) 
					21 ; one joker and more than 11 points
					(if (and (= count 2)) 
						21   ; two jokers
						(+ points 10) ; one joker and less than 11 points
					)
				)
			)
		)
		(if (< points 21)
			(joker-adjust-iter sent points count)
			points
		)
	)
	(joker-adjust sent (ace-check sent (total sent)) (joker-count sent 0))
)
; testing
(best-total '(ad 8s)) ;> 19
(best-total '(ad kd)) ;> 21
(best-total '(ad kd qd jd 3s 5d 4h kh ad)) ;> 54
(best-total '(ad 8s kd)) ;> 19
(best-total '(ad 3s kd)) ;> 14
(best-total '(ad ad)) ;> 12
; joker testing
(best-total '(ad xj)) ;> 21
(best-total '(xj xj)) ;> 21
(best-total '(xj xj ad)) ;> 21  
(best-total '(xj xj ad 10s 9s 8s 7s)) ;> 37, bust  

; 2. Define a strategy procedure stop-at-17 that’s identical to the dealer’s, i.e., takes a card if and only if the total so far is less than 17.

(define (stop-at-17 customer-hand-so-far dealer-up-card)
	 (< (best-total customer-hand-so-far) 17)
)
; testing
(stop-at-17 '(ad 9s kd) '(ad 9s kd)) ;> #f
(stop-at-17 '(ad 3s kd) '(ad 3s kd)) ;> #t

#| 3. Write a procedure play-n such that (play-n strategy n)plays n games with a given strategy and returns the number of games that 
the customer won minus the number that s/he lost. 
Use this to exercise your strategy from problem 2,as well as strategies from the problems below. 
To make sure your strategies do what you think they do,trace them when possible.
Don’t forget: a “strategy” is a procedure! We’re asking you to write a procedure that takes another procedure as an argument. 
This comment is also relevant to parts 6 and 7 below. |#

(define (play-n strategy n)
	(if (<= n 0)
		0
		(+ (twenty-one strategy) (play-n strategy (- n 1)))
	)
)
;testing
(trace twenty-one)
(play-n stop-at-17 5)
#|
.. -> twenty-one with strategy = #[closure arglist=(customer-hand-so-far dealer-up-card) 7fdb8818]
.. <- twenty-one returns -1
.. -> twenty-one with strategy = #[closure arglist=(customer-hand-so-far dealer-up-card) 7fdb8818]
.. <- twenty-one returns 1
.. -> twenty-one with strategy = #[closure arglist=(customer-hand-so-far dealer-up-card) 7fdb8818]
.. <- twenty-one returns 1
.. -> twenty-one with strategy = #[closure arglist=(customer-hand-so-far dealer-up-card) 7fdb8818]
.. <- twenty-one returns -1
.. -> twenty-one with strategy = #[closure arglist=(customer-hand-so-far dealer-up-card) 7fdb8818]
.. <- twenty-one returns 0
0 
|#


#| 4. Define a strategy named dealer-sensitive that “hits” (takes a card) if (and only if) the dealer has an ace, 7, 8, 9, 10, or picture card showing, and the customer has less than 17, 
or the dealer has a 2, 3, 4, 5, or 6 showing, and the customer has less than 12. 
(The idea is that in the second case, the dealer is much more likely to “bust” (go over 21), since there are more 10-pointers than anything else.) |#

(define (dealer-sensitive customer-hand-so-far dealer-up-card)
	(define upper-bounds '(a k q j 7 8 9 10))
	(define lower-bounds '(2 3 4 5 6))
	
	(cond ((and (< (best-total customer-hand-so-far) 17) (contains? (first dealer-up-card) upper-bounds)) #t)
          ((and (< (best-total customer-hand-so-far) 12) (contains? (first dealer-up-card) lower-bounds)) #t)
          (else #f)
	)
)
; helper function
(define (contains? letter sentence-filter)
  		(member? letter sentence-filter))

;testing contains procedure : may not work after last refactor when they where defined internally inside dealer-sensitive.
;(contains? (first (word "ah")) upper-bounds) ;> #t
;(contains? (first (word "2h")) upper-bounds) ;> #f
;(contains? (first (word "ah")) lower-bounds) ;> #f
;(contains? (first (word "2h")) lower-bounds) ;> #t
;testing first condition : ace,7,8,9,10 picture card and customer hand less than 17.
(dealer-sensitive '(ad) (word "7h")) ;> #t
(dealer-sensitive '(kd) (word "ah")) ;> #t
;testing second condition : 2,3,4,5,6 and customer less than 12.
(dealer-sensitive '(9s) (word "2h")) ;> #t
(dealer-sensitive '(9s 2s) (word "6h")) ;> #t
;testing third condition
(dealer-sensitive '(9s 3s) (word "6h")) ;> #f
(dealer-sensitive '(9s 10s) (word "ah")) ;> #f


#| 5. Generalize part 2 above by defining a function stop-at. (stop-at n) should return a strategy that keeps hitting until a hand’s total is no r more. 
For example, (stop-at 17) is equivalent to the strategy in part 2. |#

(define (stop-at n customer-hand-so-far dealer-up-card)
	 (< (best-total customer-hand-so-far) n)
)

; testing , dealer-up-card is not used so input arg is just a placeholder.
(stop-at 17 '(ad 9s kd) (word "6h")) ;> #f
(stop-at 17 '(ad 3s kd) '(ad 3s kd)) ;> #t
(stop-at 12 '(ad 3s kd) '(ad 3s kd)) ;> #f
(stop-at 20 '(ad 8s kd) '(ad 8s kd)) ;> #t


#| 6. On Valentine’s Day, your local casino has a special deal: If you win a round of 21 with a heart in your hand, they pay double. 
You decide that if you have a heart in your hand, you should play more aggressively than usual. 
Write a valentine strategy that stops at 17 unless you have a heart in your hand, in which case it stops at 19. |#

(define (valentine customer-hand-so-far dealer-up-card)
	(if (equal? customer-hand-so-far '()) 
		(stop-at 17 customer-hand-so-far dealer-up-card)
		(if (equal? (last (first customer-hand-so-far)) 'h ) 
			(stop-at 19 customer-hand-so-far dealer-up-card)
			(valentine (bf customer-hand-so-far) dealer-up-card)
		)
	)
)

;testing
(valentine '(ad 8s) (word "ah")) ;> stop-at 17 #t
#| 
STk> (valentine '(ad 8s) (word "ah"))
.. -> stop-at with n = 17,  customer-hand-so-far = (),  dealer-up-card = ah
.. <- stop-at returns #t
#t 
|#
(valentine '(ah kd) (word "ah")) ;> stop-at 19 #f
#| 
STk> (valentine '(ah kd) (word "ah"))
.. -> stop-at with n = 19,  customer-hand-so-far = (ah kd),  dealer-up-card = ah
.. <- stop-at returns #f
#f 
|#
(valentine '(ad kd qd jd 3s 5d 4h kh ad) (word "ah")) ;> stop-at 19 #t
(valentine '(ad 8s kd) (word "ah")) ;> stop-at 17 #t
(valentine '(ad 3s kd) (word "ah")) ;> stop-at 17 #t
(valentine '(ad ad) (word "ah")) ;> stop-at 17 #t


#| 7. Generalize part 6 above by defining a function suit-strategy that takes three arguments: a suit (h,s,d, or c), a strategy to be used if your hand doesn’t include that suit,
and a strategy to be used if your hand does include that suit. 
It should return a strategy that behaves accordingly. 
Show how you could use this function and the stop-at function from part 5 to redefine the valentine strategy of part 6. |#

(define (suit-strategy suit strat-when-not-suit strat-when-suit customer-hand-so-far dealer-up-card)
	(if (equal? customer-hand-so-far '()) 
		strat-when-not-suit
		(if (equal? (last (first customer-hand-so-far)) suit ) 
			strat-when-suit
			(suit-strategy suit strat-when-not-suit strat-when-suit (bf customer-hand-so-far) dealer-up-card)
		)
	)
)
;testing
(suit-strategy 'h (stop-at 17 '(ad kd qd jd 3s 5d 4h kh ad) (word "ah")) (stop-at 19 '(ad 3s kd) '(ad 3s kd)) '(ad kd qd jd 3s 5d 4h kh ad) (word "ah")) ;>#t
(suit-strategy 'd (stop-at 17 '(ad kd qd jd 3s 5d 4h kh ad) (word "ah")) (stop-at 19 '(ad 3s kd) '(ad 3s kd)) '(ad kd qd jd 3s 5d 4h kh ad) (word "ah")) ;>#t

#| 8. Define a function majority that takes three strategies as arguments and produces a strategy as a result, 
such that the result strategy always decides whether or not to “hit” by consulting the three argument strategies, 
and going with the majority. That is, the result strategy should return #t if and only if at least two of the three argument strategies do. 
Using the three strategies from parts 2, 4, and 6 as argument strategies, play a few games using the “majority strategy” formed from these three. |#

(define (majority s1 s2 s3)
	(if (<= 1 (+
				(if s1 
					1
					0
				)
				(if s2 
					1
					0
				)
				(if s3
					1
					0
				)
			  )
		)
		#t
		#f
	)
)
;testing
(majority (stop-at 17 '(ad kd qd jd 3s 5d 4h kh ad) (word "ah")) (stop-at 17 '(ad kd qd jd 3s 5d 4h kh ad) (word "ah")) (stop-at 12 '(ad kd qd jd 3s 5d 4h kh ad) (word "ah"))) ;> 0 #f
(majority (stop-at 17 '(4h kh ad) (word "ah")) (stop-at 17 '(ad kd qd jd 3s 5d 4h kh ad) (word "ah")) (stop-at 12 '(ad kd qd jd 3s 5d 4h kh ad) (word "ah"))) ;> 1 #t
(majority (stop-at 17 '(4h kh ad) (word "ah")) (stop-at 17 '(ad kd qd jd 3s 5d 4h kh ad) (word "ah")) (stop-at 12 '(ad) (word "ah"))) ;> 2 #t

#| 9. Some people just can’t resist taking one more card. 
Write a procedure reckless that takes a strategy as its argument and returns another strategy. 
This new strategy should take one more card than the original would. 
(In other words, the new strategy should stand if the old strategy would stand on the butlast of the customer’s hand.) |#

;step 1: write normal function that returns value directly.
(define (reckless strat)	
	(define (iter strat num-of-cards)
		(if (equal? (strat (se (word num-of-cards 'h )) (word "a")) #f) 
			(stop-at (+ num-of-cards 1) (se (word num-of-cards 'h )) (word "a"))
			(iter strat (+ num-of-cards 1))
		)
	)
	(iter strat 0)
)

; testing: done with refactored iter (+ num-of-cards 1) to see actual num of cards below.
(define (iter strat num-of-cards)
	(if (equal? (strat (se (word num-of-cards 'h )) (word "a")) #f) 
		(+ num-of-cards 1); edit here for testing purposes
		(iter strat (+ num-of-cards 1))
	)
)
(reckless valentine) ;> 20
(reckless stop-at-17) ;> 18

;step 2: make reckless be returned as a function for twenty-one.
(define (one-more-card fn n)
	(lambda (x y) (fn n x y)
	
	)
)
;testing
((one-more-card stop-at 17) '(ad kd qd jd 3s 5d 4h kh ad) (word "ah"))


(define (reckless strat)
	(define (one-more-card fn n)
		(lambda (x y) (fn n x y)
	
		)
	)	
	(define (iter strat num-of-cards)
		(if (equal? (strat (se (word num-of-cards 'h )) (word "a")) #f) 
			(one-more-card stop-at (+ num-of-cards 1))
			(iter strat (+ num-of-cards 1))
		)
	)
	(iter strat 0)
)
; final function testing
(twenty-one (reckless valentine))
(twenty-one (reckless stop-at-17))
(twenty-one (reckless dealer-sensitive))


#| 10. Copy your Scheme file to a new file, 
named joker.scm, before you begin this problem.
We are going to change the rules by adding two jokers to the deck. 
A joker can be worth any number of points from 1 to 11. 
Modify whatever has to be modified to make this work. 
(The main point of this exercise is precisely for you to figure out which procedures must be modified.)  |#

;(load "joker.scm")

#| You will submit both this new file and the original, non-joker version for grading. 
You don’t have to worry about making strategies optimal just be sure nothing blows up and the hands are totalled correctly. |#