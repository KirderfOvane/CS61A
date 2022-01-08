Problem 11 (Streams).
Given the following input, how will the Scheme interpreter respond? Fill in the blanks in
the transcript below.
(Assume the definition of show-stream used in the lectures, which displays the first few
elements of a stream.)
> (define (spew x) (cons-stream x (spew x))) ;one value in a constant stream (x (x (x (x (x (x))))))
spew
> (define garply (cons-stream 1 (stream-map + (spew 1) garply))) 
garply
> (show-stream garply 10)
;(1,2,3,4,5,6,7,8,9,10)
> (define strange (cons-stream ’() (stream-map cons garply strange)))
strange
> (show-stream strange 5)
;( () (1) (2 1) (3 2 1) (4 3 2 1) (5 4 3 2 1) )