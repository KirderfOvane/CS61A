#| 
Modify the scheme-1 interpreter to add the let special form. Hint: Like a procedure
call, let will have to use substitute to replace certain variables with their values. Don’t
forget to evaluate the expressions that provide those values!
|#



;; Simple evaluator for Scheme without DEFINE, using substitution model.
;; Version 1: No DEFINE, only primitive names are global.

;; The "read-eval-print loop" (REPL):

(define (scheme-1)
  (display "Scheme-1: ")
  (flush)
  (print (eval-1 (read)))
  (scheme-1))

;; Two important procedures:
;; EVAL-1 takes an expression and returns its value.
;; APPLY-1 takes a procedure and a list of actual argument values, and
;;  calls the procedure.
;; They have these names to avoid conflict with STk's EVAL and APPLY,
;;  which have similar meanings.

;; Comments on EVAL-1:

;; There are four basic expression types in Scheme:
;;    1. self-evaluating (a/k/a constant) expressions: numbers, #t, etc.
;;    2. symbols (variables)
;;    3. special forms (in this evaluator, just QUOTE, IF, and LAMBDA)
;;    4. procedure calls (can call a primitive or a LAMBDA-generated procedure)

;; 1.  The value of a constant is itself.  Unlike real Scheme, an STk
;; procedure is here considered a constant expression.  You can't type in
;; procedure values, but the value of a global variable can be a procedure,
;; and that value might get substituted for a parameter in the body of a
;; higher-order function such as MAP, so the evaluator has to be ready to
;; see a built-in procedure as an "expression."  Therefore, the procedure
;; CONSTANT? includes a check for (PROCEDURE? EXP).

;; 2.  In the substitution model, we should never actually evaluate a *local*
;; variable name, because we should have substituted the actual value for
;; the parameter name before evaluating the procedure body.

;; In this simple evaluator, there is no DEFINE, and so the only *global*
;; symbols are the ones representing primitive procedures.  We cheat a little
;; by using STk's EVAL to get the values of these variables.

;; 3.  The value of the expression (QUOTE FOO) is FOO -- the second element of
;; the expression.

;; To evaluate the expression (IF A B C) we first evaluate A; then, if A is
;; true, we evaluate B; if A is false, we evaluate C.

;; The value of a LAMBDA expression is the expression itself.  There is no
;; work to do until we actually call the procedure.  (This won't be true
;; when we write a more realistic interpreter that handles more Scheme
;; features, but it works in the substitution model.)

;; 4.  To evaluate a procedure call, we recursively evaluate all the
;; subexpressions.  We call APPLY-1 to handle the actual procedure invocation.

(define (eval-1 exp)
  (cond ((constant? exp) exp)
	((symbol? exp) (eval exp))	; use underlying Scheme's EVAL
	((quote-exp? exp) (cadr exp))
	((if-exp? exp)
	 (if (eval-1 (cadr exp))
	     (eval-1 (caddr exp))
	     (eval-1 (cadddr exp))))
	((let-exp? exp) (eval-1 (let->lambda exp)))  ; <-- ADDITION
	((lambda-exp? exp) exp)
	((pair? exp) (apply-1 (eval-1 (car exp))      ; eval the operator
			      (map-1 eval-1 (cdr exp))))
	(else (error "bad expr: " exp))))


;; Comments on APPLY-1:

;; There are two kinds of procedures: primitive and LAMBDA-created.

;; We recognize a primitive procedure using the PROCEDURE? predicate in
;; the underlying STk interpreter.

;; If the procedure isn't primitive, then it must be LAMBDA-created.
;; In this interpreter (but not in later, more realistic ones), the value
;; of a LAMBDA expression is the expression itself.  So (CADR PROC) is
;; the formal parameter list, and (CADDR PROC) is the expression in the
;; procedure body.

;; To call the procedure, we must substitute the actual arguments for
;; the formal parameters in the body; the result of this substitution is
;; an expression which we can then evaluate with EVAL-1.

(define (apply-1 proc args)
  (cond ((procedure? proc)	; use underlying Scheme's APPLY
	        (apply proc args))
	    ((lambda-exp? proc)
            (eval-1 (substitute (caddr proc)   ; the body
                                (cadr proc)    ; the formal parameters
                                args           ; the actual arguments
                                '())))	       ; bound-vars, see below
	    (else (error "bad proc: " proc))))


;; Some trivial helper procedures:

(define (constant? exp)
  (or (number? exp) (boolean? exp) (string? exp) (procedure? exp)))

(define (exp-checker type)
	;(print exp)
	;(print type)
  (lambda (exp) (and (pair? exp) (eq? (car exp) type))))

(define quote-exp? (exp-checker 'quote ))
(define if-exp? (exp-checker 'if ))
(define lambda-exp? (exp-checker 'lambda ))
(define let-exp? (exp-checker 'let ))  ; <-- ADDITION

(define (substitute exp params args bound)
  (cond ((constant? exp) exp)
	((symbol? exp)
	 (if (memq exp bound)
	     exp
	     (lookup exp params args)))
	((quote-exp? exp) exp)
	((lambda-exp? exp)
	 (list 'lambda
	       (cadr exp)
	       (substitute (caddr exp) params args (append bound (cadr exp)))))
	(else (map-1 (lambda (subexp) (substitute subexp params args bound))
		   exp))))

(define (lookup name params args)
  (cond ((null? params) name)
	((eq? name (car params)) (maybe-quote (car args)))
	(else (lookup name (cdr params) (cdr args)))))

(define (maybe-quote value)
  (cond ((lambda-exp? value) value)
	((constant? value) value)
	((procedure? value) value)	; real Scheme primitive procedure
	(else (list 'quote value))))

;map-1:
(define (map-1 fn li)
    (if (eq? li '())
        '()
        (cons (apply-1 fn (list (car li))) (map-1 fn (cdr li)))
    )
)

;testing:
(scheme-1)


;PROCESS to Let-implementation

;(let ((test 5)) (+ test test))
;(let ((test 5)(var2 7)) (+ test test var2 var2))

; bindings selector
;(cadr '(let ((test 5)(var2 7)) (+ test test var2 var2))) 

; list of all lambda declarations
; (map car (cadr '(let ((test 5)(var2 7)) (+ test test var2 var2))))

; list of all lambda values
; (map cadr (cadr '(let ((test 5)(var2 7)) (+ test test var2 var2))))
;  (car (map cadr (cadr '(let ((test 5)(var2 7)) (+ test test var2 var2)))))

; body selector
;(caddr '(let ((test 5)(var2 7)) (+ test test var2 var2)))

;test1
(print  
		(list 
			'lambda
			(map car (cadr '(let ((test 5)(var2 7)) (+ test test var2 var2))))
			(caddr '(let ((test 5)(var2 7)) (+ test test var2 var2)))
			(map cadr (cadr '(let ((test 5)(var2 7)) (+ test test var2 var2))))
		)
)
;test2
(append (list (list 
			'lambda
			(map car (cadr '(let ((test 5)(var2 7)) (+ test test var2 var2))))
			(caddr '(let ((test 5)(var2 7)) (+ test test var2 var2)))
		))
		(map cadr (cadr '(let ((test 5)(var2 7)) (+ test test var2 var2))))
)
;working
(eval (append (list (list 
			'lambda
			(map car (cadr '(let ((test 5)(var2 7)) (+ test test var2 var2))))
			(caddr '(let ((test 5)(var2 7)) (+ test test var2 var2)))
		))
		(map cadr (cadr '(let ((test 5)(var2 7)) (+ test test var2 var2))))
))
;refactor to generic function
(define (let->lambda exp)
	(eval 
		(append (list 
					  (list
							'lambda
							(map car (cadr exp))
							(caddr exp)
					  )
				)
				(map cadr (cadr exp))
		)
	)
)
;test
;(let->lambda '(let ((test 5)(var2 7)) (+ test test var2 var2)))
;(let->lambda '(let ((test 5)) (+ test test)))

;FINAL
;refactor for scheme-1 implementation: remove inner eval. This is the one used when running scheme-1.
(define (let->lambda exp) 
		(append (list 
					  (list
							'lambda
							(map car (cadr exp))
							(caddr exp)
					  )
				)
				(map cadr (cadr exp))
		)
)
