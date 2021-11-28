#| Exercise 4.22: Extend the evaluator in this section to support the special form let. (See Exercise 4.6.)  |#
(load "analyze.scm")

(define (analyze exp)
  (cond ((self-evaluating? exp) 
         (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((let? exp) (analyze-let exp))
        ((if? exp) (analyze-if exp))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond->if exp)))
        ((application? exp) (analyze-application exp))
        (else
         (error "Unknown expression type -- ANALYZE" exp))))

(define (let? exp)
    (print "debug let?")
   (tagged-list? exp 'let )
)
(define (analyze-let exp)
    (print "debug analyze-let")
  (analyze (let->combination exp))
)

(define (let->combination exp)
    (print "debug let->combination")
    (let* 
        (
            (bindings (cadr exp))
            (binding-names (map car bindings))
            (binding-values (map cadr bindings))
            (body (cddr exp))
        )
        (cons (make-lambda binding-names body) binding-values)
        
    )
)

;testing
;(mce)
(define test 
    (let 
        (
            (var 5)
        )
        
            (* var var)
        
    )
)