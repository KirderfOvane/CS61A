#| Problem 1 (What will Scheme print?)
What will Scheme print in response to the following expressions? If an expression produces
an error message, you may just write “error”; you don’t have to provide the exact text of
the message. Also, draw a box and pointer diagram for the value produced by
each expression. |#
(append (list ’a ’b) ’(c d))   ; (a b c d)
(cons (list ’a ’b) (cons ’c ’d)) ; ((a b) (c . d))
(list (list ’a ’b) (append ’(c) ’(d))); ((a b) (c d))
(cdar ’((1 2) (3 4))); (2)