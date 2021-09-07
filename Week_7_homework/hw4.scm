#| 4. We want to promote politeness among our objects. 
Write a class miss-manners that takes an object as its instantiation argument. 
The new miss-manners object should accept only one message, namely please. 
The arguments to the please message should be, 
first, 
a message understood by the original object, 
and second, an argument to that message.

(Assume that all messages to the original object require exactly one additional argument.) 

Here is an example using the person class from the upcoming adventure
game project:
> (define BH (instantiate person ’Brian BH-office))
> (ask BH ’go ’down)
BRIAN MOVED FROM BH-OFFICE TO SODA
> (define fussy-BH (instantiate miss-manners BH))
> (ask fussy-BH ’go ’east)
ERROR: NO METHOD GO
> (ask fussy-BH ’please ’go ’east)
BRIAN MOVED FROM SODA TO PSL |#

;mine
(define-class (miss-manners name)
    (method (please instruction)
        ((lambda (action) (if (eq? action 'go ) 
                                  'go
                                  (error "NO METHOD " instruction) 
                              )
        ) instruction)
    )
    (default-method (error "NO METHOD " message))
)

;correct below:
(define-class (miss-manners object)
  (method (please message arg)
    (ask object message arg))
)