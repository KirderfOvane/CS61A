#| 
Problem 1 (What will Scheme print?)
What will Scheme print in response to the following expressions? If an expression produces
an error message, you may just write “error”; you don’t have to provide the exact text of
the message. Also, draw a box and pointer diagram for the value produced by
each expression. 
|#

(map caddr '((2 3 5) (7 11 13) (17 19))) ;> 19
;-> | 2 3 5 | ->| |7 11 13| -> |17 19|->|
(list (cons 2 (cons 3 5))) ;> ((2 . (3 . 5)))
;-> |(2 . (3 . 5)) | ->|
;    -> | 2 | ->| | 3 | ->| | 5 | ->|
(append (list '(2) '(3)) (cons '(4) '(5))) ;> ( (2) (3) ( (4) . (5) ) )
;-> |((2) (3) ((4) . (5))) | ->|
;   -> |(2) |->| |(3)| ->| |(4)| ->| |(5)| ->|
(list (cons '(0) '(1)) (append '(2) '(3)));> ( ((0) . (1)) (2 3))
; -> |()|->|
     ;->| ((0))|-> | | 2| ->| |3| ->|
      ;  ->| 1| ->|



      




(append (list '(2) '(3)) (cons '(4) '(5))) 
     (append '((2) (3)) '((4) 5))
          ((2) (3) (4) 5)


(list (cons '(0) '(1)) (append '(2) '(3)))
   (((0) . 1) (2 3))