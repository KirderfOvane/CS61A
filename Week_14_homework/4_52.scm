#| Exercise 4.52: Implement a new construct called if-fail that permits the user to catch the failure of an expression. 
If-fail takes two expressions. 
It evaluates the first expression as usual and returns as usual if the evaluation succeeds. 
If the evaluation fails, however, 
the value of the second expression is returned, as in the following example:  |#

;;; Amb-Eval input:
#| (if-fail 
 (let ((x (an-element-of '(1 3 5))))
   (require (even? x))
   x)
 'all-odd) |#

;;; Starting a new problem
;;; Amb-Eval value:
;all-odd

;;; Amb-Eval input:
#| (if-fail
 (let ((x (an-element-of '(1 3 5 8))))
   (require (even? x))
   x)
 'all-odd) |#

;;; Starting a new problem
;;; Amb-Eval value:
;8


(load "ambeval.scm")

(define (analyze exp)
  (cond ((self-evaluating? exp) 
         (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((if-fail? exp) (analyze-if-fail exp));change
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond->if exp)))
        ((let? exp) (analyze (let->combination exp))) ;**
        ((amb? exp) (analyze-amb exp))                ;**
        ((application? exp) (analyze-application exp))
        (else
         (error "Unknown expression type -- ANALYZE" exp))))


(define (if-fail? exp) (tagged-list? exp 'if-fail ))
(define (if-fail-amb exp) (cadr exp))
(define (if-fail-fail exp) (caddr exp))

(define (analyze-if-fail exp)
  (let ((pproc (analyze (if-fail-amb exp)))
        (cproc (analyze (if-fail-fail exp)))
    (lambda (env succeed fail)
      (pproc env
             ;; success continuation for evaluating the predicate
             ;; to obtain pred-value
             (lambda (pred-value fail2)
               (if (true? pred-value)
                   (cproc env succeed fail2)
                   (aproc env succeed fail2)))
             ;; failure continuation for evaluating the predicate
             fail)))))

