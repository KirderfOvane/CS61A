#| 
Exercise 2.20: The procedures +, *, and list take arbitrary numbers of arguments. One way to define such procedures is to use define with dotted-tail notation. 
In a procedure definition, a parameter list that has a dot before the last parameter name indicates that, when the procedure is called, 
the initial parameters (if any) will have as values the initial arguments, as usual, but the final parameter’s value will be a list of any remaining arguments. 
For instance, given the definition

(define (f x y . z) ⟨body⟩)

the procedure f can be called with two or more arguments. If we evaluate

(f 1 2 3 4 5 6)

then in the body of f, x will be 1, y will be 2, and z will be the list (3 4 5 6). Given the definition

(define (g . w) ⟨body⟩)

the procedure g can be called with zero or more arguments. If we evaluate

(g 1 2 3 4 5 6)

then in the body of g, w will be the list (1 2 3 4 5 6).77

Use this notation to write a procedure same-parity that takes one or more integers and returns a list of all the arguments 
that have the same even-odd parity as the first argument. For example,

(same-parity 1 2 3 4 5 6 7)
(1 3 5 7)

(same-parity 2 3 4 5 6 7)
(2 4 6) 
|#

;helper procedure
(define (reverse li) 
    (define (length items)
        (define (length-iter a count)
            (if (null? a)
                count
                (length-iter (cdr a) 
                            (+ 1 count))))
        (length-iter items 0)
    )
    (define (iter li list-length)
        (if (> 1 list-length)
            li
            (append (iter (cdr li) (- list-length 1)) (list (car li)))
        )
    )
    (iter li (length li))
)
(define (iter x y i li)
      (if (null? y)
          li
          (if (= (+ 2 i) (car y))
              (iter x (cdr y) (+ 2 i) (append (list (car y)) li))
              (iter x (cdr y) i li)
          )
      )
)
(define (same-parity x . y)
  (if (null? y)
      x
      (reverse (iter x y x (list x)))
  )
)

;testing
(same-parity 1 2 3 4 5 6 7)
(same-parity 1)
(same-parity 2 3 4 5 6 7)

 