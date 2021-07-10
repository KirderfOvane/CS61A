#| 
Problem 6 (Data abstraction).
This two-part question is about an abstract data type called “sockdrawer,” representing adresser drawer full of socks.

(a) Suppose we represent the socks in the drawer as a list of names of colors, like (blue blue blue brown grey grey brown blue).  

You are given the selectors colors and how many:
(define (colors sockdrawer)
    (define (remdup seq)
        (cond ((null? seq) '())
              ((memq (car seq) (cdr seq)) (remdup (cdr seq)))
              (else (cons (car seq) (remdup (cdr seq)))) ))
    (remdup sockdrawer) 
)

(define (howmany color sockdrawer)
    (length (filter (lambda (sock) (eq? sock color)) sockdrawer)) )

> (colors '(blue blue blue brown grey grey brown blue))
(grey brown blue)

> (howmany 'blue '(blue blue blue brown grey grey brown blue))
4

Write the predicate odd-sock? that takes a sockdrawer as its argument, and returns #t if any color in the drawer has an odd number of socks. 
Respect the data abstraction.

(b) Now suppose we decide to change the internal representation of a sockdrawer from an unordered list of color names to a list of lists in this format:
((blue 4) (brown 2) (grey 2))

Rewrite the selectors colors and how many to reflect this new internal representation. 
|#

;(a)
(define (colors sockdrawer)
    (define (remdup seq)
        (cond ((null? seq) '())
              ((memq (car seq) (cdr seq)) (remdup (cdr seq)))
              (else (cons (car seq) (remdup (cdr seq)))) ))
    (remdup sockdrawer) 
)
(define (howmany color sockdrawer)
    (length (filter (lambda (sock) (eq? sock color)) sockdrawer)) )

(define (odd-sock? sockdrawer)
    (define colors-in-drawer (colors sockdrawer))
    (define (is-odd? unique-drawer-colors sockdrawer)
        (if (null? unique-drawer-colors)
            #f
            (if (odd? (howmany (car unique-drawer-colors) sockdrawer))
                #t
                (is-odd? (bf unique-drawer-colors) sockdrawer)
            )
        )
    )
    (is-odd? colors-in-drawer sockdrawer)
)
 
;testing/Proof
(odd-sock? '(blue blue blue brown grey grey brown blue))
(odd-sock? '(blue blue blue brown grey grey brown blue blue))

;(b)

(define (colors drawer)
  (if (null? drawer)
      '()
      (cons (caar drawer) (colors (cdr drawer))) 
  )
)

(define (howmany color drawer)
  (cond ((null? drawer) 0)
        ((eq? color (caar drawer)) (cadar drawer))
        (else (howmany color (cdr drawer))) 
  )
)
