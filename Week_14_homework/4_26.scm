#| Exercise 4.26: Ben Bitdiddle and Alyssa P. Hacker disagree over the importance of lazy evaluation 
for implementing things such as unless. 
Ben points out that it’s possible to implement unless in applicative order as a special form. 
Alyssa counters that, if one did that, unless would be merely syntax, 
not a procedure that could be used in conjunction with higher-order procedures. 
Fill in the details on both sides of the argument. Show how to implement unless as a 
derived expression (like cond or let), and give an example of a situation where it might 
be useful to have unless available as a procedure, rather than as a special form.  |#


(load "meta.scm")

(define (mc-eval exp env)
  (cond ((self-evaluating? exp) exp)
	((variable? exp) (lookup-variable-value exp env)) 
	((quoted? exp) (text-of-quotation exp)) 
	((assignment? exp) (eval-assignment exp env))
	((definition? exp) (eval-definition exp env))
	((if? exp) (eval-if exp env)); 
    ((unless? exp) (eval-unless exp env)) ;<----------------------------------------------------------------------------
	((lambda? exp)
	 (make-procedure (lambda-parameters exp)
			 (lambda-body exp)
			 env))
	((begin? exp) 
	 (eval-sequence (begin-actions exp) env)) 
	((cond? exp) (mc-eval (cond->if exp) env))
	((application? exp)
	 (mc-apply (mc-eval (operator exp) env)
		   (list-of-values (operands exp) env)))
	(else
	 (error "Unknown expression type -- EVAL" exp))))


    (define unless-condition cadr)
    (define unless-usual-value caddr)
    (define unless-exceptional-value cadddr)

     (define (eval-unless exp env)
        (if (true? (mc-eval (unless-condition exp) env))
            (mc-eval (unless-usual-value exp) env)
            (mc-eval (unless-exceptional-value exp) env)
        )
     )

    (define (unless? exp)
        (tagged-list? exp 'unless )
    )

    ;if we wan't to use unless to compare two of our own procedures results it can be easier to have unless
    ; as procedure. Then we can put these procedures as arguments in the procedure 
    ; ,making it a higher order procedure.