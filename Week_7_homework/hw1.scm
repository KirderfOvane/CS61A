#| 1. For a statistical project you need to compute lots of random numbers in various ranges.
(Recall that (random 10) returns a random number between 0 and 9.) Also, you need
to keep track of how many random numbers are computed in each range. You decide to
use object-oriented programming. Objects of the class random-generator will accept two
messages. The message number means “give me a random number in your range” while
count means “how many number requests have you had?” The class has an instantiation
argument that specifies the range of random numbers for this object, so
(define r10 (instantiate random-generator 10))
will create an object such that (ask r10 ’number) will return a random number between
0 and 9, while (ask r10 ’count) will return the number of random numbers r10 has
created. |#

(define-class (random-generator range)
    (instance-vars (number (random range)))
    (class-vars (count 0))
    (initialize (set! count (+ count 1)))
)

;testing
(define r1110 (instantiate random-generator 10))
(define r25 (instantiate random-generator 10))
(ask random-generator 'count ) ;> 2
(define r255 (instantiate random-generator 10))
(define r256 (instantiate random-generator 10))
(ask random-generator 'count ) ;> 4