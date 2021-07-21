;; Scheme calculator -- evaluate simple expressions

; The read-eval-print loop:

(define (calc)
  (display "calc: ")
  (flush)
  (print (calc-eval (read)))
  (calc))

; Evaluate an expression:

(define (calc-eval exp)
  (cond ((or (number? exp) (symbol? exp)) exp)
        ((list? exp) (calc-apply (car exp) (map calc-eval (cdr exp))))
	    (else (error "Calc: bad expression:" exp))
  )
)

; Apply a function to arguments:

(define (calc-apply fn args)
  (cond ((eq? fn '+) (accumulate + 0 args))
	    ((eq? fn '-) (cond ((null? args) (error "Calc: no args to -"))
			    ((= (length args) 1) (- (car args)))
			    (else (- (car args) (accumulate + 0 (cdr args))))))
	    ((eq? fn '*) (accumulate * 1 args))
	    ((eq? fn '/) (cond ((null? args) (error "Calc: no args to /"))
			   ((= (length args) 1) (/ (car args)))
			   (else (/ (car args) (accumulate * 1 (cdr args))))))
        ((eq? fn 'quote ) (stringify args))
        ((eq? fn 'first ) (calc-first args))
        ((eq? fn 'butfirst ) (calc-butfirst args))
        ((eq? fn 'last ) (calc-last args))
        ((eq? fn 'butlast ) (calc-butlast args))
        ((eq? fn 'word ) (calc-word args))
	    (else (error "Calc: bad operator:" fn))))

 ; #\a -> a
(define (char->symbol chr)
      (string->symbol (list->string (list chr))))

(define (calc-first symbols)
  (if (< 1 (length symbols))
    (car symbols)
    (char->symbol (car (string->list (symbol->string (car symbols)))))
  )
)
(define (calc-butfirst symbols)
  (if (< 1 (length symbols))
    (cdr symbols)
    (butfirst (car symbols))
  )
)
(define (calc-last symbols)
  (if (< 1 (length symbols))
    (last symbols)
    (last (car symbols))
  )
)
(define (calc-butlast symbols)
  (if (< 1 (length symbols))
    (butlast symbols)
    (butlast (car symbols))
  )
)
(define (calc-word symbols)
  (if (< 1 (length symbols))
      (print symbols)
      (car symbols)
  )
)

