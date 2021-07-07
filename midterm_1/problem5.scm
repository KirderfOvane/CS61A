#| Problem 5 (Recursive procedures).

Write a function SYLLABLES that takes a word as argument and returns the number of syllables in the word. 
For our purposes, the number of syllables is equal to the number of vowels, except that consecutive vowels only count as one syllable:
> (syllables ’banana)
3

> (syllables ’aardvark)
2

> (syllables ’cloud)
1

(In real life there are additional complications, like Y being a vowel sometimes, and silent E s not adding a syllable, but ignore these problems.) 
Hint: You may find it useful to write a function that chops off consecutive vowels from the beginning of a word.
You may assume the following definition ofvowel?:

(define (vowel? letter)
    (member? letter ’(a e i o u)) |#

(define (syllables wd)
    (define iter wd counter)
    (
        (if (null? wd)
            counter
            (if (vowel? (first wd))
                (iter (bf wd) (+ counter 1))
                (iter (bf wd) counter 1)
            )
        )
    )
    (iter wd 0)
)