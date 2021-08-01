
#| 
1d. Modify the interpreter to add the and special form. Test your work. Be sure that as soon as a false
value is computed, your and returns #f without evaluating any further arguments. |#


(define (scheme-1)
  (display "Scheme-1: ")
  (flush)
  (print (eval-1 (read)))
  (scheme-1))


(define (eval-1 exp)
  (cond ((constant? exp) exp)
	((symbol? exp) (eval exp))	; use underlying Scheme's EVAL
	((quote-exp? exp) (cadr exp))
	((if-exp? exp)
        (if (and-exp? (cadr exp))  ; <-- ADDITION FOR ADD
            (eval-sf-and exp)      ; <-- ADDITION FOR ADD
            (if (eval-1 (cadr exp)) ; normal if
	            (eval-1 (caddr exp))
	            (eval-1 (cadddr exp))
            )
        )
    )
	((lambda-exp? exp) exp)
	((pair? exp) (apply-1 (eval-1 (car exp))      ; eval the operator
			      (map eval-1 (cdr exp))))
	(else (error "bad expr: " exp))))



    ;ADDITION FOR ADD
    (define (eval-sf-and exp)
        (if (eval-1 (car (cdadr exp)))
            (if (eval-1 (cadr (cdadr exp)))
                (eval-1 (car (cddr exp)))
                (eval-1 (last exp))
            )
            (print "quitting on first if!")
            ;(eval-1 (last exp))
        )
    )

(define (apply-1 proc args)
  (cond ((procedure? proc)	; use underlying Scheme's APPLY
	 (apply proc args))
	((lambda-exp? proc)
	 (eval-1 (substitute (caddr proc)   ; the body
			     (cadr proc)    ; the formal parameters
			     args           ; the actual arguments
			     '())))	    ; bound-vars, see below
	(else (error "bad proc: " proc))))


;; Some trivial helper procedures:

(define (constant? exp)
  (or (number? exp) (boolean? exp) (string? exp) (procedure? exp)))

(define (exp-checker type)
  (lambda (exp) (and (pair? exp) (eq? (car exp) type))))

(define quote-exp? (exp-checker 'quote))
(define if-exp? (exp-checker 'if))
(define lambda-exp? (exp-checker 'lambda))
(define and-exp? (exp-checker 'and))  ;<-- ADDITION FOR AND


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
	(else (map (lambda (subexp) (substitute subexp params args bound))
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







;testing
(if (= 2 3) 'itstrue 'itsfalse )
(if (and (= 0 0) (= 0 0)) 'truestuff 'negativestuff ) ;#t
(if (and (= 0 0) (= 0 2)) 'truestuff 'negativestuff ) ;#f
(if (and (= 1 0) (= 0 2)) 'truestuff 'negativestuff ) ;"quitting on first if!"
(if (and (= 1 0) (= 0 0)) 'truestuff 'negativestuff ) ;"quitting on first if!"



