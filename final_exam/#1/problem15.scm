#| Problem 15 (Logic programming).
This is a question about logic programming. In it, as in some of the sample exams, we
represent nonnegative integers by lists containing the letter a repeatedly; for example,
(a a a) represents the number 3.
Don’t worry about your rule(s) working backward; only the last element of the
query will be an unbound variable. Don’t use lisp-value in your solution.
Write a logic program to find the depth of a list, equivalent to this Scheme procedure:
(define (depth lst)
    (if (not (pair? lst))
        0
        (max (+ 1 (depth (car lst)))
    (depth (cdr lst))))
)
Query input: (depth (a (b c (d) e) f) ?x)
Query result: (depth (a (b c (d) e) f) (a a a))
We provide the logic equivalent of pair? and max:
(assert! (rule (pair ?x) (same ?x (?p . ?q))))
(assert! (max () () ()))
(assert! (rule (max () (a . ?x) (a . ?x))))
(assert! (rule (max (a . ?x) () (a . ?x))))
(assert! (rule (max (a . ?x) (a . ?y) (a . ?z))
(max ?x ?y ?z)))
Here’s an example of how max is used:
Query input: (max (a a a a a) (a a a) ?x)
Query result: (max (a a a a a) (a a a) (a a a a a)) |#

(assert! (rule (depth ?lst)
        (and (not (pair? ?lst))
            (max ?list . ?x)
        )
    )
)
(depth (a (b c (d) e) f) ?x)