
;;; logo.scm         part of programming project #4
(define-class (line-object text)
	(method (remove)
		(if (null? text)
			(print "line-obj says: No more text to evaluate")
			(begin
			(set! text (cdr text))
			text))
	) 
  (method (empty?) (null? text))
  ;NEXT:should return the next token waiting
  ;to be read in the line, and remove
  ;that token from the list.
  (method (next)
      (if (null? text)
          '() 
          (let
              (
                (token (car text))
              )
              (set! text (cdr text))
              token
          )
      )
  )
  (method (put-back token)
    (set! text (append text (list token)))
    text)
  (method (put-in-front token)
    (set! text (append (list token) text))
  )
)  

;;; Problem A1   make-line-obj

(define (make-line-obj text) 
  (instantiate line-object text)
) 


;;; Problem A2   logo-type

(define (logo-type val)   
  (cond 
    ((null? val) '=no-value= )
    ((pair? val)                  ;; list
      (cond ((pair? (car val)) (display "[") (logo-type (car val)) (display "]")) ;; sub-list
            ((null? (car val)) (display "[]"))  ;; empty list
            (else                  
              (display (car val))) ;; word
      ) 
    (if (not (null? (cdr val))) ; if it's not the last value
        (display " ")
    )
    (logo-type (cdr val)))  ;after any of above cond, move on to next val
    (else                     ;; word
      (display val)
      '=no-value= 
    )
  )
)


(define (logo-print val)
  (logo-type val)  
  (newline) 
  '=no-value= ) 

(define (logo-show val)   
  (logo-print (list val)))   


;;; Problem 4   variables   (logo-meta.scm is also affected)

(define (make env var val) 
  (error "make not written yet!") ;see logo-meta.scm
  '=no-value= ) 


;;; Here are the primitives RUN, IF, and IFELSE.  Problem B2 provides
;;; support for these, but you don't have to modify them.   

(define (run env exp)
  (eval-line (make-line-obj exp) env))

(define (logo-if env t/f exp) 
  (cond ((eq? t/f 'true) (eval-line (make-line-obj exp) env))
        ((eq? t/f 'false) '=no-value=)
        (else (error "Input to IF not true or false " t/f))))  

(define (ifelse env t/f exp1 exp2)  
  (cond ((eq? t/f 'true) (eval-line (make-line-obj exp1) env))
        ((eq? t/f 'false) (eval-line (make-line-obj exp2) env))   
        (else (error "Input to IFELSE not true or false " t/f))))  


;;; Problem B2   logo-pred

(define (logo-pred-1 pred)   
  (lambda (x) (if (pred x)
                  'TRUE
                  'FALSE
              ))
) 
(define (logo-pred-2 pred)   
  (lambda (x y) (if (pred x y)
                  'TRUE
                  'FALSE
              ))
) 

;not correct
(define (logo-pred pred)  
  (define (iter li arg-li)
    (if (null? arg-li)
      li
      (iter (append li (list (car arg-li))) (cdr arg-li))
    )
  )
  (lambda (x . y)
              (if (null? y)
                (if (pred x)
                    'TRUE
                    'FALSE
                )
                (iter (append (list pred) (list x)) y)
              )
  ) 
) 

;testing:
;(eval ((logo-pred equal?) 1 2))
;(eval ((logo-pred equal?) 2 2))
;((logo-pred empty?) 1);> false
;((logo-pred equal?) 1 2);> false
;((logo-pred-2 equal?) 2 2)
;;; Here is an example of a Scheme predicate that will be turned into  
;;; a Logo predicate by logo-pred:  

(define (equalp a b)
  (if (and (number? a) (number? b))  
      (= a b)   
      (equal? a b)))   


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;  Stuff below here is needed for the interpreter to work but you  ;;;  
;;;  don't have to modify anything or understand how they work.      ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


;;; The Logo reader

(define left-paren-symbol (string->symbol (make-string 1 #\( )))
(define right-paren-symbol (string->symbol (make-string 1 #\) )))
(define quote-symbol (string->symbol (make-string 1 #\" )))

(define (logo-read)  
  (define lookahead #f)   
  (define (logo-read-help depth)   
    (define (get-char)  
      (if lookahead  
          (let ((char lookahead))   
            (set! lookahead #f)   
            char) 
          (let ((char (read-char)))   
            (if (eq? char #\\)
                (list (read-char))  
                char)))) 
    (define (quoted char)   
      (if (pair? char)   
          char 
          (list char)))  
    (define (get-symbol char)   
      (define (iter sofar char)
        (cond ((pair? char) (iter (cons (car char) sofar) (get-char))) 
              ((memq char  
                     '(#\space #\newline #\+ #\- #\* #\/  
                               #\= #\< #\> #\( #\) #\[ #\] ))
               (set! lookahead char)   
               sofar) 
              (else (iter (cons char sofar) (get-char))) ))   
      (string->word (list->string (reverse (iter '() char)))) )
    (define (get-token space-flag)   
      (let ((char (get-char)))   
              (cond ((eq? char #\space) (get-token #t))  
              ((memq char '(#\+ #\* #\/ #\= #\< #\> #\( #\) ))   
               (string->symbol (make-string 1 char)))
              ((eq? char #\-)   
               (if space-flag  
                   (let ((char (get-char)))   
                     (let ((result (if (eq? char #\space)  
                                       '- 
                                       '=unary-minus=))) 
                       (set! lookahead char)   
                       result)) 
                   '-)) 
              ((eq? char #\[) (logo-read-help (+ depth 1)))  
              ((pair? char) (get-symbol char))
              ((eq? char #\")   
               (let ((char (get-char)))   
                 (if (memq char '(#\[ #\] #\newline))  
                     (begin (set! lookahead char) quote-symbol)
                     (string->symbol (word quote-symbol
					   (get-symbol (quoted char)))))))
	      (else (get-symbol char)) )))

    (define (after-space)
      (let ((char (get-char)))
	(if (eq? char #\space)
	    (after-space)
	    char)))
    (let ((char (get-char)))   
      (cond ((eq? char #\newline)
             (if (> depth 0) (set! lookahead char))   
             '()) 
	    ((eq? char #\space)
	     (let ((char (after-space)))
	       (cond ((eq? char #\newline)
		      (begin (if (> depth 0) (set! lookahead char))
			     '()))
		     ((eq? char #\])
		      (if (> depth 0) '() (error "Unexpected ]")))
		     (else (set! lookahead char)
			   (let ((token (get-token #t)))
			     (cons token (logo-read-help depth)))))))
            ((eq? char #\])   
             (if (> depth 0) '() (error "Unexpected ]")))
            ((eof-object? char) char)   
            (else (set! lookahead char)
                  (let ((token (get-token #f)))
                    (cons token (logo-read-help depth)) ))))) 
  (logo-read-help 0))  


;;; Assorted stuff   

(define (make-logo-arith op)   
  (lambda args (apply op (map maybe-num args))))   

(define (maybe-num val)
  (if (word? val)
      (string->word (word->string val))
      val))

(define tty-port (current-input-port))   

(define (prompt string)   
  (if (eq? (current-input-port) tty-port)
  (begin (display string) (flush))))  

(define (meta-load fn)   
  (define (loader)  
    (let ((exp (logo-read)))   
      (if (eof-object? exp)   
          '() 
          (begin 
            (eval-line (make-line-obj exp) the-global-environment) 
		        (loader)
          )))) 
  (with-input-from-file (symbol->string fn) loader)
  '=no-value= ) 
