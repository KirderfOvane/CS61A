Problem 1 (What will Scheme print?)
What will Scheme print in response to the following expressions? If an expression produces
an error message, you may just write “error”; you don’t have to provide the exact text of
the message. Also, draw a box and pointer diagram for the value produced by
each expression.
(list (cons 2 3) 4)  ;> ((2 . 3) 4)
(append (cons ’(a) ’(b)) ’(c)) ;> (a b c)
(cdadar ’((e (f) g) h)) ;>  (e (f) g) , ((f) g) , (f) , () -> answer ()

