#| 
 6.Most versions of Lisp provide and and or procedures like the ones on page 19. 
  In principle there is no reason why these can’t be ordinary procedures, 
  but some versions of Lisp make them special forms. Suppose, for example, 
  we evaluate (or (= x 0) (= y 0) (= z 0)) If or is an ordinary procedure, 
  all three argument expressions will be evaluated before or is invoked.
  But if the variable x has the value 0, we know that the entire expression has to be true regardless of the values of y and z. 
  A Lisp interpreter in which or is a special form can evaluate the arguments one by one 
  until either a true one is found or it runs out of arguments.

  Your mission is to devise a test that will tell you whether Scheme’s and and or are special forms or ordinary functions. 
  This is a somewhat tricky problem, 
  but it’ll get you thinking about the evaluation process more deeply than you otherwise might.

  Why might it be advantageous for an interpreter to treat or as a special form and evaluate its arguments one at a time? 
  Can you think of reasons why it might be advantageous to treat or as an ordinary function? 
|#

; Try 1: In an ordinary function, if an argument is not able to be evaluated the function fails. We have not gone through try-catch in scheme so i suppose
; we can't check if an function fails without crash, yet. 

;## EDIT ##: I misunderstood this question in that the test should be able to test special form or ordinary function at runtime.
; Try 1 was the correct answer. If or fails because y is undefined, it means that or is evaluating the arguments before or-procedure is run and therefore it's an ordinary function.
; If however below is able to run and find x is true and exit without error, then it's a special form function.
(define x 0)
(define z 1)
(or (= x 0) (= y 0) (= z 0))
; It exits with #t so in scheme or is an special form function.


; Try 2: an argument expression calls an external ordinary function
(define x 1)
(define z 1)

(define yEval '(notempty))
(define kindOfProcedure
(or (= x 0) (empty? yEval) (= z 0)))
; if you run above you get #f

; if you then redefine yEval it should be defined to #t. But it isn't.
(define yEval '())

; this only detects changes in yEval if kindOfProcedure is redefined. Hint that yEval only gets evaluated at define/precompile and not at runtime.
; this means that scheme makes or a special form on define. 
; Like Try 1 however, we can't make this test at runtime, only manual. 
; The advantage with special form is that it is faster, it can exit earlier.
; The advantage with ordinary function is that it is easier to read.

