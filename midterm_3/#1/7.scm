#| Problem 7 (Streams).

In weaving, a horizontal thread is pulled through a bunch of vertical threads. The hori-
zontal thread passes over some of the vertical ones, and under others. The choice of over
or under determines the pattern of the weave.

We will represent a pattern as a list of the words OVER and UNDER, repeated as needed.
Here’s an example:

(OVER OVER UNDER OVER UNDER UNDER)

The pattern may be of any length (it depends on the desired width of the woven cloth),
but it must contain at least one OVER and at least one UNDER.
Write a Scheme expression to compute the (infinite) stream of all possible patterns. |#




(define weave-pattern (cons-stream  
                        ((lambda (x y) 
                            (if (> (random 10) 5) 
                                (list x y)
                                (list y x)
                        ))
                        'OVER 'UNDER ) 
                        (stream-map append (lambda (x y) 
                            (if (> (random 10) 5) 
                            x y ))
                        'OVER 'UNDER )               
                      )
)



