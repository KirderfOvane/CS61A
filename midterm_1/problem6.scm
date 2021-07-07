#| Problem 6 (Higher order functions).
For homework you wrote a procedure ordered?
that takes a sentence of numbers as its argument, 
returning#tif the numbers are in ascending order. 
You used the primitive predicate < to compare the first number with the second.
It’s possible to ask about the ordering of sentences of things other than numbers, 
providedwe have some way of asking whether one thing comes before another.
 For example, we can ask whether the words in a sentence are in alphabetical order, 
or whether the lengths of the words are in increasing order.

(Part a) Write a procedurein-order?that takes two arguments:
 first, a predicate functionof two arguments that returns
 #t
 if its first argument comes before its second
 second, a sentence. 
 Your procedure should return
 #t
 if the sentence is in increasing order according to the given predicate. 
 Examples:
 > (define (shorter? a b)
        (< (count a) (count b)) )

> (in-order? shorter? ’(i saw them standing together))
#t

>(in-order? shorter? ’(i saw her standing there))
#f

> (in-order? < ’(2 3 5 5 8 13))
#f

> (in-order? <= ’(2 3 5 5 8 13))
#t

> (in-order? > ’(23 14 7 5 2))
#t
|#


(define (in-order? pred-fn sent)
    (if (null? sent)
        #t
        (if (pred-fn (first sent) (bf (first sent)))
            (in-order? pred-fn (bf sent))
            #f
        )
    )
)


#| (Part b) Write a procedure order-checker that takes as its only argument a predicate function of two arguments. 
Your procedure should return a predicate function with one argument, a sentence
this returned procedure should return
#t 
if the sentence is in ascending order according to the predicate argument. 
For example:

> (define length-ordered? (order-checker shorter?))

> (length-ordered? ’(i saw them standing together))
#t

> (length-ordered? ’(i saw her standing there))'
#f

> ((order-checker <) ’(2 3 5 5 8 13))
#f

> ((order-checker <=) ’(2 3 5 5 8 13))
#t

> ((order-checker >) ’(23 14 7 5 2))
#t  |#

(define (order-checker fn)
    (lambda (x) (in-order? fn x))
)