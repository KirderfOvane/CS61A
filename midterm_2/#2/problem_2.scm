Problem 2 (Backwards what-will-Scheme-print.)
Fill in the blank in this expression:
( ’(G (H I) J))
so that the value of the expression is the letter I.

; ((car (cdr (car (cdr x))))) -> (cadadr '(G (H I) J))