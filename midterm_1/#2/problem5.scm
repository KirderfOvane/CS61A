#| Problem 5 (Higher order procedures).
Here are two procedure definitions with examples of their use:

(define (differences sent)
    (if (empty? (bf sent))
        '()
        (se (- (first sent) (first (bf sent)))
            (differences (bf sent)))))

> (differences '(86 42 15 9))
(44 27 6)

> (differences '(10 20 5))
(-10 15)

(define (wordpairs sent)
    (if (empty? (bf sent))
        '()
        (se (word (first sent) (first (bf sent)))
            (wordpairs (bf sent)))))

> (wordpairs '(now here after math))
(nowhere hereafter aftermath)

> (wordpairs '(fat her mit e rupt ure))
(father hermit mite erupt rupture)


Write a procedure pairmap that generalizes the pattern followed by these two examples.

⇒ Then rewrite differences and wordpairs using your pairmap. |#

(define (pairmap fn sent)
    (if (empty? (bf sent))
        '()
        (se (fn (first sent) (first (bf sent)))
            (pairmap fn (bf sent)))))

(define differences (lambda (sent) (pairmap - sent)))
(define wordpairs (lambda (sent) (pairmap word sent)))

