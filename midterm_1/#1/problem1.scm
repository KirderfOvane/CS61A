#| Problem 1 (What will Scheme print?).What will Scheme print in response to the following expressions? If an expression producesan error message, you may just say “error”
; you don’t have to provide the exact text of the message. 
If the value of an expression is a procedure, just say “procedure”; 
you don’thave to show the form in which Scheme prints procedures.
(every - (keep number? ’(the 1 after 909)))
;> (1 909)

((lambda (a b) ((if (< b a) + *) b a)) 4 6)
;> 24

(word (first ’(cat)) (butlast ’dog))
;> catdo

What will Scheme printin response to the following expressions?
If an expression produces an error message, you may just write “error”
 you don’t have to provide the exact text ofthe message.
 Also, draw a box and pointer diagram for the value produced by each expression.
 
 (cons (list 1 2) (cons 3 4))
 ;> ((1 2) . (3 . 4))
 
 (let ((p (list 4 5)))(cons (cdr p) (cddr p)) )
 ;> error
 
 (cadadr ’((a (b) c) (d (e) f) (g (h) i)) |#
 ;> error