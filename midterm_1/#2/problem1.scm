#| Problem 1 (What will Scheme print?).What will Scheme print in response to the following expressions? 
If an expression produces an error message, you may just say “error”; 
you don’t have to provide the exact text of the message. 
If the value of an expression is a procedure, just say “procedure”; 
you don’t have to show the form in which Scheme prints procedures. |#


(every (bf x) '(ab cd ef gh))
;(b d f h)


(cond ('hello 5) (#t 6) (else 7))
;error

(let ((x 10)
        (y (+ x 2)) )
    (* y 3))

;error, let can't interact with eachother.
;if you do
(let* ((x 10)
        (y (+ x 2)) )
    (* y 3))
;they can.



#| What will Scheme print in response to the following expressions? If an expression produces an error message, you may just write “error”; 
you don’t have to provide the exact text of the message.
Also, draw a box and pointer diagram for the value produced by each expression. |#


(cons (list '() '(b)) (append '(c) '(d)))
((b) . (c d))
;(b ->) (c ->) (d /)


((lambda (x) (cons x x)) '(a))
(a . a)
;(a ->)(a /)


(cdar '((1 2) (3 4)))
(2)
;(2 /)