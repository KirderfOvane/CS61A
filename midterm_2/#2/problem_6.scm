#| Problem 6 (Data directed programming)
This two-part question is about data-directed programming. We are going to use a list to
represent a finite state machine (FSM) like this:
The numbered circles represent the states of the machine. At any moment the machine is
in a particular state. The machine reads words, one letter at a time. If the machine is in
some state, and sees a certain letter, it follows the arrow from its state with that letter as
its label, and ends up in a new state. For example, if the machine above is in state 1 and
it sees the letter B, it goes into state 3.
We’ll represent a FSM by a list of all its transition arrows. The machine above has six
such arrows:
((1 A 2) (1 B 3) (1 C 4) (2 A 1) (3 B 1) (4 C 1))
If the machine reads a letter for which there is no applicable arrow, it should enter state
number 0. In effect, there are “invisible” arrows like (2 C 0) that needn’t be represented
explicitly in the list.
(a) Write a function transition that takes three arguments: a FSM list, a current state
number, and a letter. The function should return the new state. For example, if fsm
represents the list above, we should be able to do this:
> (transition fsm 1 ’C) > (transition fsm 2 ’C)
4 0
(b) We want an FSM to process words, not just single letters. The machine “reads” the
word one letter at a time. Our sample FSM, starting in state 1, should process the word
AACCAAB by going through states 2, 1, 4, 1, 2, 1, and 3. The final state, 3, is the result
of processing the word.
Write a function process that takes as its arguments a FSM, a starting state number, and
a word. It should return the ending state:
> (process fsm 1 ’AACCAAB) > (process fsm 1 ’AAAC)
3 0 |#

;(a)
(define state car)
(define letter-label cadr)
(define transition-state cddr)
(define arrow car)

(define (transition fsm current-state letter)
    (if (null? fsm)
        0
        (if (= current-state (arrow (state fsm)))
            (if (eq? (arrow (letter-label fsm)) letter)
                (arrow (transition-state fsm))
                (transition (arrow (cdr fsm)) current-state letter)
            )
            (transition (cdr fsm) current-state letter)
        )
    )
)
(transition fsm 1 'C )

;(b)
(define (process fsm start-state word)
    (if (empty? word)
        start-state
        (process fsm (transition fsm start-state (first word)) (butfirst word))
    )
)