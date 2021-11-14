#| Problem 2 (Assignment, State, and Environments).

In this problem you’re going to write a piece of a simplified Adventure game, not using our
OOP notation, just in regular Scheme. We are concentrating on the behavior of people,
so a place will just be represented as a room number. You are given a function next-room
that takes as arguments a room number and a direction; its result is the room where you
end up if you move in the given direction from the given room:

==> (next-room 14 ’South)

9

means that room 9 is south of room 14. You are to write a procedure make-player that
creates a player object. This object (i.e., a procedure) should accept messages like South
and should move from its current position in the indicated direction. It should remember
the new location as local state, and should also return the new location as its result. The
argument to make-player is the initial room:
==> (define Frodo (make-player 14))

FRODO

==> (Frodo ’South)

9

==> (Frodo ’South)

26

You must make each move relative to the result of the previous move, not starting from
the initial room each time! |#


(define (make-player initial-room)
        (let
            (
                (position initial-room)
            )
            (lambda (m)
                (if (member? m '(south north east west) )
                    (begin
                        (set! position (next-room position m ))
                        position
                    )
                    (print "no valid direction provided")
                )
            )
        )
)

;testing
(define (next-room room dir)
    (random 30)
)
