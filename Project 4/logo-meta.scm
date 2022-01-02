;;; logo-meta.scm      Part of programming project #4

;;; Differences between the book and this version:  Eval and apply have
;;; been changed to logo-eval and logo-apply so as not to overwrite the Scheme
;;; versions of these routines. An extra procedure initialize-logo has been
;;; added. This routine resets the global environment and then executes the
;;; driver loop. This procedure should be invoked to start the Logo
;;; evaluator executing.  Note: It will reset your global environment and all
;;; definitions to the Logo interpreter will be lost. To restart the Logo
;;; interpreter without resetting the global environment, just invoke
;;; driver-loop.  Don't forget that typing control-C will get you out of
;;; the Logo evaluator back into Scheme.

;;; Problems A1, A2, and B2 are entirely in logo.scm
;;; Problems 3, 7, and up require you to find and change existing procedures.

;;;  Procedures that you must write from scratch:

;;; Problem B1    eval-line
  (define (eval-line line-obj env)
    (define (check-if-inside-step-procedure li)
      (if (null? li)
        #f
        (if (eq? (procedure-name (car li)) (car (ask line-obj 'text )))
            (cadr (cadddr (car li))) 
            (check-if-inside-step-procedure (cdr li))
        )
      )
    )
    (define (steploop li)
      (if (null? li)
        (begin (ask line-obj 'next ) (loop)) 
        (begin 
          (prompt (car li)) (prompt ">>>")
          (logo-read) (steploop (cdr li))
        )
      )
    )
    (define (loop)
      (define (normal-loop)
          (let
            (
              (val (logo-eval line-obj env))
            )
            (if (eq? val '=no-value= )
                (loop)
                val
            )
          )
      )
      (if (ask line-obj 'empty? )
          '=no-value=
          (let
              (
                (steplist (lookup-variable-value 'step-active-proc env))
              )
              (if (eq? steplist #f) 
                (normal-loop) ;if no step procedures exist, do normal evaluation.
                (let 
                  (
                    (step-proc (check-if-inside-step-procedure steplist)) ;if step proc. exist, check if it is this step proc we have invoked
                  )
                  (if step-proc
                    (steploop step-proc)
                    (normal-loop)
                  )
                )
              ) 
          )
      )
    )
    (loop)
  )


#| 
(load "init.scm")
to garply
print "hello
print "goodbye
end
garply
step "garply
garply
[enter] [enter]
unstep "garply 
garply -> back to normal
|#

;;; Problem 4    variables  (other procedures must be modified, too)
;;; data abstraction procedures

(define (variable? exp)
  (if (eq? (first exp) :)
      #t
      #f
  )
)         




(define (variable-name exp)
  (bf exp)
)


;;; Problem A5   handle-infix

(define (de-infix token)
  (cdr (assoc token '((+ . sum)
		      (- . difference)
		      (* . product)
		      (/ . quotient)
		      (= . equalp)
		      (< . lessp)
		      (> . greaterp))
        )
  ))


(define (handle-infix value line-obj env)
  (if (null? (ask line-obj 'text ))
        value
      (begin 
        ;checks if infix operator
        (if (member? (car (ask line-obj 'text )) '(+ - * / = < >)) 
          (let
            (
              (next (ask line-obj 'next ))
            )
            (begin 
              (ask line-obj 'put-in-front value)
              (ask line-obj 'put-in-front (de-infix next))
              (logo-eval line-obj env)
            )
          )
          value
        )
      )
  )
  
  
)   


;;; Problem B5    eval-definition

(define (make? line-obj)
  (if (eq? line-obj 'make )
    #t
    #f
  )
)

(define make-var-name (lambda (x) (bf (car x))))
(define make-value cdr)

(define (eval-make line-obj env)
  (if (lookup-variable-value (make-var-name (ask line-obj 'text )) env)
      (begin (set-variable-value! (make-var-name (ask line-obj 'text )) (make-value (ask line-obj 'text )) env) '=no-value= )
      (begin (define-variable! (make-var-name (ask line-obj 'text )) (make-value (ask line-obj 'text )) env) '=no-value= )
  )
)


(define (eval-definition line-obj env)
    (define (handle-formals line-obj formals-li)
      (if (ask line-obj 'empty? )
          formals-li
          (let
            (
              (next (ask line-obj 'next ))
            )
            (cond 
              ((null? next) formals-li )
              ((variable? next) (handle-formals line-obj (append formals-li (list next))))
              ((static? next) formals-li )
              (else (error "INVALID FORMALS"))
            )
          )
      )
    )
    (define (handle-statics line-obj)
            (if (ask line-obj 'empty? )
                '()
                (begin
                  (let
                    (
                      (static-env (extend-environment (list (ask line-obj 'next ) ) (list (logo-eval line-obj env)) env))
                    )
                    (display "statics env:") 
                    (print static-env)
                    static-env
                  )
                )
            )
    )
    (define (eval-def-loop body env)
          (prompt "-> ")
          (let
            (
              (line-reading (logo-read))
            )
            (if (member? 'end line-reading)
                body
                (eval-def-loop (append body (list line-reading)) env)
            )
          )
    )
    (let
      (
        (name (ask line-obj 'next ))
        (formals (handle-formals line-obj '()))
        (statics (handle-statics line-obj))
        (body '())
      )
      (set! body (eval-def-loop body env))
      (add-compound name (length formals) (list formals statics body))
    )
  )

(define (add-compound name count proc)
  (set! the-procedures
	(cons (list name 'compound count proc)
	      the-procedures)))


;;; Problem 6    eval-sequence

;Should:
;convert to line-obj. Is exps a instruction list or is it many instruction lists?
;either return =NO-VALUE= or "You don't say what to do with"
;if procedure STOP, return =NO-VALUE=
;if procedure OUTPUT return the cdr of output-pair ,which is the value.
(define (eval-sequence exps env)
 (if (null? exps)
    '=NO-VALUE=
    (let
      (
        (response (eval-line (make-line-obj (car exps)) env))
      )
      (cond 
        ((equal? response '=stop= ) '=NO-VALUE= )
        ((and (list? response) (equal? (car response) '=output= )) (cdr response))
        ((not (equal? response '=NO-VALUE= )) (logo-print (list "You don't say what to do with " response)))
        (else (eval-sequence (cdr exps) env))
      )
    )
 )
)

; Person A A8, STEP IMPLEMENTATION
(define (unstep wrd)
  (let 
    (
      (proc (lookup-procedure wrd))
    )
    (if (compound-procedure? proc)
        (remove-step-var (procedure-name proc))
        (error "not a proc" wrd)
    )
  )
)
(define (remove-step-var proc-name)
  (define (inner-loop step-li filtered-results)
    (if (null? step-li)
      filtered-results
      (if (eq? (procedure-name (car step-li)) proc-name)
          (inner-loop (cdr step-li) filtered-results)
          (inner-loop (cdr step-li) (append (car step-li) filtered-results))
      )
    )
  )
  (begin 
    (display "removeresult: " ) 
    (print (inner-loop (lookup-variable-value step-active-proc the-global-environment) '()))
    (set-variable-value! step-active-proc (inner-loop (lookup-variable-value step-active-proc the-global-environment) '()) the-global-environment) 
    '=no-value= 
  )
)
(define (step wrd)
  (define (add-to-step-var new-val env)
    (if (lookup-variable-value step-active-proc env)
      (begin (set-variable-value! step-active-proc (append step-active-proc new-val) env) '=no-value= )
      (begin (define-variable! step-active-proc (list new-val) env) '=no-value= )
    )
  )
  (if (lookup-procedure wrd)
    (if (compound-procedure? (lookup-procedure wrd)) 
        (begin 
          (print (lookup-procedure wrd)) (print (reverse (cadr (cadddr (lookup-procedure wrd))))) 
          (add-to-step-var (lookup-procedure wrd) the-global-environment)
        )
        (error "not a compound procedure" wrd)
    )
    (error "proc NOT found")
  )
)
;testing
#| 
(load "init.scm")
to garply
print "hello
print "goodbye
end
garply
step "garply
garply

unstep "garply 
|#

;;; SETTING UP THE ENVIRONMENT

(define the-primitive-procedures '())

(define (add-prim name count proc)
  (set! the-primitive-procedures
	(cons (list name 'primitive count proc)
	      the-primitive-procedures)))

(add-prim 'first 1 first)
(add-prim 'butfirst 1 bf)
(add-prim 'bf 1 bf)
(add-prim 'last 1 last)
(add-prim 'butlast 1 bl)
(add-prim 'bl 1 bl)
(add-prim 'word -2 word)
(add-prim 'sentence 2 se)
(add-prim 'se -2 se)
(add-prim 'list -2 list)
(add-prim 'fput 2 cons)

(add-prim 'sum -2 (make-logo-arith +))
(add-prim 'difference 2 (make-logo-arith -))
(add-prim '=unary-minus= 1 (make-logo-arith -))
(add-prim '- 1 (make-logo-arith -))
(add-prim 'product -2 (make-logo-arith *))
(add-prim 'quotient 2 (make-logo-arith /))
(add-prim 'remainder 2 (make-logo-arith remainder))

(add-prim 'print 1 logo-print)
(add-prim 'pr 1 logo-print)
(add-prim 'show 1 logo-show)
(add-prim 'type 1 logo-type)
(add-prim 'make '(2) make)

(add-prim 'run '(1) run)
(add-prim 'if '(2) logo-if)
(add-prim 'ifelse '(3) ifelse)
(add-prim 'equalp 2 (logo-pred (make-logo-arith equalp)))
(add-prim 'lessp 2 (logo-pred (make-logo-arith <)))
(add-prim 'greaterp 2 (logo-pred (make-logo-arith >)))
(add-prim 'emptyp 1 (logo-pred empty?))
(add-prim 'numberp 1 (logo-pred (make-logo-arith number?)))
(add-prim 'listp 1 (logo-pred list?))
(add-prim 'wordp 1 (logo-pred (lambda (x) (not (list? x)))))

(add-prim 'stop 0 (lambda () '=stop= ))
(add-prim 'output 1 (lambda (x) (cons '=output= x)))
(add-prim 'op 1 (lambda (x) (cons '=output= x)))

(define (pcmd proc) (lambda args (apply proc args) '=no-value= ))
(add-prim 'cs 0 (pcmd cs))
(add-prim 'clearscreen 0 (pcmd cs))
(add-prim 'fd 1 (pcmd fd))
(add-prim 'forward 1 (pcmd fd))
(add-prim 'bk 1 (pcmd bk))
(add-prim 'back 1 (pcmd bk))
(add-prim 'lt 1 (pcmd lt))
(add-prim 'left 1 (pcmd lt))
(add-prim 'rt 1 (pcmd rt))
(add-prim 'right 1 (pcmd rt))
(add-prim 'setxy 2 (pcmd setxy))
(add-prim 'setx 1 (lambda (x) (setxy x (ycor)) '=no-value= ))
(add-prim 'sety 1 (lambda (y) (setxy (xcor) y) '=no-value= ))
(add-prim 'xcor 0 xcor)
(add-prim 'ycor 0 ycor)
(add-prim 'pos 0 pos)
(add-prim 'seth 1 (pcmd setheading))
(add-prim 'setheading 1 (pcmd setheading))
(add-prim 'heading 0 heading)
(add-prim 'st 0 (pcmd st))
(add-prim 'showturtle 0 (pcmd st))
(add-prim 'ht 0 (pcmd ht))
(add-prim 'hideturtle 0 (pcmd ht))
(add-prim 'shown? 0 shown?)
(add-prim 'pd 0 (pcmd pendown))
(add-prim 'pendown 0 (pcmd pendown))
(add-prim 'pu 0 (pcmd penup))
(add-prim 'penup 0 (pcmd penup))
(add-prim 'pe 0 (pcmd penerase))
(add-prim 'penerase 0 (pcmd penerase))
(add-prim 'home 0 (pcmd home))
(add-prim 'setpc 1 (pcmd setpc))
(add-prim 'setpencolor 1 (pcmd setpc))
(add-prim 'pc 0 pc)
(add-prim 'pencolor 0 pc)
(add-prim 'setbg 1 (pcmd setbg))
(add-prim 'setbackground 1 (pcmd setbg))

(add-prim 'load 1 meta-load)
(add-prim 'step 1 (lambda (w) (step w)))
(add-prim 'unstep 1 (lambda (w) (unstep w)))

(define the-global-environment '())
(define the-procedures the-primitive-procedures)

;;; INITIALIZATION AND DRIVER LOOP

;;; The following code initializes the machine and starts the Logo
;;; system.  You should not call it very often, because it will clobber
;;; the global environment, and you will lose any definitions you have
;;; accumulated.

(define (initialize-logo)
  (set! the-global-environment (extend-environment '() '() '()))
  (set! the-procedures the-primitive-procedures)
  (driver-loop))

(define (driver-loop)
  (define (helper)
    (prompt "? ")
    (let ((line (logo-read)))
      (if (not (null? line))
          (let 
            (
              (result (eval-line (make-line-obj line) the-global-environment))
            )
            (if (not (eq? result '=no-value= ))
                (logo-print (list "You don't say what to do with" result))
            )
          )
      )
    )
    (helper))
  (logo-read)
  (helper))

;;; APPLYING PRIMITIVE PROCEDURES

;;; To apply a primitive procedure, we ask the underlying Scheme system
;;; to perform the application.  (Of course, an implementation on a
;;; low-level machine would perform the application in some other way.)

(define (apply-primitive-procedure p args)
  (apply (text p) args))


;;; Now for the code that's based on the book!!!


;;; Section 4.1.1

;; Given an expression like (proc :a :b :c)+5
;; logo-eval calls eval-prefix for the part in parentheses, and then
;; handle-infix to check for and process the infix arithmetic.
;; Eval-prefix is comparable to Scheme's eval.
 (define (logo-eval line-obj env)
  (handle-infix (eval-prefix line-obj env) line-obj env))

(define (eval-prefix line-obj env)
  (define (eval-helper paren-flag)
    (let ((token (ask line-obj 'next )))
      (cond ((self-evaluating? token) token)
            ((variable? token) (lookup-variable-value (variable-name token) env))
            ((quoted? token) (text-of-quotation token))
            ((definition? token) (eval-definition line-obj env))
            ((make? token) (eval-make line-obj env))
            ((left-paren? token)
              (let ((result (handle-infix (eval-helper #t) line-obj env)))
                (let ((token (ask line-obj 'next )))
                     (if (right-paren? token)
                         (begin (print result) (set! paren-flag #f) result)
                         (begin (print token) (error "Too much inside parens"))
                     )
                )
              )
            )
            ((right-paren? token) 
              (if (eq? paren-flag #t) 
                  (begin (print "found right paren") '())
                  (begin (print token) (error "Unexpected ')'")))
            )
            (else  
              (let ((proc (lookup-procedure token)))
                (if (not proc) (error "I don't know how  to " token))
                  (if (eq? paren-flag #t) 
                    (logo-apply proc (collect-n-args (ask line-obj 'text ) line-obj env) env)
                    (logo-apply proc (collect-n-args (arg-count proc) line-obj env) env)
                  )
              )
            )
      )
    )
  )
  (eval-helper #f))

(define (logo-apply procedure arguments env)
  (cond ((primitive-procedure? procedure) (apply-primitive-procedure procedure arguments))
        ((compound-procedure? procedure) 
          (eval-sequence (procedure-body procedure)
            (extend-environment
             (procedure-parameters procedure)
             arguments
             env))
        )
        (else
         (error "Unknown procedure type -- LOGO-APPLY " procedure)
        )
   
  )
)

  (define (count-the-list li counter)
    (if (null? li)
      counter
      (if (right-paren? (car li))
        counter
        (count-the-list (cdr li) (+ counter 1)) 
      )
    )
  )
  (define (create-the-list li new-li)
    (if (null? li)
      new-li
      (if (right-paren? (car li))
        new-li
        (create-the-list (cdr li) (append new-li (list (car li)))) 
      )
    )
  )
  
  
(define (collect-variable-n-args n line-obj env)
  (collect-positive-integer-args (count-the-list n 0) line-obj env)
)
(define (collect-default-negative-args n line-obj env)
  (if (eq? (abs n) (count-the-list (ask line-obj 'text ) 0))
    (collect-positive-integer-args (abs n) line-obj env)
    (collect-variable-n-args (ask line-obj 'text ) line-obj env)
  )
)
(define (collect-positive-integer-args n line-obj env)
      (let ((next (logo-eval line-obj env)))
           (cons next (collect-n-args (- n 1) line-obj env)) 
      )
  
  
)

(define (collect-n-args n line-obj env)
  (cond ((list? n) (collect-variable-n-args n line-obj env))
        ((= n 0) '())
        ((and (< n 0) (not (ask line-obj 'empty? ))) (collect-default-negative-args n line-obj env))
        (else      
          (collect-positive-integer-args n line-obj env)
        )
  )
)


;;; Section 4.1.2 -- Representing expressions

;;; numbers

(define (self-evaluating? exp) (number? exp))

;;; quote

(define (quoted? exp)
  (or (list? exp)
      (eq? (string-ref (word->string (first exp)) 0) #\")))

(define (text-of-quotation exp)
  (if (list? exp)
      exp
      (bf exp)))

;;; parens

(define (left-paren? exp) (eq? exp left-paren-symbol))

(define (right-paren? exp) (eq? exp right-paren-symbol))

;;; statics

(define (static? exp)
  (eq? exp 'static )
)

;;; definitions

(define (definition? exp)
  (eq? exp 'to ))

;;; procedures

(define (lookup-procedure name)
  (assoc name the-procedures))

(define (primitive-procedure? p)
  (eq? (cadr p) 'primitive ))

(define (compound-procedure? p)
  (eq? (cadr p) 'compound ))

(define (arg-count proc)
  (caddr proc))

(define (text proc)
  (cadddr proc))

(define (parameters proc) (car (text proc)))

(define (procedure-name proc) (car proc))

(define (procedure-parameters proc) (car (text proc)))

(define (procedure-body proc) (caddr (text proc)))

;;; Section 4.1.3

;;; Operations on environments

(define (enclosing-environment env) (cdr env))

(define (first-frame env) (car env))

(define the-empty-environment '())

(define (make-frame variables values)
  (cons variables values))

(define (frame-variables frame) (car frame))
(define (frame-values frame) (cdr frame))

(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied " vars vals)
          (error "Too few arguments supplied " vars vals))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars) (env-loop (enclosing-environment env)))
            ((equal? var (car vars)) (car vals))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        #f
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

;testing:
#| 

(load "init.scm")
make "foo 27
print :foo

(load "init.scm")
to sumitup :one :two
print sum :one :two
end
sumitup 3 7 

(load "init.scm")
to count :increase static :counter 2+3
make "counter :counter + :increase
print :counter
end
count 20 

|#

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((equal? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET! " var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars)
             (add-binding-to-frame! var val frame))
            ((equal? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))
