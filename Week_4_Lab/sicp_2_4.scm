(define (cons x y) 
  (lambda (m) (m x y)))

(define (car z) 
  (z (lambda (p q) p)))


;make it work
  (define f (cons 1 2))
  (car f);>1

; cdr
(define (cdr z)
(z (lambda (p q) q)))
(cdr f);>2