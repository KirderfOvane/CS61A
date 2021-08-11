#| 2. This exercise introduces you to the usual procedure described on page 9 of “Object-oriented Programming
– Above-the-line View”. Read about usual there to prepare for lab.
Suppose that we want to define a class called double-talker to represent people that always say things
twice, for example as in the following dialog.
> (define mike (instantiate double-talker ’mike))
mike
> (ask mike ’say ’(hello))
(hello hello)
> (ask mike ’say ’(the sky is falling))
(the sky is falling the sky is falling)
Consider the following three definitions for the double-talker class. (They can be found online in the file
~cs61a/lib/double-talker.scm.)
(define-class (double-talker name)
(parent (person name))
(method (say stuff) (se (usual ’say stuff) (ask self ’repeat))) )
(define-class (double-talker name)
(parent (person name))
(method (say stuff) (se stuff stuff)) )
(define-class (double-talker name)
(parent (person name))
(method (say stuff) (usual ’say (se stuff stuff))) )
Determine which of these definitions work as intended. Determine also for which messages the three versions
would respond differently. |#

(define-class (person name)
  (class-vars (last-message '()))
  (method (say stuff)
    (set! last-message stuff) 
    (ask self 'last-message )
  )
  (method (ask stuff) 
    (set! last-message (ask self 'say (se '(would you please) stuff)))
    (ask self 'last-message )
  )
  (method (greet)
    (set! last-message (ask self 'say (se '(hello my name is) name))) 
    (ask self 'last-message )
        
  ) 
  (method (repeat) (ask self 'last-message ))  
)

; do not work with my implementation of repeat. This method only works under applicative order, as 'repeat have to be evaluated
; after the first sentence or it may be some different value.
(define-class (double-talker name)
  (parent (person name))
  (method (say stuff) (se (usual 'say stuff) (ask self 'repeat )))) 


;works , double-talkers say method is used so parent methods like repeat won't work as last-message is never !set.
(define-class (double-talker name)
  (parent (person name))
  (method (say stuff) (se stuff stuff)))


; this will always work ,but parent class 'say method is used.
(define-class (double-talker name)
  (parent (person name))
  (method (say stuff) (usual 'say (se stuff stuff))))