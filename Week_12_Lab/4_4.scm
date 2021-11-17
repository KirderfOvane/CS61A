#| Exercise 4.4: Recall the definitions of the special forms and and or from Chapter 1:

    and: The expressions are evaluated from left to right. 
         If any expression evaluates to false, false is returned; 
         any remaining expressions are not evaluated. 
         If all the expressions evaluate to true values, 
         the value of the last expression is returned. 
         If there are no expressions then true is returned.
    or: The expressions are evaluated from left to right. 
        If any expression evaluates to a true value, that value is returned; 
        any remaining expressions are not evaluated. 
        If all expressions evaluate to false, or if there are no expressions, then false is returned. 

Install and and or as new special forms for the evaluator by defining appropriate syntax procedures 
and evaluation procedures eval-and and eval-or. Alternatively, show how to implement and and or as derived expressions.  |#

    ((or? exp) (eval-or exp env))
    ((and? exp) (eval-and exp env))
    
    (define (or? exp)
        (tagged-list? exp 'or )
    )
    (define (and? exp)
        (tagged-list? exp 'and )
    )

    (define (eval-or exp env)
        (if (no-operands? exp)
            #f
            (if (apply (eval (operator exp) env) (eval (first-operand (operands exp) env)))
                #t
                (if (no-operands? (rest-operands exp))
                    #f
                    (eval-or (rest-operands exp))
                )
            )
        )
    )
    (define (eval-and exp env)
        (if (no-operands? exp)
            #f
            (if (apply (eval (operator exp) env) (eval (first-operand (operands exp) env)))   
                (if (no-operands? (rest-operands exp))
                    #t
                    (eval-and (rest-operands exp))
                )
                #f
            )
        )
    )